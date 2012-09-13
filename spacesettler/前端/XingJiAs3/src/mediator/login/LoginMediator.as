package mediator.login
{
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.StringUtil;
    import events.login.LoginEvent;

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
            super(NAME, new LoginComponent());

            comp.addEventListener(LoginEvent.LOGIN_EVENT, loginHandler);
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
                sendNotification(PromptMediator.SCROLL_ALERT_NOTE, MultilanguageManager.getString("loginInfoEmpty"));
                return;
            }
            var myProxy:LoginProxy = getProxy(LoginProxy);
            myProxy.login(event.userName, event.password);
        }
    }
}
