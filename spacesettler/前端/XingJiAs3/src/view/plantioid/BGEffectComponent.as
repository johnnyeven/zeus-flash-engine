package view.plantioid
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Linear;
    import com.zn.utils.ClassUtil;
    
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    
    import mx.effects.Tween;
    
    import ui.core.Component;
    import ui.managers.SystemManager;

    /**
     *背景
     * @author zn
     *
     */
    public class BGEffectComponent extends Component
    {

        private var _xingSp1:Sprite;

        private var _xingSp2:Sprite;

        private var _time:int = 100;

        private var _tweenMoveToLeftOut:TweenLite;

        private var _tweenMoveToLeft:TweenLite;

        public function BGEffectComponent()
        {
            super(null);

            _xingSp1 = ClassUtil.getObject("plantioid.bgXingXingSkin");
            addChild(_xingSp1);
			moveToLeftOut(_xingSp1);
			
            _xingSp2 = ClassUtil.getObject("plantioid.bgXingXingSkin");
            addChild(_xingSp2);
			moveToLeft(_xingSp2);
        }

        public override function dispose():void
        {
			if(_tweenMoveToLeftOut)
				_tweenMoveToLeftOut.kill();
			if(_tweenMoveToLeft)
				_tweenMoveToLeft.kill();

			_tweenMoveToLeft = _tweenMoveToLeftOut = null;
            super.dispose();

        }

        private function moveToLeftOut(sp:Sprite):void
        {
            sp.x = 0;
            var endX:Number = -SystemManager.rootStage.stageWidth*2;
            _tweenMoveToLeftOut=TweenLite.to(sp, _time, { x: endX, ease: Linear.easeNone, onComplete: moveToLeft, onCompleteParams: [ sp ]});
        }

        private function moveToLeft(sp:Sprite):void
        {
            sp.x = SystemManager.rootStage.stageWidth*2;
            var endX:Number = 0;
           _tweenMoveToLeft=TweenLite.to(sp, _time, { x: endX, ease: Linear.easeNone, onComplete: moveToLeftOut, onCompleteParams: [ sp ]});
        }
		
    }
}
