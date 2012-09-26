package mediator
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Linear;
    
    import flash.display.DisplayObject;
    import flash.geom.Point;
    
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.patterns.mediator.Mediator;
    
    import ui.core.Component;
    import ui.managers.PopUpManager;
    import ui.managers.SystemManager;
    import ui.utils.UIUtil;

    /**
     *基础
     * @author zn
     *
     */
    public class BaseMediator extends Mediator implements IMediator
    {
		public static const CENTER:int=0;
		public static const UP:int=1;
		public static const RIGHT:int=2;
		
        protected var _popUp:Boolean = true;

        public var mode:Boolean = false;

        public var childMedList:Array = [];

        public var destoryCallback:Function = null;

        public var showCallBack:Function = null;

        public var popUpEffect:int =RIGHT;

		public var level:int=1;		
		
        public function BaseMediator(name:String, viewComponent:Object = null)
        {
            super(name, viewComponent);
        }

        public function get uiComp():DisplayObject
        {
            return viewComponent as DisplayObject;
        }

        /**
         *显示界面
         *
         */
        public function show():void
        {
            if (isShow)
                return;

            addUIComp();
        }

        protected function addUIComp():void
        {
            if (_popUp)
            {
				
				PopUpManager.closeAll(level);
				
                PopUpManager.addPopUp(uiComp, mode);

                var centerPoint:Point = UIUtil.stageCenterPoint(uiComp);
                if (popUpEffect==UP)
                {
                    //toUp
                    uiComp.y = SystemManager.rootStage.stageHeight;
                    uiComp.x = centerPoint.x;

                    TweenLite.to(uiComp, 0.4, { y: centerPoint.y, onComplete: showComplete });
                }
                else if(popUpEffect==RIGHT)
                {
                    //toLeft
                    uiComp.x = SystemManager.rootStage.stageWidth;
                    uiComp.y = 31;
                    var endX:Number = uiComp.x - uiComp.width;
                    TweenLite.to(uiComp, 0.4, { x: endX, onComplete: showComplete });
                }
				else
				{
					if (uiComp.scaleX == 1)
					{
						uiComp.scaleX = uiComp.scaleY = 0.6;
						uiComp.alpha = 0.5;
					}
					
					PopUpManager.addPopUp(uiComp,mode);
					UIUtil.centerUI(uiComp);
					
					TweenLite.to(uiComp, 0.4, { transformAroundCenter: { scaleX: 1, scaleY: 1, alpha: 1 }, ease: Linear.easeNone, onComplete: showComplete });
				}

            }
            else
            {
                MainMediator(getMediator(MainMediator)).addChild(uiComp);
                showComplete();
            }
        }

        public function showComplete():void
        {
            if (showCallBack != null)
                showCallBack(this);

            showCallBack = null;
        }

        public function destroy():void
        {
            if (viewComponent)
            {
                if (_popUp)
                {
                    if (popUpEffect==UP)
                    {
                        //toDown
                        TweenLite.to(uiComp, 0.4, { y: SystemManager.rootStage.stageHeight, ease: Linear.easeNone, onComplete: removeTweenLiteComplete });
                    }
                    else if(popUpEffect==RIGHT)
                    {
                        //toRight
                        TweenLite.to(uiComp, 0.4, { x: SystemManager.rootStage.stageWidth, ease: Linear.easeNone, onComplete: removeTweenLiteComplete });
                    }
					else
					{
						TweenLite.to(uiComp, 0.4, { transformAroundCenter: { scaleX: 0.6, scaleY: 0.6, alpha: 0.5 }, ease: Linear.easeNone, onComplete: function():void
						{
							PopUpManager.removePopUp(uiComp);
							
							if (uiComp is Component)
								(uiComp as Component).dispose();
							viewComponent = null;
							
							callDestoryCallBack();
						}});
					}
                }
                else
                {
                    if (uiComp is Component)
                        (uiComp as Component).dispose();
                    viewComponent = null;

                    callDestoryCallBack();
                }
            }
            else
            {
                callDestoryCallBack();
            }
            removeCWList();

            while (childMedList.length > 0)
                sendNotification(childMedList.pop());

            childMedList = null;

            facade.removeMediator(getMediatorName());
        }

        private function removeTweenLiteComplete():void
        {
            PopUpManager.removePopUp(uiComp);

            if (uiComp is Component)
                (uiComp as Component).dispose();
            viewComponent = null;

            callDestoryCallBack();
        }

        public function get isShow():Boolean
        {
            return uiComp.stage == null ? false : true;
        }

        private function callDestoryCallBack():void
        {
            if (destoryCallback != null)
                destoryCallback();

            destoryCallback = null;
        }
    }
}
