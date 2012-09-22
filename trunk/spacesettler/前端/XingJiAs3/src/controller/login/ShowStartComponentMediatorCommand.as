package controller.login
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import mediator.BaseMediator;
    import mediator.login.StartComponentMediator;
    import mediator.prompt.PromptMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import proxy.login.LoginProxy;

    /**
     *显示开始界面命令
     * @author zn
     *
     */
    public class ShowStartComponentMediatorCommand extends SimpleCommand
    {

    	private var med:StartComponentMediator;
        public function ShowStartComponentMediatorCommand()
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
            var med:StartComponentMediator = getMediator(StartComponentMediator);
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
            med = new StartComponentMediator();

            //注册界面的中介
            facade.registerMediator(med);
			
			StartComponentMediator.addBG();
			
			var loginProxy:LoginProxy=getProxy(LoginProxy);
			loginProxy.getServerList(connectHandler);
        }
		
		private function connectHandler():void
		{
			med.show();
		}
    }
}