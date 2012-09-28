package controller.init
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    
    import controller.EnterMainSenceViewCommand;
    import controller.allView.ShowAllViewComponentMediatorCommand;
    import controller.allView.ShowRongYuComponentMediatorCommand;
    import controller.allView.ShowShangChengComponentMediatorCommand;
    import controller.allView.ShowXingXingComponentMediatorCommand;
    import controller.allView.shangChengView.ShowfriendGiveComponentMediatorCommand;
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
    import controller.buildingView.ShowKeJiUpComponentMediatorCommand;
    import controller.buildingView.ShowShiJianInfoComponentMediatorCommand;
    import controller.buildingView.ShowYeLianChangUpComponentMediatorCommand;
    import controller.buildingView.ShowYeLianCreateComponentMediatorCommand;
    import controller.buildingView.ShowYeLianInfoComponentMediatorCommand;
    import controller.cangKu.ShowCangkuPackageViewComponentMediatorCommand;
    import controller.cangKu.ShowDonateViewComponentMediatorCommand;
    import controller.crystalMelter.ShowCrystalSmelterFunctionComponentMediatorCommand;
    import controller.mainSence.ShowMainSenceComponentMediatorCommand;
    import controller.mainView.ShowMainViewMediatorCommand;
    import controller.plantioid.ShowPlantioidComponentMediatorCommand;
    import controller.systemView.ShowAccountNumberBoundaryComponentMediatorCommand;
    import controller.systemView.ShowHelpBoundaryComponentMediatorCommand;
    import controller.systemView.ShowOptionBoundaryComponentMediatorCommand;
    import controller.systemView.ShowsystemComponentMediatorCommand;
    import controller.timeMachine.ShowTimeMachineComponentMediatorCommand;
    import controller.timeMachine.ShowTimeMachineInforComponentMediatorCommand;
    
    import mediator.allView.AllViewComponentMediator;
    import mediator.allView.RongYuComponentMediator;
    import mediator.allView.ShangChengComponentMediator;
    import mediator.allView.XingXingComponentMediator;
    import mediator.allView.shangChengView.FriendGiveComponentMediator;
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
    import mediator.cangKu.CangkuPackageViewComponentMediator;
    import mediator.cangKu.DonateViewComponentMediator;
    import mediator.cangKu.WuPingChaKanMenuViewComponentMediator;
    import mediator.crystalSmelter.CrystalSmelterFunctionComponentMediator;
    import mediator.mainSence.MainSenceComponentMediator;
    import mediator.mainView.MainViewMediator;
    import mediator.plantioid.PlantioidComponentMediator;
    import mediator.prompt.MoneyAlertComponentMediator;
    import mediator.systemView.AccountNumberBoundaryComponentMediator;
    import mediator.systemView.HelpBoundaryComponentMediator;
    import mediator.systemView.OptionBoundaryComponentMediator;
    import mediator.systemView.SystemComponentMediator;
    import mediator.timeMachine.TimeMachineComponentMediator;
    import mediator.timeMachine.TimeMachineInforComponentMediator;
    
    import net.NetHttpConn;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import proxy.BuildProxy;
    import proxy.allView.AllViewProxy;
    import proxy.allView.ShopProxy;
    import proxy.chat.ChatProxy;
    import proxy.content.ContentProxy;
    import proxy.friend.FriendProxy;
    import proxy.packageView.PackageViewProxy;
    import proxy.plantioid.PlantioidProxy;
    import proxy.task.TaskProxy;
    import proxy.timeMachine.TimeMachineProxy;
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
			NetHttpConn.showLoadServerData=false;
			
			sendNotification(ResLoader.SET_LOADER_BAR_TITLE_NOTE, MultilanguageManager.getString("loadingServer"));
			sendNotification(ResLoader.SHOW_LOADER_BAR_NOTE);
			sendNotification(ResLoader.SET_LOADER_BAR_PROGRESS_NOTE,new LoaderEvent(LoaderEvent.PROGRESS,null,1,1));
			
			var userInfoProxy:UserInfoProxy =ApplicationFacade.getProxy(UserInfoProxy);
			userInfoProxy.updateServerData();
			var taskProxy:TaskProxy=getProxy(TaskProxy);
			taskProxy.getFreshmanTask();
			
			var chatProxy:ChatProxy=getProxy(ChatProxy);
			chatProxy.connect();
			
