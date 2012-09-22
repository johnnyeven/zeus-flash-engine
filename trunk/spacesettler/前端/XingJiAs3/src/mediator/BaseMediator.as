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
        protected var _popUp:Boolean = true;

        public var mode:Boolean = false;

        public var childMedList:Array = [];

        public var destoryCallback:Function = null;

        public var showCallBack:Function = null;

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
                uiComp.y = SystemManager.rootStage.stageHeight;

                PopUpManager.addPopUp(uiComp, mode);

                var centerPoint:Point = UIUtil.stageCenterPoint(uiComp);
                uiComp.x = centerPoint.x;

                TweenLite.to(uiComp, 0.4, {  y: centerPoint.y , onComplete: showComplete });
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
			if(viewComponent)
			{
	            if (_popUp)
	            {
	                TweenLite.to(uiComp, 0.4, { y: SystemManager.rootStage.stageHeight, ease: Linear.easeNone, onComplete: function():void
	                {
	                    PopUpManager.removePopUp(uiComp);
	
	                    if (uiComp is Component)
	                        (uiComp as Component).dispose();
	                    viewComponent = null;
	
	                    callDestoryCallBack();
	                }});
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
