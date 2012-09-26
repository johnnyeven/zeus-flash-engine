package view.plantioid
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Linear;
    import com.zn.utils.ClassUtil;
    import com.zn.utils.OddsUtil;
    
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    
    import ui.core.Component;
    
    import vo.plantioid.FortsInforVO;

    /**
     *星球
     * @author zn
     *
     */
    public class PlantioidXingQiuComponent extends Component
    {
        public var selectedEffectMC:MovieClip;

        public var xingQiuSp:Sprite;

        public var bgSp:Sprite;

        private var _platioidVO:FortsInforVO;

        private var _rotationXingQiuTweenLite:TweenLite;
        private var _rotationBGTweenLite:TweenLite;

        public function PlantioidXingQiuComponent()
        {
            super(ClassUtil.getObject("plantioid.PlantioidInfo"));

            selectedEffectMC = getSkin("selectedEffectMC");
			
            xingQiuSp = getSkin("xingQiuSp");
            bgSp = getSkin("bgSp");

            sortChildIndex();
			
			removeChild(selectedEffectMC);
        }

        public override function dispose():void
        {
            super.dispose();

            _rotationXingQiuTweenLite.kill();
            _rotationXingQiuTweenLite = null;
			
			_rotationBGTweenLite.kill();
			_rotationBGTweenLite = null;
        }

        public function get platioidVO():FortsInforVO
        {
            return _platioidVO;
        }

        public function set platioidVO(value:FortsInforVO):void
        {
            _platioidVO = value;

            xingQiuSp.addChild(ClassUtil.getObject("plantioid.xinQiu_" + value.fort_type));

			setSize(bgSp,30);
			setSize(selectedEffectMC,60);

            rotationXingQiu();
			rotationBG();
        }
		
		private function setSize(obj:DisplayObject,range:Number):void
		{
			var s:Number;
			
			if(xingQiuSp.width>xingQiuSp.height)
				s=(xingQiuSp.width+range)/obj.width;
			else
				s=(xingQiuSp.height+range)/obj.height;
			
			obj.scaleX=obj.scaleY=s;
		}

        private function rotationXingQiu():void
        {
            var rotation:int = 360;
            if (OddsUtil.getDrop(0.5))
                rotation = -rotation;
            _rotationXingQiuTweenLite = TweenLite.to(xingQiuSp, 60, { rotation: rotation, ease: Linear.easeNone, onComplete: rotationXingQiu });
        }
		
		private function rotationBG():void
		{
			var rotation:int = 360;
			if (OddsUtil.getDrop(0.5))
				rotation = -rotation;
			_rotationBGTweenLite = TweenLite.to(bgSp, 60, { rotation: rotation, ease: Linear.easeNone, onComplete: rotationBG });
		}
    }
}
