package controller.init
{
    import com.zn.ResLoader;
    import com.zn.loading.LoaderEvent;
    import com.zn.multilanguage.MultilanguageManager;
    
    import controller.EnterMainSenceViewCommand;
    import controller.allView.ShowAllViewComponentMediatorCommand;
    import controller.allView.ShowRongYuComponentMediatorCommand;
    import controller.allView.ShowXingXingComponentMediatorCommand;
    import controller.battle.ShowBattleBuildInfoComponentMediatorCommand;
    import controller.battle.ShowBattleBuyComponentMediatorCommand;
    import controller.battle.ShowBattleEditMediatorCommand;
    import controller.battle.ShowBattleMediatorCommand;
    import controller.battle.ShowBattleRevivePanelComponentMediatorCommand;
    import controller.battle.ShowBottomViewComponentMediatorCommand;
    import controller.battle.ShowGoToManageComponentMediatorCommand;
    import controller.battle.ShowTimeViewComponentMediatorCommand;
    import controller.battle.ShowbattleEditorConditionComponentMediatorCommand;
    import controller.battle.fight.FightCreateFeiJiCommand;
    import controller.battle.fight.FightDropHonorCommand;
    import controller.battle.fight.FightExplodeCommand;
    import controller.battle.fight.FightFireCommand;
    import controller.battle.fight.FightHitCommand;
    import controller.battle.fight.FightItemCommand;
    import controller.battle.fight.FightLockCommand;
    import controller.battle.fight.FightMoveCommand;
    import controller.battle.fight.FightNewPlayerCommand;
    import controller.battle.fight.FightResurgenceCommand;
    import controller.battle.fight.ShowBattleFailPanelComponentMediatorCommand;
    import controller.battle.fight.ShowBattleFightViewComponentMediatorCommand;
    import controller.battle.fight.ShowBattleTiShiPanelComponentMediatorCommand;
    import controller.battle.fight.ShowBattleVictoryPanelComponentMediatorCommand;
    import controller.battleEnter.ShowBattleEnterComponentMediatorCommand;
    import controller.battleEnter.ShowPrompt_weiXiuComponentMediatorCommand;
    import controller.buildingView.ShowCangKuCreateComponentMediatorCommand;
    import controller.buildingView.ShowCangKuInfoComponentMediatorCommand;
    import controller.buildingView.ShowCangKuUpComponentMediatorCommand;
    import controller.buildingView.ShowCenterInfoComponentMediatorCommand;
    import controller.buildingView.ShowCenterUpComponentMediatorCommand;
    import controller.buildingView.ShowChuanQinCreateComponentMediatorCommand;
    import controller.buildingView.ShowChuanQinInfoComponentMediatorCommand;
    import controller.buildingView.ShowChuanQinUpComponentMediatorCommand;
    import controller.buildingView.ShowConditionViewCompMediatorCommand;
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
    import controller.cangKu.ShowChaKanDaoJuViewComponentMediatorCommand;
    import controller.cangKu.ShowChaKanGuaJianViewComponentMediatorCommand;
    import controller.cangKu.ShowChaKanTuZhiViewComponentMediatorCommand;
    import controller.cangKu.ShowChaKanZhanCheViewMediatorCommand;
    import controller.cangKu.ShowDonateViewComponentMediatorCommand;
    import controller.cangKu.ShowDonateview_1ComponentMediatorCommand;
    import controller.crystalMelter.ShowCrystalSmelterFunctionComponentMediatorCommand;
    import controller.email.ShowEmailComponentMediatorCommand;
    import controller.email.ShowSendEmailComponentMediatorCommand;
    import controller.email.ShowSourceSendComponentMediatorCommand;
    import controller.email.ShowViewEmailComponentMediatorCommand;
    import controller.factory.ShowFactoryArmsComponentMediatorCommand;
    import controller.factory.ShowFactoryChaKanComponentMediatorCommand;
    import controller.factory.ShowFactoryChangeComponentMediatorCommand;
    import controller.factory.ShowFactoryInfoComponentMediatorCommand;
    import controller.factory.ShowFactoryMakeAndServiceComponentMediatorCommand;
    import controller.factory.ShowFactoryMakeComponentMediatorCommand;
    import controller.factory.ShowFactoryStrengthenComponentMediatorCommand;
    import controller.friendList.ShowEnemyListComponentMediatorCommand;
    import controller.friendList.ShowFriendListComponentMediatorCommand;
    import controller.friendList.ShowSearchPlayerComponentMediatorCommand;
    import controller.friendList.ShowViewIdCardComponentMediatorCommand;
    import controller.giftBag.ShowGiftBagViewComponentMediatorCommand;
    import controller.giftBag.ShowGiftDetileInfoViewComponentMediatorCommand;
    import controller.group.ShowGroupAuditComponentMediatorCommand;
    import controller.group.ShowGroupComponentMediatorCommand;
    import controller.group.ShowGroupManageComponentMediatorCommand;
    import controller.group.ShowGroupMemberComponentMediatorCommand;
    import controller.group.ShowGroupMemberManageComponentMediatorCommand;
    import controller.group.ShowNotJoinGroupComponentMediatorCommand;
    import controller.groupFight.ShowGroupFightComponentMediatorCommand;
    import controller.groupFight.ShowGroupFightMapComponentMediatorCommand;
    import controller.groupFight.ShowGroupFightMenuComponentMediatorCommand;
    import controller.groupFight.ShowGroupFightShowComponentMediatorCommand;
    import controller.groupFight.tiShi.ShowGroupFightOneComponentMediatorCommand;
    import controller.groupFight.tiShi.ShowGroupFightThreeComponentMediatorCommand;
    import controller.groupFight.tiShi.ShowGroupFightTwoComponentMediatorCommand;
    import controller.mainSence.ShowMainSenceComponentMediatorCommand;
    import controller.mainView.ShowMainViewMediatorCommand;
    import controller.plantioid.ShowPlantioidComponentMediatorCommand;
    import controller.plantioid.ShowPlantioidTiShiComponentMediatorCommand;
    import controller.ranking.ShowRankingCommonComponentMediatorCommand;
    import controller.ranking.ShowRankingComponentMediatorCommand;
    import controller.ranking.ShowrankingPvpComponentMediatorCommand;
    import controller.scienceResearch.ShowInforComponentMediatorCommand;
    import controller.scienceResearch.ShowPopuItemComponentMediatorCommand;
    import controller.scienceResearch.ShowScienceResearchComponentMediatorCommand;
    import controller.shangCheng.ShowShangChengComponentMediatorCommand;
    import controller.shangCheng.shangChengView.ShowBuyPromptComponentMediatorCommand;
    import controller.shangCheng.shangChengView.ShowfriendGiveComponentMediatorCommand;
    import controller.showBag.ShowShowBagComponentMediatorCommand;
    import controller.systemView.ShowAccountNumberBoundaryComponentMediatorCommand;
    import controller.systemView.ShowHelpBoundaryComponentMediatorCommand;
    import controller.systemView.ShowOptionBoundaryComponentMediatorCommand;
    import controller.systemView.ShowSystemPassWordComponentMediatorCommand;
    import controller.systemView.ShowsystemComponentMediatorCommand;
    import controller.task.ShowtaskGideComponentMediatorCommand;
    import controller.task.ShowtaskMilitaryComponentMediatorCommand;
    import controller.task.ShowtaskViewComponentMediatorCommand;
    import controller.task.TaskCommand;
    import controller.task.TaskCompleteCommand;
    import controller.task.TaskGideCommand;
    import controller.timeMachine.ShowTimeMachineComponentMediatorCommand;
    import controller.timeMachine.ShowTimeMachineInforComponentMediatorCommand;
    
    import mediator.allView.AllViewComponentMediator;
    import mediator.allView.RongYuComponentMediator;
    import mediator.allView.XingXingComponentMediator;
    import mediator.battle.BattleBuildInfoComponentMediator;
    import mediator.battle.BattleBuyComponentMediator;
    import mediator.battle.BattleEditMediator;
    import mediator.battle.BattleEditSelectorViewComponentMediator;
    import mediator.battle.BattleFailPanelComponentMediator;
    import mediator.battle.BattleFightMediator;
    import mediator.battle.BattleFightViewComponentMediator;
    import mediator.battle.BattleRevivePanelComponentMediator;
    import mediator.battle.BattleTiShiPanelComponentMediator;
    import mediator.battle.BattleVictoryPanelComponentMediator;
    import mediator.battle.BottomViewComponentMediator;
    import mediator.battle.GoToManageComponentMediator;
    import mediator.battle.TimeViewComponentMediator;
    import mediator.battle.battleEditorConditionComponentMediator;
    import mediator.battleEnter.BattleEnterComponentMediator;
    import mediator.buildingView.CangKuCreateComponentMediator;
    import mediator.buildingView.CangKuInfoComponentMediator;
    import mediator.buildingView.CangKuUpComponentMediator;
    import mediator.buildingView.CenterInfoComponentMediator;
    import mediator.buildingView.CenterUpComponentMediator;
    import mediator.buildingView.ChuanQinCreateComponentMediator;
    import mediator.buildingView.ChuanQinInfoComponentMediator;
    import mediator.buildingView.ChuanQinUpComponentMediator;
    import mediator.buildingView.ConditionViewCompMediator;
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
    import mediator.cangKu.ChaKanDaoJuViewComponentMediator;
    import mediator.cangKu.ChaKanGuaJianViewComponentMediator;
    import mediator.cangKu.ChaKanTuZhiViewComponentMediator;
    import mediator.cangKu.ChaKanZhanCheViewComponentMediator;
    import mediator.cangKu.DonateViewComponentMediator;
    import mediator.cangKu.Donateview_1ComponentMediator;
    import mediator.cangKu.WuPingChaKanMenuViewComponentMediator;
    import mediator.crystalSmelter.CrystalSmelterFunctionComponentMediator;
    import mediator.email.EmailComponentMediator;
    import mediator.email.SendEmailComponentMediator;
    import mediator.email.SourceSendComponentMediator;
    import mediator.email.ViewEmailComponentMediator;
    import mediator.factory.FactoryArmsComponentMediator;
    import mediator.factory.FactoryChaKanComponentMediator;
    import mediator.factory.FactoryChangeComponentMediator;
    import mediator.factory.FactoryInfoComponentMediator;
    import mediator.factory.FactoryMakeAndServiceComponentMediator;
    import mediator.factory.FactoryMakeComponentMediator;
    import mediator.factory.FactoryStrengthenComponentMediator;
    import mediator.friendList.EnemyListComponentMediator;
    import mediator.friendList.FriendListComponentMediator;
    import mediator.friendList.SearchPlayerComponentMediator;
    import mediator.friendList.ViewIdCardComponentMediator;
    import mediator.giftBag.GiftBagViewComponentMediator;
    import mediator.giftBag.GiftDetileInfoViewComponentMediator;
    import mediator.group.GroupAuditComponentMediator;
    import mediator.group.GroupComponentMediator;
    import mediator.group.GroupManageComponentMediator;
    import mediator.group.GroupMemberComponentMediator;
    import mediator.group.GroupMemberManageComponentMediator;
    import mediator.group.NotJoinGroupComponentMediator;
    import mediator.groupFight.GroupFightComponentMediator;
    import mediator.groupFight.GroupFightMapComponentMediator;
    import mediator.groupFight.GroupFightMenuComponentMediator;
    import mediator.groupFight.GroupFightShowComponentMediator;
    import mediator.groupFight.tiShi.GroupFightOneComponentMediator;
    import mediator.groupFight.tiShi.GroupFightThreeComponentMediator;
    import mediator.groupFight.tiShi.GroupFightTwoComponentMediator;
    import mediator.login.StartComponentMediator;
    import mediator.mainSence.MainSenceComponentMediator;
    import mediator.mainView.MainViewMediator;
    import mediator.plantioid.PlantioidComponentMediator;
    import mediator.plantioid.PlantioidTiShiComponentMediator;
    import mediator.prompt.GroupPopComponentMediator;
    import mediator.prompt.MoneyAlertComponentMediator;
    import mediator.prompt.PromptWeiXiuMediator;
    import mediator.ranking.RankingCommonComponentMediator;
    import mediator.ranking.RankingComponentMediator;
    import mediator.ranking.rankingPvpComponentMediator;
    import mediator.scienceResearch.InforComponentMediator;
    import mediator.scienceResearch.PopuItemComponentMediator;
    import mediator.scienceResearch.ScienceResearchComponentMediator;
    import mediator.shangCheng.BuyPromptComponentMediator;
    import mediator.shangCheng.FriendGiveComponentMediator;
    import mediator.shangCheng.ShangChengComponentMediator;
    import mediator.showBag.ShowBagComponentMediator;
    import mediator.systemView.AccountNumberBoundaryComponentMediator;
    import mediator.systemView.HelpBoundaryComponentMediator;
    import mediator.systemView.OptionBoundaryComponentMediator;
    import mediator.systemView.SystemComponentMediator;
    import mediator.systemView.SystemPassWordComponentMediator;
    import mediator.task.TaskViewComponentMediator;
    import mediator.task.taskGideComponentMediator;
    import mediator.task.taskMilitaryComponentMediator;
    import mediator.timeMachine.TimeMachineComponentMediator;
    import mediator.timeMachine.TimeMachineInforComponentMediator;
    
    import net.NetHttpConn;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import proxy.BuildProxy;
    import proxy.allView.AllViewProxy;
    import proxy.battle.BattleProxy;
    import proxy.chat.ChatProxy;
    import proxy.content.ContentProxy;
    import proxy.crystalSmelter.CrystalSmelterProxy;
    import proxy.email.EmailProxy;
    import proxy.factory.FactoryProxy;
    import proxy.friendList.FriendProxy;
    import proxy.group.GroupProxy;
    import proxy.groupFight.GroupFightProxy;
    import proxy.packageView.PackageViewProxy;
    import proxy.plantioid.PlantioidProxy;
    import proxy.rankingProxy.RankingProxy;
    import proxy.scienceResearch.ScienceResearchProxy;
    import proxy.shangCheng.ShopProxy;
    import proxy.task.TaskProxy;
    import proxy.taskGift.GiftBagProxy;
    import proxy.timeMachine.TimeMachineProxy;
    import proxy.userInfo.UserInfoProxy;
    
    import view.battle.build.battleEditorConditionComponent;

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
//			var taskProxy:TaskProxy=getProxy(TaskProxy);
//			taskProxy.getFreshmanTask();
			
			var chatProxy:ChatProxy=getProxy(ChatProxy);
			chatProxy.connect();
			
			var contentProxy:ContentProxy=getProxy(ContentProxy);
			contentProxy.getContentInfo(function():void
			{
				NetHttpConn.showLoadServerData=true;
				sendNotification(ResLoader.HIDE_LOADER_BAR_NOTE);
				sendNotification(EnterMainSenceViewCommand.ENTER_MAIN_SENCE_VIEW_COMMAND);
			});
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
			facade.registerProxy(new GiftBagProxy());
			//总览
			facade.registerProxy(new AllViewProxy());
			//仓库
			facade.registerProxy(new PackageViewProxy());
			//时间机器
			facade.registerProxy(new TimeMachineProxy());
			//熔炼功能
			facade.registerProxy(new CrystalSmelterProxy());
			//科研功能
			facade.registerProxy(new ScienceResearchProxy());
			//商城
			facade.registerProxy(new ShopProxy());
			//小行星带
			facade.registerProxy(new PlantioidProxy());
			//聊天
			facade.registerProxy(new ChatProxy());
			//邮件
			facade.registerProxy(new EmailProxy());
			//好友
			facade.registerProxy(new FriendProxy());
			//排行
			facade.registerProxy(new RankingProxy());
			//军团
			facade.registerProxy(new GroupProxy());
			//战场
			facade.registerProxy(new BattleProxy());
			//军工厂
			facade.registerProxy(new FactoryProxy());
			//军团战
			facade.registerProxy(new GroupFightProxy());
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
			facade.registerMediator(new GroupPopComponentMediator());
			facade.registerMediator(new BattleEditSelectorViewComponentMediator());
			
//			//新手任务
//			facade.registerMediator(new TaskViewComponentMediator());
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
			//科研功能
			facade.registerCommand(ScienceResearchComponentMediator.SHOW_NOTE,ShowScienceResearchComponentMediatorCommand);
			//科研弹出框
			facade.registerCommand(PopuItemComponentMediator.SHOW_NOTE,ShowPopuItemComponentMediatorCommand);
			//科研描述
			facade.registerCommand(InforComponentMediator.SHOW_NOTE,ShowInforComponentMediatorCommand);
			//好友列表
			facade.registerCommand(FriendListComponentMediator.SHOW_NOTE,ShowFriendListComponentMediatorCommand);
			//敌人列表
			facade.registerCommand(EnemyListComponentMediator.SHOW_NOTE,ShowEnemyListComponentMediatorCommand);
			//搜索玩家
			facade.registerCommand(SearchPlayerComponentMediator.SHOW_NOTE,ShowSearchPlayerComponentMediatorCommand);
			//查看军官证
			facade.registerCommand(ViewIdCardComponentMediator.SHOW_NOTE,ShowViewIdCardComponentMediatorCommand);
			//展示装备
			facade.registerCommand(ShowBagComponentMediator.SHOW_NOTE,ShowShowBagComponentMediatorCommand);
			//邮件列表
			facade.registerCommand(EmailComponentMediator.SHOW_NOTE,ShowEmailComponentMediatorCommand);
			//发送新邮件
			facade.registerCommand(SendEmailComponentMediator.SHOW_NOTE,ShowSendEmailComponentMediatorCommand);
			//查看邮件
			facade.registerCommand(ViewEmailComponentMediator.SHOW_NOTE,ShowViewEmailComponentMediatorCommand);
			//资源库存量
			facade.registerCommand(SourceSendComponentMediator.SHOW_NOTE,ShowSourceSendComponentMediatorCommand);
			//查看礼包
			facade.registerCommand(GiftBagViewComponentMediator.SHOW_NOTE,ShowGiftBagViewComponentMediatorCommand);
			//礼包详细信息
			facade.registerCommand(GiftDetileInfoViewComponentMediator.SHOW_NOTE,ShowGiftDetileInfoViewComponentMediatorCommand);
			
			//任务command
			facade.registerCommand(TaskGideCommand.TASKGIDE_COMMAND,TaskGideCommand);
			facade.registerCommand(TaskCommand.ADDTASKINFO_COMMAND,TaskCommand);
			facade.registerCommand(TaskCompleteCommand.TASKCOMPLETE_COMMAND,TaskCompleteCommand);
			//任务面板
			facade.registerCommand(TaskViewComponentMediator.SHOW_NOTE,ShowtaskViewComponentMediatorCommand);
			//指引箭头
			facade.registerCommand(taskGideComponentMediator.SHOW_NOTE,controller.task.ShowtaskGideComponentMediatorCommand);
			//用户注册
			facade.registerCommand(taskMilitaryComponentMediator.SHOW_NOTE,ShowtaskMilitaryComponentMediatorCommand);
			
			//查看仓库
			facade.registerCommand(CangkuPackageViewComponentMediator.SHOW_NOTE,ShowCangkuPackageViewComponentMediatorCommand);
			//战车查看
			facade.registerCommand(ChaKanZhanCheViewComponentMediator.SHOW_NOTE,ShowChaKanZhanCheViewMediatorCommand);
			//挂件查看
			facade.registerCommand(ChaKanGuaJianViewComponentMediator.SHOW_NOTE,ShowChaKanGuaJianViewComponentMediatorCommand);
			//图纸查看
			facade.registerCommand(ChaKanTuZhiViewComponentMediator.SHOW_NOTE,ShowChaKanTuZhiViewComponentMediatorCommand);
			//道具查看
			facade.registerCommand(ChaKanDaoJuViewComponentMediator.SHOW_NOTE,ShowChaKanDaoJuViewComponentMediatorCommand);
			//捐献
			facade.registerCommand(DonateViewComponentMediator.SHOW_NOTE,ShowDonateViewComponentMediatorCommand);
			//暗物质捐献
			facade.registerCommand(Donateview_1ComponentMediator.SHOW_NOTE,ShowDonateview_1ComponentMediatorCommand);
			
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
			
			//条件不足界面
			facade.registerCommand(ConditionViewCompMediator.SHOW_NOTE,ShowConditionViewCompMediatorCommand);
			
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
			//
			facade.registerCommand(BuyPromptComponentMediator.SHOW_NOTE,ShowBuyPromptComponentMediatorCommand);
			//赠送弹出好友列表
			facade.registerCommand(FriendGiveComponentMediator.SHOW_NOTE,ShowfriendGiveComponentMediatorCommand);
						
			//小行星带
			facade.registerCommand(PlantioidComponentMediator.SHOW_NOTE,ShowPlantioidComponentMediatorCommand);
			//小行星带强制攻击面板
			facade.registerCommand(PlantioidTiShiComponentMediator.SHOW_NOTE,ShowPlantioidTiShiComponentMediatorCommand);
			
			
			//系统菜单
			facade.registerCommand(SystemComponentMediator.SHOW_NOTE,ShowsystemComponentMediatorCommand);
			//系统修改密码
			facade.registerCommand(SystemPassWordComponentMediator.SHOW_NOTE,ShowSystemPassWordComponentMediatorCommand);
			//系统选项菜单
			facade.registerCommand(OptionBoundaryComponentMediator.SHOW_NOTE,ShowOptionBoundaryComponentMediatorCommand);
			//系统帮助菜单
			facade.registerCommand(HelpBoundaryComponentMediator.SHOW_NOTE,ShowHelpBoundaryComponentMediatorCommand);
			//系统我的账户菜单
			facade.registerCommand(AccountNumberBoundaryComponentMediator.SHOW_NOTE,ShowAccountNumberBoundaryComponentMediatorCommand);
			//排名版面1 版面2 版面3
			facade.registerCommand(RankingComponentMediator.SHOW_NOTE,ShowRankingComponentMediatorCommand);
			facade.registerCommand(RankingCommonComponentMediator.SHOW_NOTE,ShowRankingCommonComponentMediatorCommand);
			facade.registerCommand(rankingPvpComponentMediator.SHOW_NOTE,ShowrankingPvpComponentMediatorCommand);
			
			//军团未加入时面板
			facade.registerCommand(NotJoinGroupComponentMediator.SHOW_NOTE,ShowNotJoinGroupComponentMediatorCommand);
			//军团加入后第一面板
			facade.registerCommand(GroupComponentMediator.SHOW_NOTE,ShowGroupComponentMediatorCommand);
			//军团审核页面
			facade.registerCommand(GroupAuditComponentMediator.SHOW_NOTE,ShowGroupAuditComponentMediatorCommand);
			//军团团员查看页面
			facade.registerCommand(GroupMemberComponentMediator.SHOW_NOTE,ShowGroupMemberComponentMediatorCommand);
			//军团管理页面
			facade.registerCommand(GroupManageComponentMediator.SHOW_NOTE,ShowGroupManageComponentMediatorCommand);
			//军团成员管理页面
			facade.registerCommand(GroupMemberManageComponentMediator.SHOW_NOTE,controller.group.ShowGroupMemberManageComponentMediatorCommand);
			
			
			//军工厂信息窗口
			facade.registerCommand(FactoryInfoComponentMediator.SHOW_NOTE,ShowFactoryInfoComponentMediatorCommand);
			//军工厂窗口1
			facade.registerCommand(FactoryMakeAndServiceComponentMediator.SHOW_NOTE,ShowFactoryMakeAndServiceComponentMediatorCommand);
			//军工厂制造
			facade.registerCommand(FactoryMakeComponentMediator.SHOW_NOTE,controller.factory.ShowFactoryMakeComponentMediatorCommand);
			//武器挂件加载页面
			facade.registerCommand(FactoryArmsComponentMediator.SHOW_NOTE,controller.factory.ShowFactoryArmsComponentMediatorCommand);
			//强化界面
			facade.registerCommand(FactoryStrengthenComponentMediator.SHOW_NOTE,controller.factory.ShowFactoryStrengthenComponentMediatorCommand);
			//查看界面
			facade.registerCommand(FactoryChaKanComponentMediator.SHOW_NOTE,controller.factory.ShowFactoryChaKanComponentMediatorCommand);
			//改装界面
			facade.registerCommand(FactoryChangeComponentMediator.SHOW_NOTE,controller.factory.ShowFactoryChangeComponentMediatorCommand);
			
			////////////////////////////////////////////军团战///////////////////////////////////////////////////////////
			//主行星
			facade.registerCommand(GroupFightComponentMediator.SHOW_NOTE,ShowGroupFightComponentMediatorCommand);
			//下面菜单
			facade.registerCommand(GroupFightMenuComponentMediator.SHOW_NOTE,ShowGroupFightMenuComponentMediatorCommand);
			//上方信息显示
			facade.registerCommand(GroupFightShowComponentMediator.SHOW_NOTE,ShowGroupFightShowComponentMediatorCommand);
			//小地图
			facade.registerCommand(GroupFightMapComponentMediator.SHOW_NOTE,ShowGroupFightMapComponentMediatorCommand);
			//三个提示框
			facade.registerCommand(GroupFightThreeComponentMediator.SHOW_NOTE,ShowGroupFightThreeComponentMediatorCommand);
			facade.registerCommand(GroupFightTwoComponentMediator.SHOW_NOTE,ShowGroupFightTwoComponentMediatorCommand);
			facade.registerCommand(GroupFightOneComponentMediator.SHOW_NOTE,ShowGroupFightOneComponentMediatorCommand);
			
			////////////////////////////////////////////战场///////////////////////////////////////////////////////////
			
			//战场入口
			facade.registerCommand(BattleEnterComponentMediator.SHOW_NOTE, ShowBattleEnterComponentMediatorCommand);
			//维修提示
			facade.registerCommand(PromptWeiXiuMediator.SHOW_NOTE,ShowPrompt_weiXiuComponentMediatorCommand);
			//战场
			facade.registerCommand(BattleFightMediator.SHOW_NOTE, ShowBattleMediatorCommand);
			
			//战场
			facade.registerCommand(BattleEditMediator.SHOW_NOTE, ShowBattleEditMediatorCommand);
			
			//战场建筑信息 
			facade.registerCommand(BattleBuildInfoComponentMediator.SHOW_NOTE, ShowBattleBuildInfoComponentMediatorCommand);
			
			//战场底部界面
			facade.registerCommand(BottomViewComponentMediator.SHOW_NOTE, ShowBottomViewComponentMediatorCommand);
			
			//战场底部界面2
			facade.registerCommand(BattleFightViewComponentMediator.SHOW_NOTE, ShowBattleFightViewComponentMediatorCommand);
			
			//战场提示
			facade.registerCommand(BattleTiShiPanelComponentMediator.SHOW_NOTE, ShowBattleTiShiPanelComponentMediatorCommand);
			
			//战场时间面板
			facade.registerCommand(TimeViewComponentMediator.SHOW_NOTE, ShowTimeViewComponentMediatorCommand);
			
			//失败面板
			facade.registerCommand(BattleFailPanelComponentMediator.SHOW_NOTE, ShowBattleFailPanelComponentMediatorCommand);
			
			//胜利面板
			facade.registerCommand(BattleVictoryPanelComponentMediator.SHOW_NOTE, ShowBattleVictoryPanelComponentMediatorCommand);
			
			//提示是否对星球进行管理
			facade.registerCommand(GoToManageComponentMediator.SHOW_NOTE,ShowGoToManageComponentMediatorCommand);
			
			//玩家竞争购买要塞
			facade.registerCommand(BattleBuyComponentMediator.SHOW_NOTE,ShowBattleBuyComponentMediatorCommand);
			//复活
			facade.registerCommand(BattleRevivePanelComponentMediator.SHOW_NOTE, ShowBattleRevivePanelComponentMediatorCommand);
			
			//复活Command
			facade.registerCommand(FightResurgenceCommand.FIGHT_RESURGENCE_COMMAND, FightResurgenceCommand);
			
			//战车移动
			facade.registerCommand(FightMoveCommand.FIGHT_MOVE_COMMAND, FightMoveCommand);
			
			//开火
			facade.registerCommand(FightFireCommand.FIGHT_FIRE_COMMAND, FightFireCommand);
			
			//新角色进入房间
			facade.registerCommand(FightNewPlayerCommand.FIGHT_NEWPLAYER_COMMAND, FightNewPlayerCommand);
			
			//锁定
			facade.registerCommand(FightLockCommand.FIGHT_LOCK_COMMAND, FightLockCommand);
			
			//爆炸控制器
			facade.registerCommand(FightExplodeCommand.FIGHT_EXPLODE_COMMAND, FightExplodeCommand);
			
			//拾取物品控制器
			facade.registerCommand(FightItemCommand.FIGHT_ITEM_COMMAND, FightItemCommand);
			
			//生成小飞机
			facade.registerCommand(FightCreateFeiJiCommand.CREATE_FEI_JI_COMMAND, FightCreateFeiJiCommand);
			
			//伤害
			facade.registerCommand(FightHitCommand.FIGHT_HIT_COMMAND, FightHitCommand);
			
			//获得荣誉  
			facade.registerCommand(FightDropHonorCommand.FIGHT_DROP_HONOR_COMMAND, FightDropHonorCommand);
			
			//战场编辑条件弹出框
			facade.registerCommand(battleEditorConditionComponentMediator.SHOW_NOTE,ShowbattleEditorConditionComponentMediatorCommand);
        }
    }
}