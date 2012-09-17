package controller.login
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import mediator.BaseMediator;
    import mediator.login.PkComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    /**
     *显示阵营界面命令
     * @author zn
     *
     */
    public class ShowPkComponentMediatorCommand extends SimpleCommand
    {
        public function ShowPkComponentMediatorCommand()
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
            var med:PkComponentMediator = getMediator(PkComponentMediator);
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
            var med:PkComponentMediator = new PkComponentMediator();

            //注册界面的中介
            facade.registerMediator(med);
			med.show();
        }
    }
}