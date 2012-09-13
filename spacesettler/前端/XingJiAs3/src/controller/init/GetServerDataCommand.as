package controller.init
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.loading.LoaderMax;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.LoaderItemUtil;
    
    import enum.MainSenceEnum;
    
    import flash.events.Event;
    
    import mediator.mainSence.MainSenceComponentMediator;
    import mediator.mainView.MainViewMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import proxy.userInfo.UserInfoProxy;

    /**
     *登陆后获取信息
     * @author zn
     *
     */
    public class GetServerDataCommand extends SimpleCommand
    {
        public static const GET_SERVER_DATA_COMMAND:String = "GetServerDataCommand.GET_SERVER_DATA_COMMAND";

        private var _requestCount:int = 0;

        public function GetServerDataCommand()
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
            _requestCount = 1;

            //显示加载进度条，设置加载条标题
            sendNotification(ResLoader.SET_LOADER_BAR_TITLE_NOTE, MultilanguageManager.getString("getServerData"));
            sendNotification(ResLoader.SHOW_LOADER_BAR_NOTE);

            var userProxy:UserInfoProxy = getProxy(UserInfoProxy);
            userProxy.getUserInfo(getDateComplete);
        }

        public function getDateComplete():void
        {
            _requestCount--;
            if (_requestCount == 0)
            {
				
				sendNotification(ResLoader.HIDE_LOADER_BAR_NOTE);

                var loaderMax:LoaderMax = new LoaderMax("loaderMainSence");
                loaderMax.addChildLoad(LoaderItemUtil.createLoader(MainSenceEnum.campBGURL));
                loaderMax.addChildLoad(LoaderItemUtil.getLoader("mainView.swf"));

                ResLoader.load("loaderMainSence", MultilanguageManager.getString("loaderMainSence"), loaderCompleteHandler);
            }
        }

        protected function loaderCompleteHandler(event:LoaderEvent):void
        {
			//主场景
			sendNotification(MainSenceComponentMediator.SHOW_NOTE);
			
            //主界面
            sendNotification(MainViewMediator.SHOW_NOTE);
        }
    }
}
