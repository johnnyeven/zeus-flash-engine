package controller.login
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    
    import mediator.login.LoginMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    /**
     *显示登录界面命令
     * @author zn
     *
     */
    public class ShowLoginMediatorCommand extends SimpleCommand
    {
        public function ShowLoginMediatorCommand()
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
            var med:LoginMediator =getMediator(LoginMediator);
            if (med)
            {
                med.show();
            }
            else
            {
                //加载界面SWF
                ResLoader.load("login.swf", MultilanguageManager.getString("loaderLogin"), loaderComplete,true);
            }
        }

        /**
         *界面加载完毕
         * @param loaderCore 被加载进来的对象
         *
         */
        protected function loaderComplete(event:LoaderEvent):void
        {
            //创建界面的外观
            var med:LoginMediator = new LoginMediator();
			
            //注册界面的中介
            facade.registerMediator(med);
            med.show();
        }
    }
}