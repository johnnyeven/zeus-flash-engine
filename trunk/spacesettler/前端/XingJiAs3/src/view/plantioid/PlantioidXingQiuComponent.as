package view.plantioid
{
    import com.greensock.TimelineLite;
    import com.greensock.TweenLite;
    import com.greensock.easing.Linear;
    import com.zn.utils.ClassUtil;
    import com.zn.utils.ColorUtil;
    import com.zn.utils.OddsUtil;
    import com.zn.utils.StringUtil;
    
    import enum.plantioid.PlantioidTypeEnum;
    
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    
    import ui.components.Label;
    import ui.core.Component;
    
    import vo.plantioid.FortsInforVO;

    /**
     *星球
     * @author zn
     *
     */
    public class PlantioidXingQiuComponent extends Component
    {
        public var xingQiuSp:Sprite;

        public var bgSp:Sprite;
		
		public var titleBG:Sprite;
		
		public var pointLabel:Label;
		
		public var titleLabel:Label;

        private var _platioidVO:FortsInforVO;

        private var _rotationTimeLine:TimelineLite;

        public function PlantioidXingQiuComponent()
        {
            super(ClassUtil.getObject("plantioid.PlantioidInfo"));

            xingQiuSp = getSkin("xingQiuSp");
            bgSp = getSkin("bgSp");
			
			pointLabel = createUI(Label, "pointLabel");
			titleLabel = createUI(Label, "titleLabel");

			titleBG=getSkin("titleBG");
			
            sortChildIndex();
        }

        public override function dispose():void
        {
            _rotationTimeLine.kill();
            _rotationTimeLine = null;
            super.dispose();

        }

        public function get platioidVO():FortsInforVO
        {
            return _platioidVO;
        }

        public function set platioidVO(value:FortsInforVO):void
        {
            _platioidVO = value;

            xingQiuSp.addChild(ClassUtil.getObject("plantioid.xinQiu_" + value.fort_type));

            setSize(bgSp, 40);

            rotationXingQiu();

			titleLabel.text=platioidVO.fort_name;
			pointLabel.text=StringUtil.formatString("{0}:{1}:{2}",platioidVO.x,platioidVO.y,platioidVO.z);
			
            switch (platioidVO.type)
            {
                case PlantioidTypeEnum.NO_OWN:
                {
                    ColorUtil.restore(bgSp);
					ColorUtil.restore(titleBG);
					
//					ColorUtil.tint(bgSp, 0xFFFFFF, 1);
//					ColorUtil.tint(titleBG, 0xFFFFFF, 1);
                    break;
                }
                case PlantioidTypeEnum.NPC:
                {
                    ColorUtil.tint(bgSp, 0xFFCC00, 1);
					ColorUtil.tint(titleBG, 0xFFCC00, 1);
                    break;
                }
                case PlantioidTypeEnum.OWN:
                {
                    ColorUtil.tint(bgSp, 0x33FF00, 1);
					ColorUtil.tint(titleBG, 0x33FF00, 1);
                    break;
                }
                case PlantioidTypeEnum.ENEMY:
                {
                    ColorUtil.tint(bgSp, 0xFF0000, 1);
					ColorUtil.tint(titleBG, 0xFF0000, 1);
                    break;
                }
                case PlantioidTypeEnum.CAMP:
                {
                    ColorUtil.tint(bgSp, 0x00CCFF, 1);
					ColorUtil.tint(titleBG, 0x00CCFF, 1);
                    break;
                }
            }
        }

        public function setSize(obj:DisplayObject, range:Number):void
        {
            var s:Number;

			obj.scaleX = obj.scaleY =1;
			
            if (xingQiuSp.width > xingQiuSp.height)
                s = (xingQiuSp.width + range) / obj.width;
            else
                s = (xingQiuSp.height + range) / obj.height;

            obj.scaleX = obj.scaleY = s;
        }

        private function rotationXingQiu():void
        {
            var rotation:int = 360;
            if (OddsUtil.getDrop(0.5))
                rotation = -rotation;
			if(_rotationTimeLine)
				_rotationTimeLine.kill();
            _rotationTimeLine = new TimelineLite({ onComplete: rotationXingQiu });
            _rotationTimeLine.insert(TweenLite.to(xingQiuSp, 60, { rotation: rotation, ease: Linear.easeNone }));
            _rotationTimeLine.insert(TweenLite.to(bgSp, 60, { rotation: -rotation, ease: Linear.easeNone }));
        }
    }
}
