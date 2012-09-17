package controller
{
    import com.greensock.plugins.TransformAroundCenterPlugin;
    import com.greensock.plugins.TweenPlugin;
    
    import controller.init.GetURLParmsCommand;
    import controller.init.InitCommand;
    import controller.init.LoadConfigCommand;
    import controller.init.LoaderResCommand;
    import controller.init.ParseConnectParmsCommand;
    import controller.login.ShowLoginMediatorCommand;
    import controller.login.ShowNameInforComponentMediatorCommand;
    import controller.login.ShowPkComponentMediatorCommand;
    import controller.login.ShowRegistComponentMediatorCommand;
    import controller.login.ShowStartComponentMediatorCommand;
    
    import mediator.MainMediator;
    import mediator.loader.LoaderBarMediator;
    import mediator.login.LoginMediator;
    import mediator.login.NameInforComponentMediator;
    import mediator.login.PkComponentMediator;
    import mediator.login.RegistComponentMediator;
    import mediator.login.StartComponentMediator;
    import mediator.prompt.PromptMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    import org.puremvc.as3.patterns.facade.Facade;
    
    import proxy.login.LoginProxy;
    import proxy.userInfo.UserInfoProxy;

    /**
     * 启动
	 * 解析URL地址参数
     * 加载配置文件;
     * 建立服务器链接“ConnectServerCommand”
     * 如果未登录， 加载并显示登陆界面。否则执行下一步 。“ShowLoginMediatorCommand”
     * 加载进入游戏的必备资源“LoaderResCommand”
     * 初始化"InitCommand"
     * 显示游戏界面
     *
     * @author zn
     *
     */
    public class StartupCommand extends SimpleCommand
    {
        public function StartupCommand()
        {
        }

        /**
         *执行
         * @param notification
         *
         */
        public override function execute(notification:INotification):void
        {
			TweenPlugin.activate([TransformAroundCenterPlugin]);
			
			initCommand();
			
            var app:Main = Main(notification.getBody());

            //注册主程序界面
            facade.registerMediator(new MainMediator(app));
			
            //注册加载界面
            facade.registerMediator(new LoaderBarMediator());
			//注册提示
			facade.registerMediator(new PromptMediator());
			
			facade.registerProxy(new LoginProxy());
			facade.registerProxy(new UserInfoProxy());
			
            // 解析URL地址参数
            sendNotification(GetURLParmsCommand.GET_URL_PARMS_COMMAND);
        }
		
		private function initCommand():void
		{
			//注册解析URL地址参数
			facade.registerCommand(GetURLParmsCommand.GET_URL_PARMS_COMMAND, GetURLParmsCommand);
			//注册加载配置文件
			facade.registerCommand(LoadConfigCommand.LOAD_CONFIG_NOTE, LoadConfigCommand);
			//注册解析连接信息
			facade.registerCommand(ParseConnectParmsCommand.PARSE_CONNECT_PARMS_NOTE, ParseConnectParmsCommand);
			//注册加载进入游戏资源
			facade.registerCommand(LoaderResCommand.LOAD_RES_NOTE, LoaderResCommand);
			/**************************************
			        登陆流程
			 **************************************/	
			//开始界面
			facade.registerCommand(StartComponentMediator.SHOW_NOTE,ShowStartComponentMediatorCommand);
			//登陆界面
			facade.registerCommand(LoginMediator.SHOW_NOTE,ShowLoginMediatorCommand);
			//注册
			facade.registerCommand(RegistComponentMediator.SHOW_NOTE,ShowRegistComponentMediatorCommand);
			//昵称
			facade.registerCommand(NameInforComponentMediator.SHOW_NOTE,ShowNameInforComponentMediatorCommand);
			//阵营
			facade.registerCommand(PkComponentMediator.SHOW_NOTE,ShowPkComponentMediatorCommand);
			//注册初始化命令
			facade.registerCommand(InitCommand.INIT_NOTE, InitCommand);
		}
	}
}