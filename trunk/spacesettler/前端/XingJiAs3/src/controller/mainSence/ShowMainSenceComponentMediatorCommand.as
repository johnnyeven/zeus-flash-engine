package controller.mainSence
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import enum.MainSenceEnum;
    
    import mediator.BaseMediator;
    import mediator.mainSence.MainSenceComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import proxy.userInfo.UserInfoProxy;
    
    import vo.userInfo.UserInfoVO;

    /**
     *主场景
     * @author zn
     *
     */
    public class ShowMainSenceComponentMediatorCommand extends SimpleCommand
    {
        private static var _isLoading:Boolean = false;

        public static var loadCompleteCallBack:Function;

        public function ShowMainSenceComponentMediatorCommand()
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

            var med:MainSenceComponentMediator = getMediator(MainSenceComponentMediator);
            if (med)
            {
                callShow(med);
            }
            else
            {
                //加载界面SWF
                _isLoading = true;
				
				var userInfoVO:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
                ResLoader.load("mainSence"+userInfoVO.camp, MultilanguageManager.getString(""), loaderComplete,true);
            }
        }

        /**
         *界面加载完毕
         * @param loaderCore 被加载进来的对象
         *
         */
        protected function loaderComplete(event:LoaderEvent):void
        {
            var med:MainSenceComponentMediator = new MainSenceComponentMediator();

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
        }
    }
}
