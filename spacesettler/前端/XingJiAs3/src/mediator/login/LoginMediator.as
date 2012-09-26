package mediator.login
{
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.StringUtil;
    
    import events.login.LoginEvent;
    
    import flash.events.Event;
    
    import mediator.BaseMediator;
    import mediator.prompt.PromptMediator;
    
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;
    
    import proxy.login.LoginProxy;
    
    import view.login.LoginComponent;

    /**
     * 登录
     * @author zn
     *
     */
    public class LoginMediator extends BaseMediator implements IMediator
    {
        public static const NAME:String = "LoginMediator";

        public static const SHOW_NOTE:String = "show" + NAME + "Note";

        public static const DESTROY_NOTE:String = "destroy" + NAME + "Note";
		
		
        public function LoginMediator(viewComponent:Object = null)
        {
			StartComponentMediator.addBG();
			
            super(NAME, new LoginComponent());
			popUpEffect=UP;
            comp.addEventListener(LoginEvent.LOGIN_EVENT, loginHandler);
			comp.addEventListener(LoginEvent.BACK_EVENT,backHandler);
        }
		
		
        /**
         *添加要监听的消息
         * @return
         *
         */
        override public function listNotificationInterests():Array
        {
            return [ DESTROY_NOTE ];
        }

        /**
         *消息处理
         * @param note
         *
         */
        override public function handleNotification(note:INotification):void
        {
            switch (note.getName())
            {
                case DESTROY_NOTE:
                {
                    //销毁对象
                    destroy();
					sendNotification(PromptMediator.HIDE_LOGIN_INFO_NOTE);
                    break;
                }
            }
        }

        /**
         *获取界面
         * @return
         *
         */
        protected function get comp():LoginComponent
        {
            return viewComponent as LoginComponent;
        }

        protected function loginHandler(event:LoginEvent):void
        {
			if (StringUtil.isEmpty(event.userName))
			{
				sendNotification(PromptMediator.SHOW_LOGIN_INFO_NOTE, MultilanguageManager.getString("loginUserNameEmpty"));
				return;
			}
			else if(event.userName.length < 6)
			{
				sendNotification(PromptMediator.SHOW_LOGIN_INFO_NOTE, MultilanguageManager.getString("loginNaneWrong"));
				return;
			}
			else if (StringUtil.isEmpty(event.password))
			{
				sendNotification(PromptMediator.SHOW_LOGIN_INFO_NOTE, MultilanguageManager.getString("loginPasswordEmpty"));
				return;
			}

			else if(event.password.length < 6)
			{
				sendNotification(PromptMediator.SHOW_LOGIN_INFO_NOTE, MultilanguageManager.getString("loginPasswordWrong"));
				return;
			}
			
			var myProxy:LoginProxy = getProxy(LoginProxy);
			myProxy.login(event.userName, event.password);
        }
		
		private function backHandler(event:LoginEvent):void
		{
			destoryCallback = function():void
			{
				sendNotification(StartComponentMediator.SHOW_NOTE);
			};
			sendNotification(DESTROY_NOTE);
		}
    }
}
