package controller.plantioid
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    
    import enum.SenceTypeEnum;
    
    import mediator.BaseMediator;
    import mediator.plantioid.PlantioidComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import proxy.plantioid.PlantioidProxy;
    
    import vo.GlobalData;

    /**
     *小星星带
     * @author zn
     *
     */
    public class ShowPlantioidComponentMediatorCommand extends SimpleCommand
    {
        private static var _isLoading:Boolean = false;

        public static var loadCompleteCallBack:Function;

        public function ShowPlantioidComponentMediatorCommand()
        {
            super();
        }

        /**
         *执行
         * @param notification
         *
         */
        public override function execute(notification:INotification):void
        {
            if (_isLoading)
                return;

            var plantioidProxy:PlantioidProxy = getProxy(PlantioidProxy);
            plantioidProxy.getPlantioidListByXY(1, 1, function():void
            {
                var med:PlantioidComponentMediator = getMediator(PlantioidComponentMediator);
                if (med)
                {
                    callShow(med);
                }
                else
                {
                    //加载界面SWF
                    _isLoading = true;
                    ResLoader.load("planetoid.swf", MultilanguageManager.getString(""), loaderComplete,true);
                }
            });
        }

        /**
         *界面加载完毕
         * @param loaderCore 被加载进来的对象
         *
         */
        protected function loaderComplete(event:LoaderEvent):void
        {
            var med:PlantioidComponentMediator = new PlantioidComponentMediator();

            //注册界面的中介
            facade.registerMediator(med);

            _isLoading = false;

            callShow(med);
        }

        private function callShow(med:BaseMediator):void
        {
            if (loadCompleteCallBack != null)
            {
                loadCompleteCallBack(med);
                loadCompleteCallBack = null;
            }
            else
            {
                med.show();
            }
			
			GlobalData.currentSence=SenceTypeEnum.PLANT;
        }
    }
}