//			var contentProxy:ContentProxy=getProxy(ContentProxy);
//			contentProxy.getContentInfo(function():void
//			{
//				NetHttpConn.showLoadServerData=true;
//				sendNotification(ResLoader.HIDE_LOADER_BAR_NOTE);
//				sendNotification(EnterMainSenceViewCommand.ENTER_MAIN_SENCE_VIEW_COMMAND);
//			});
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
			//仓库
			facade.registerProxy(new PackageViewProxy());
			//时间机器
			facade.registerProxy(new TimeMachineProxy());
			//商城
			facade.registerProxy(new ShopProxy());
			//小行星带
			facade.registerProxy(new PlantioidProxy());
			//聊天
			facade.registerProxy(new ChatProxy());
			//好友
			facade.registerProxy(new FriendProxy());
        }

        /**
         *注册中介
         *
         */
        protected function registerMediator():void
        {
			facade.registerMediator(new MoneyAlertComponentMediator());
			facade.registerMediator(new SelectorViewComponentMediator());
			facade.registerMediator(new WuPingChaKanMenuViewComponentMediator());
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
			//行星要塞
			facade.registerCommand(XingXingComponentMediator.SHOW_NOTE,ShowXingXingComponentMediatorCommand);
			//时间机器
			facade.registerCommand(TimeMachineComponentMediator.SHOW_NOTE,ShowTimeMachineComponentMediatorCommand);
			//时间机器描述
			facade.registerCommand(TimeMachineInforComponentMediator.SHOW_NOTE,ShowTimeMachineInforComponentMediatorCommand);
			//熔炼功能
			facade.registerCommand(CrystalSmelterFunctionComponentMediator.SHOW_NOTE,ShowCrystalSmelterFunctionComponentMediatorCommand);
			//查看仓库
			facade.registerCommand(CangkuPackageViewComponentMediator.SHOW_NOTE,ShowCangkuPackageViewComponentMediatorCommand);
			
			//捐献
			facade.registerCommand(DonateViewComponentMediator.SHOW_NOTE,ShowDonateViewComponentMediatorCommand);
			
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
			facade.registerCommand(KeJiUpComponentMediator.SHOW_NOTE,ShowKeJiUpComponentMediatorCommand);
			
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
			
			//商城信息
			facade.registerCommand(ShangChengComponentMediator.SHOW_NOTE,ShowShangChengComponentMediatorCommand);
			
			//小行星带
			facade.registerCommand(PlantioidComponentMediator.SHOW_NOTE,ShowPlantioidComponentMediatorCommand);
			//赠送弹出好友列表
			facade.registerCommand(FriendGiveComponentMediator.SHOW_NOTE,ShowfriendGiveComponentMediatorCommand);
			//系统菜单
			facade.registerCommand(SystemComponentMediator.SHOW_NOTE,ShowsystemComponentMediatorCommand);
			//系统选项菜单
			facade.registerCommand(OptionBoundaryComponentMediator.SHOW_NOTE,ShowOptionBoundaryComponentMediatorCommand);
			//系统帮助菜单
			facade.registerCommand(HelpBoundaryComponentMediator.SHOW_NOTE,ShowHelpBoundaryComponentMediatorCommand);
			//系统我的账户菜单
			facade.registerCommand(AccountNumberBoundaryComponentMediator.SHOW_NOTE,ShowAccountNumberBoundaryComponentMediatorCommand);
        }
    }
}