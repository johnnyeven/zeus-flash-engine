package view.plantioid.plantioidInfo
{
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.DateFormatter;
    import com.zn.utils.StringUtil;

    import enum.CenterTechTypeEnum;
    import enum.ResEnum;
    import enum.plantioid.PlantioidTypeEnum;

    import events.plantioid.PlantioidEvent;

    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import ui.components.Button;
    import ui.components.Label;
    import ui.core.Component;

    import vo.plantioid.FortsInforVO;

    /**
     *星球信息
     * @author zn
     *
     */
    public class InfoComponent extends Component
    {
        public var canLiangItem_1:InfoResItemCompnent;

        public var canLiangItem_0:InfoResItemCompnent;

        public var areaLabel:Label;

        public var techLabel:Label;

        public var attackLabel:Label;

        public var stateLabel:Label;

        public var nameLabel:Label;

        public var bg2:Sprite;

        public var bg1:Sprite;

        public var managerBtn:Button;

        public var forceAttackBtn:Button;

        public var attackBtn:Button;

        public var selectedEffectMC:MovieClip;

        private var _plantVO:FortsInforVO;

        private var _time:Timer;

        public function InfoComponent(skin:DisplayObjectContainer)
        {
            super(skin);

            canLiangItem_1 = createUI(InfoResItemCompnent, "canLiangItem_1");
            canLiangItem_0 = createUI(InfoResItemCompnent, "canLiangItem_0");

            areaLabel = createUI(Label, "areaLabel");
            techLabel = createUI(Label, "techLabel");
            attackLabel = createUI(Label, "attackLabel");
            stateLabel = createUI(Label, "stateLabel");
            nameLabel = createUI(Label, "nameLabel");

            bg2 = getSkin("bg2");
            bg1 = getSkin("bg1");

            managerBtn = createUI(Button, "managerBtn");
            forceAttackBtn = createUI(Button, "forceAttackBtn");
            attackBtn = createUI(Button, "attackBtn");

            selectedEffectMC = getSkin("selectedEffectMC");

            sortChildIndex();

            removeChild(selectedEffectMC);

            _time = new Timer(1000);
            _time.addEventListener(TimerEvent.TIMER, timerHandler);

            managerBtn.addEventListener(MouseEvent.CLICK, btn_clickHandler);
            forceAttackBtn.addEventListener(MouseEvent.CLICK, btn_clickHandler);
            attackBtn.addEventListener(MouseEvent.CLICK, btn_clickHandler);
        }

        public override function dispose():void
        {
            super.dispose();
            _time.stop();
            _time.removeEventListener(TimerEvent.TIMER, timerHandler);

            _time = null;
        }

        public function get plantVO():FortsInforVO
        {
            return _plantVO;
        }

        public function set plantVO(value:FortsInforVO):void
        {
            _plantVO = value;

            if (plantVO)
            {
                addChildAt(selectedEffectMC, 0);

                bg2.visible = bg1.visible = true;
                hideBtn();

                if (plantVO.type == PlantioidTypeEnum.NPC)
                    bg1.visible = true;
                else
                    bg2.visible = true;

                nameLabel.text = plantVO.fort_name;
                if (plantVO.type == PlantioidTypeEnum.NPC && plantVO.protectedRemainTime > 0)
                {
                    _time.start();
                    forceAttackBtn.visible = true;
                }
                else
                    setNormalState();

                techLabel.text = CenterTechTypeEnum["type_" + plantVO.level];
                areaLabel.text = StringUtil.formatString("x:{0}-y:{1}-{2}", plantVO.x, plantVO.y, plantVO.z);

                canLiangItem_0.visible = false;
                canLiangItem_1.visible = false;

                var index:int = 0;
                if (plantVO.crystal_output != 0)
                {
                    this["canLiangItem_" + index].setItemVO(ResEnum.crystalIconURL, plantVO.crystal_output);
                    this["canLiangItem_" + index].visible = true;
                    index++;
                }

                if (plantVO.broken_crystal_output != 0)
                {
                    this["canLiangItem_" + index].setItemVO(ResEnum.brokenCrystalIconURL, plantVO.broken_crystal_output);
                    this["canLiangItem_" + index].visible = true;
                    index++;
                }
            }
            else
            {
                if (contains(selectedEffectMC))
                    removeChild(selectedEffectMC);

                _time.stop();
            }
        }

        private function hideBtn():void
        {
            managerBtn.visible = forceAttackBtn.visible = attackBtn.visible = false;
        }


        protected function timerHandler(event:TimerEvent):void
        {
            if (plantVO.protectedRemainTime == 0)
            {
                _time.stop();

                setNormalState();

                return;
            }

            stateLabel.text = StringUtil.formatString("{0}({1})", MultilanguageManager.getString("plantStateBaoFuZhong"), DateFormatter.formatterTime(plantVO.protectedRemainTime));
            attackLabel.text = MultilanguageManager.getString("plantStateBaoFuStr");
        }

        private function setNormalState():void
        {
            hideBtn();

            stateLabel.text = MultilanguageManager.getString("plantStateNormalStr");
            if (plantVO.type == PlantioidTypeEnum.NPC)
            {
                attackLabel.text = MultilanguageManager.getString("plantStateKeGongJi");
            }
            else
                attackLabel.text = MultilanguageManager.getString("plantStateKeGongJi") + "、" + MultilanguageManager.getString("plantStateKeZhanLing");

            if (plantVO.type == PlantioidTypeEnum.OWN)
                managerBtn.visible = true;
            else
                attackBtn.visible = true;
        }

        /**
         *按钮点击
         * @param event
         *
         */
        protected function btn_clickHandler(event:MouseEvent):void
        {
            switch (event.currentTarget)
            {
                case managerBtn:
                {
                    dispatchEvent(new PlantioidEvent(PlantioidEvent.MANAGER_EVENT, plantVO.id));
                    break;
                }
                case attackBtn:
                {
                    dispatchEvent(new PlantioidEvent(PlantioidEvent.ATTACK_EVENT, plantVO.id));
                    break;
                }
                case forceAttackBtn:
                {
                    dispatchEvent(new PlantioidEvent(PlantioidEvent.FORCE_ATTACK_EVENT, plantVO.id));
                    break;
                }
            }
        }
    }
}
