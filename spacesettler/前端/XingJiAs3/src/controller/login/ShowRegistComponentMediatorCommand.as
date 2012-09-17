package controller.login
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import mediator.BaseMediator;
    import mediator.login.RegistComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    /**
     *显示注册界面命令
     * @author zn
     *
     */
    public class ShowRegistComponentMediatorCommand extends SimpleCommand
    {
        public function ShowRegistComponentMediatorCommand()
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
            var med:RegistComponentMediator = getMediator(RegistComponentMediator);
            if (med)
            {
				med.show();
            }
            else
            {
                //加载界面SWF
                ResLoader.load("login.swf", MultilanguageManager.getString("loaderLogin"), loaderComplete);
            }
        }

        /**
         *界面加载完毕
         * @param loaderCore 被加载进来的对象
         *
         */
        protected function loaderComplete(event:LoaderEvent):void
        {
            var med:RegistComponentMediator = new RegistComponentMediator();

            //注册界面的中介
            facade.registerMediator(med);
			med.show();
        }
    }
}