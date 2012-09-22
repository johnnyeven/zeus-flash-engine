package controller.init
{
    import controller.EnterMainSenceViewCommand;
    import controller.allView.ShowAllViewComponentMediatorCommand;
    import controller.allView.ShowRongYuComponentMediatorCommand;
    import controller.buildingView.ShowCangKuCreateComponentMediatorCommand;
    import controller.buildingView.ShowCangKuInfoComponentMediatorCommand;
    import controller.buildingView.ShowCangKuUpComponentMediatorCommand;
    import controller.buildingView.ShowCenterInfoComponentMediatorCommand;
    import controller.buildingView.ShowCenterUpComponentMediatorCommand;
    import controller.buildingView.ShowChuanQinCreateComponentMediatorCommand;
    import controller.buildingView.ShowChuanQinInfoComponentMediatorCommand;
    import controller.buildingView.ShowChuanQinUpComponentMediatorCommand;
    import controller.buildingView.ShowDianChangCreateComponentMediatorCommand;
    import controller.buildingView.ShowDianChangInfoComponentMediatorCommand;
    import controller.buildingView.ShowDianChangUpComponentMediatorCommand;
    import controller.buildingView.ShowJunGongCreateComponentMediatorCommand;
    import controller.buildingView.ShowJunGongInfoComponentMediatorCommand;
    import controller.buildingView.ShowKeJiCreateComponentMediatorCommand;
    import controller.buildingView.ShowKeJiInfoComponentMediatorCommand;
    import controller.buildingView.ShowShiJianInfoComponentMediatorCommand;
    import controller.buildingView.ShowYeLianChangUpComponentMediatorCommand;
    import controller.buildingView.ShowYeLianCreateComponentMediatorCommand;
    import controller.buildingView.ShowYeLianInfoComponentMediatorCommand;
    import controller.mainSence.ShowMainSenceComponentMediatorCommand;
    import controller.mainView.ShowMainViewMediatorCommand;
    
    import mediator.allView.AllViewComponentMediator;
    import mediator.allView.RongYuComponentMediator;
    import mediator.buildingView.CangKuCreateComponentMediator;
    import mediator.buildingView.CangKuInfoComponentMediator;
    import mediator.buildingView.CangKuUpComponentMediator;
    import mediator.buildingView.CenterInfoComponentMediator;
    import mediator.buildingView.CenterUpComponentMediator;
    import mediator.buildingView.ChuanQinCreateComponentMediator;
    import mediator.buildingView.ChuanQinInfoComponentMediator;
    import mediator.buildingView.ChuanQinUpComponentMediator;
    import mediator.buildingView.DianChangCreateComponentMediator;
    import mediator.buildingView.DianChangInfoComponentMediator;
    import mediator.buildingView.DianChangUpComponentMediator;
    import mediator.buildingView.JunGongCreateComponentMediator;
    import mediator.buildingView.JunGongInfoComponentMediator;
    import mediator.buildingView.KeJiCreateComponentMediator;
    import mediator.buildingView.KeJiInfoComponentMediator;
    import mediator.buildingView.KeJiUpComponentMediator;
    import mediator.buildingView.SelectorViewComponentMediator;
    import mediator.buildingView.ShiJianInfoComponentMediator;
    import mediator.buildingView.YeLianChangUpComponentMediator;
    import mediator.buildingView.YeLianCreateComponentMediator;
    import mediator.buildingView.YeLianInfoComponentMediator;
    import mediator.mainSence.MainSenceComponentMediator;
    import mediator.mainView.MainViewMediator;
    import mediator.prompt.MoneyAlertComponentMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import proxy.BuildProxy;
    import proxy.allView.AllViewProxy;
    import proxy.content.ContentProxy;
    import proxy.task.TaskProxy;
    import proxy.userInfo.UserInfoProxy;

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

			var contentProxy:ContentProxy=getProxy(ContentProxy);
			contentProxy.getContentInfo(function():void
			{
				sendNotification(EnterMainSenceViewCommand.ENTER_MAIN_SENCE_VIEW_COMMAND);
			});
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
			facade.registerProxy(new ContentProxy());
			facade.registerProxy(new UserInfoProxy());
			facade.registerProxy(new BuildProxy());
			facade.registerProxy(new TaskProxy());
			//总览
			facade.registerProxy(new AllViewProxy());
        }

        /**
         *注册中介
         *
         */
        protected function registerMediator():void
        {
			facade.registerMediator(new MoneyAlertComponentMediator());
			facade.registerMediator(new SelectorViewComponentMediator());
        }

        /**
         *注册命名
         *
         */
        protected function registerCommand():void
        {
			//登陆后获取信息 
			facade.registerCommand(EnterMainSenceViewCommand.ENTER_MAIN_SENCE_VIEW_COMMAND, EnterMainSenceViewCommand);
            //注册显示主界面命令
            facade.registerCommand(MainViewMediator.SHOW_NOTE, ShowMainViewMediatorCommand);
			
			//主场景
			facade.registerCommand(MainSenceComponentMediator.SHOW_NOTE, ShowMainSenceComponentMediatorCommand);
			//总览功能
			facade.registerCommand(AllViewComponentMediator.SHOW_NOTE,ShowAllViewComponentMediatorCommand);
			//荣誉功能
			facade.registerCommand(RongYuComponentMediator.SHOW_NOTE,ShowRongYuComponentMediatorCommand);
			
			//氚氢厂建造
			facade.registerCommand(ChuanQinCreateComponentMediator.SHOW_NOTE, ShowChuanQinCreateComponentMediatorCommand);
			
			//仓库建造
			facade.registerCommand(CangKuCreateComponentMediator.SHOW_NOTE, ShowCangKuCreateComponentMediatorCommand);
			
			//电厂建造
			facade.registerCommand(DianChangCreateComponentMediator.SHOW_NOTE, ShowDianChangCreateComponentMediatorCommand);
			
			//军工厂建造
			facade.registerCommand(JunGongCreateComponentMediator.SHOW_NOTE,ShowJunGongCreateComponentMediatorCommand);
			
			//科技建造
			facade.registerCommand(KeJiCreateComponentMediator.SHOW_NOTE,ShowKeJiCreateComponentMediatorCommand);
			
			//冶炼厂建造
			facade.registerCommand(YeLianCreateComponentMediator.SHOW_NOTE,ShowYeLianCreateComponentMediatorCommand);
			
			//氚氢厂升级
			facade.registerCommand(ChuanQinUpComponentMediator.SHOW_NOTE,ShowChuanQinUpComponentMediatorCommand);
			
			//暗能电厂升级
			facade.registerCommand(DianChangUpComponentMediator.SHOW_NOTE,ShowDianChangUpComponentMediatorCommand);
			
			//仓库升级
			facade.registerCommand(CangKuUpComponentMediator.SHOW_NOTE,ShowCangKuUpComponentMediatorCommand);
			
			//科技升级
			facade.registerCommand(KeJiUpComponentMediator.SHOW_NOTE,ShowKeJiCreateComponentMediatorCommand);
			
			//冶炼厂升级
			facade.registerCommand(YeLianChangUpComponentMediator.SHOW_NOTE,ShowYeLianChangUpComponentMediatorCommand);
			
			//基地中心升级
			facade.registerCommand(CenterUpComponentMediator.SHOW_NOTE,ShowCenterUpComponentMediatorCommand);
			
			//仓库信息
			facade.registerCommand(CangKuInfoComponentMediator.SHOW_NOTE,ShowCangKuInfoComponentMediatorCommand);
			
			//基地中心信息
			facade.registerCommand(CenterInfoComponentMediator.SHOW_NOTE,ShowCenterInfoComponentMediatorCommand);
			
			//氚氢厂信息
			facade.registerCommand(ChuanQinInfoComponentMediator.SHOW_NOTE,ShowChuanQinInfoComponentMediatorCommand);

			//暗能电厂信息 
			facade.registerCommand(DianChangInfoComponentMediator.SHOW_NOTE,ShowDianChangInfoComponentMediatorCommand);

			//军工厂信息 
			facade.registerCommand(JunGongInfoComponentMediator.SHOW_NOTE,ShowJunGongInfoComponentMediatorCommand);

			//科技中心信息 
			facade.registerCommand(KeJiInfoComponentMediator.SHOW_NOTE,ShowKeJiInfoComponentMediatorCommand);

			//时间机器信息
			facade.registerCommand(ShiJianInfoComponentMediator.SHOW_NOTE,ShowShiJianInfoComponentMediatorCommand);

			//冶炼厂信息
			facade.registerCommand(YeLianInfoComponentMediator.SHOW_NOTE,ShowYeLianInfoComponentMediatorCommand);
        }
    }
}