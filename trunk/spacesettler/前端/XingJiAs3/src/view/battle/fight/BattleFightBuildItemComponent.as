package view.battle.fight
{
    import com.zn.utils.ClassUtil;
    import com.zn.utils.StringUtil;

    import enum.battle.BattleBuildStateEnum;

    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.Sprite;

    import mx.binding.utils.BindingUtils;

    import ui.core.Component;
    import ui.utils.DisposeUtil;

    import vo.battle.BattleBuildVO;

    /**
     *战场建筑
     * @author zn
     *
     */
    public class BattleFightBuildItemComponent extends Component
    {
        private var _buildVO:BattleBuildVO;

        private var _buildSp:Sprite;

        public function BattleFightBuildItemComponent()
        {
            super(null);
			
			buttonMode=true;
        }

        public function get buildVO():BattleBuildVO
        {
            return _buildVO;
        }

        public function set buildVO(value:BattleBuildVO):void
        {
            _buildVO = value;

            removeCWList();

            cwList.push(BindingUtils.bindSetter(stateChange, buildVO, "state"));
            x = value.x;
            y = value.y;
        }

        private function stateChange(value:*):void
        {
            DisposeUtil.dispose(_buildSp);

            var className:String = "";

            if (buildVO.state == BattleBuildStateEnum.normal)
            {
                if (buildVO.type == 1 || buildVO.type == 2)
                    className = StringUtil.formatString("build_icon_{0}_normal", buildVO.type);
                else
                    className = StringUtil.formatString("battle.build_{0}", buildVO.type);

                _buildSp = ClassUtil.getObject(className);
                if (turretMC)
                    turretMC.gotoAndStop(1);

                addChild(_buildSp);
            }
        }

        public function get turretMC():MovieClip
        {
            return _buildSp.getChildByName("taMC") as MovieClip;
        }
    }
}
