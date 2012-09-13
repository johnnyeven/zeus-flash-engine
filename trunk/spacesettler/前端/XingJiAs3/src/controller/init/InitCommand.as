package controller.init
{
    import controller.mainSence.ShowMainSenceComponentMediatorCommand;
    import controller.mainView.ShowMainViewMediatorCommand;
    
    import mediator.mainSence.MainSenceComponentMediator;
    import mediator.mainView.MainViewMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    /**
     *初始化
     * @author zn
     *
     */
    public class InitCommand extends SimpleCommand
    {
        public static const INIT_NOTE:String = "InitCommand.initNote";

        public function InitCommand()
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
            facade.removeCommand(INIT_NOTE);
			
			registerClass();
            registerProxy();
            registerMediator();
            registerCommand();
            init();

			sendNotification(GetServerDataCommand.GET_SERVER_DATA_COMMAND);
        }
		
		/**
		 *注册服务器数据对象
		 * 用于对服务器对象解码 
		 * 
		 */
		private function registerClass():void
		{
			
		}
		
		
        /**
         *执行一些其他东西
         *
         */
        public function init():void
        {

        }

        /**
         *注册代理
         *
         */
        protected function registerProxy():void
        {
        }

        /**
         *注册中介
         *
         */
        protected function registerMediator():void
        {
			
        }

        /**
         *注册命名
         *
         */
        protected function registerCommand():void
        {
			//登陆后获取信息 
			facade.registerCommand(GetServerDataCommand.GET_SERVER_DATA_COMMAND, GetServerDataCommand);
            //注册显示主界面命令
            facade.registerCommand(MainViewMediator.SHOW_NOTE, ShowMainViewMediatorCommand);
			
			//主场景
			facade.registerCommand(MainSenceComponentMediator.SHOW_NOTE, ShowMainSenceComponentMediatorCommand);
        }
    }
}