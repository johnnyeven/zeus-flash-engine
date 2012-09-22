package controller
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
    
    import vo.userInfo.UserInfoVO;

    /**
     *进入主场景
     * @author zn
     *
     */
    public class EnterMainSenceViewCommand extends SimpleCommand
    {
        public static const ENTER_MAIN_SENCE_VIEW_COMMAND:String = "EnterMainSenceViewCommand.ENTER_MAIN_SENCE_VIEW_COMMAND";

		private static var _isLoading:Boolean = false;
		
        public function EnterMainSenceViewCommand()
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
			if(_isLoading)
				return ;
			
			_isLoading=true;
			
			var loaderMax:LoaderMax = new LoaderMax("loaderMainSence");
			
			var userInfoVO:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			loaderMax.addChildLoad(LoaderItemUtil.getLoader("mainSence"+userInfoVO.camp));
			
			loaderMax.addChildLoad(LoaderItemUtil.getLoader("mainView.swf"));
			
			ResLoader.load("loaderMainSence", MultilanguageManager.getString("loaderMainSence"), loaderCompleteHandler,true);
        }

        protected function loaderCompleteHandler(event:LoaderEvent):void
        {
			//主场景
			sendNotification(MainSenceComponentMediator.SHOW_NOTE);
			
            //主界面
            sendNotification(MainViewMediator.SHOW_NOTE);
			
			_isLoading=false;
        }
    }
}
