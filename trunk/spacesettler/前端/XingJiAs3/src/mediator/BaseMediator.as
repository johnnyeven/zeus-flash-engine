package mediator
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Linear;

    import flash.display.DisplayObject;

    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.patterns.mediator.Mediator;

    import ui.core.Component;
    import ui.managers.PopUpManager;

    /**
     *基础
     * @author zn
     *
     */
    public class BaseMediator extends Mediator implements IMediator
    {
        protected var _popUp:Boolean = true;
		public var mode:Boolean=false;

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
                if (uiComp.scaleX == 1)
                {
                    uiComp.scaleX = uiComp.scaleY = 0.6;
                    uiComp.alpha = 0.5;
                }

                PopUpManager.addPopUp(uiComp,mode);
                PopUpManager.centerPopUp(uiComp);

                TweenLite.to(uiComp, 0.2, { transformAroundCenter: { scaleX: 1, scaleY: 1, alpha: 1 }, ease: Linear.easeNone, onComplete: showComplete });
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
            if (_popUp)
            {
                TweenLite.to(uiComp, 0.2, { transformAroundCenter: { scaleX: 0.6, scaleY: 0.6, alpha: 0.5 }, ease: Linear.easeNone, onComplete: function():void
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
			
			destoryCallback=null;
        }
    }
}
