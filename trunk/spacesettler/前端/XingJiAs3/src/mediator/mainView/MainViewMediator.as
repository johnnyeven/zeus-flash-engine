package mediator.mainView
{
    import controller.EnterMainSenceViewCommand;
    import controller.mainSence.ShowMainSenceComponentMediatorCommand;
    import controller.plantioid.ShowPlantioidComponentMediatorCommand;
    
    import enum.SenceTypeEnum;
    
    import events.buildingView.ZhuJiDiEvent;
    
    import flash.events.Event;
    
    import mediator.BaseMediator;
    import mediator.MainMediator;
    import mediator.allView.AllViewComponentMediator;
    import mediator.allView.RongYuComponentMediator;
    import mediator.shangCheng.ShangChengComponentMediator;
    import mediator.battle.BattleMediator;
    import mediator.cangKu.CangkuPackageViewComponentMediator;
    import mediator.group.GroupComponentMediator;
    import mediator.group.NotJoinGroupComponentMediator;
    import mediator.mainSence.MainSenceComponentMediator;
    import mediator.plantioid.PlantioidComponentMediator;
    import mediator.ranking.RankingComponentMediator;
    import mediator.systemView.SystemComponentMediator;
    
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;
    
    import proxy.BuildProxy;
    import proxy.allView.AllViewProxy;
    import proxy.group.GroupProxy;
    import proxy.userInfo.UserInfoProxy;
    
    import view.mainView.MainViewComponent;
    
    import vo.GlobalData;


    /**
     *游戏主界面
     * @author zn
     *
     */
    public class MainViewMediator extends BaseMediator implements IMediator
    {
        public static const NAME:String = "MainViewMediator";

        public static const SHOW_NOTE:String = "show" + NAME + "Note";

        public static const DESTROY_NOTE:String = "destroy" + NAME + "Note";

        public static const SHOW_TOP_VIEW_NOTE:String = "SHOW_TOP_VIEW_NOTE" + NAME;

        public static const HIDE_TOP_VIEW_NOTE:String = "HIDE_TOP_VIEW_NOTE" + NAME;

        private var allViewProxy:AllViewProxy;

        private var userInforProxy:UserInfoProxy;

        private var id:String;
		
		private var buildProxy:BuildProxy;
  		private var groupProxy:GroupProxy;
        public function MainViewMediator()
        {
            super(NAME, new MainViewComponent());

            _popUp = false;
			
			
			groupProxy=getProxy(GroupProxy);
            allViewProxy = getProxy(AllViewProxy);
            userInforProxy = getProxy(UserInfoProxy);
			buildProxy = getProxy(BuildProxy);
            id = userInforProxy.userInfoVO.id;

            comp.addEventListener(ZhuJiDiEvent.RONGYU_EVENT, rongYuHandler);
            comp.addEventListener(ZhuJiDiEvent.SYSTEM_EVENT, systemHandler);
            comp.addEventListener(ZhuJiDiEvent.ALLVIEW_EVENT, zhongLanHandler);
            comp.addEventListener(ZhuJiDiEvent.SHOP_EVENT, shopHandler);
            comp.addEventListener(ZhuJiDiEvent.PLANET_EVENT, planetHandler);
            comp.addEventListener(ZhuJiDiEvent.CANGKU_EVENT, cangKuHandler);
            comp.addEventListener(ZhuJiDiEvent.MAIN_SENCE_EVENT, mainSenceHandler);
			
			comp.addEventListener(ZhuJiDiEvent.RANKING_EVENT,rankingHandler);
			comp.addEventListener(ZhuJiDiEvent.GROUP_EVENT,groupHandler);
        }
		
        /**
         *添加要监听的消息
         * @return
         *
         */
        override public function listNotificationInterests():Array
        {
            return [ DESTROY_NOTE,
                     SHOW_TOP_VIEW_NOTE, HIDE_TOP_VIEW_NOTE ];
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
                    destroy();
                    break;
                }
                case SHOW_TOP_VIEW_NOTE:
                {
                    comp.topComp.visible = true;
                    break;
                }
                case HIDE_TOP_VIEW_NOTE:
                {
                    comp.topComp.visible = false;
                    break;
                }
            }
        }


        /**
         *获取界面
         * @return
         *
         */
        public function get comp():MainViewComponent
        {
            return viewComponent as MainViewComponent;
        }

        /**
         *显示界面
         *
         */
		
		protected function rankingHandler(event:Event):void
		{
//			sendNotification(RankingComponentMediator.SHOW_NOTE);
			sendNotification(BattleMediator.SHOW_NOTE);
		}
		
        public override function show():void
        {
            MainMediator(getMediator(MainMediator)).component.addView(uiComp);
        }

        private function systemHandler(event:ZhuJiDiEvent):void
        {
            sendNotification(SystemComponentMediator.SHOW_NOTE);
        }

        private function zhongLanHandler(event:ZhuJiDiEvent):void
        {
			//TODO:zn 暂用
//            allViewProxy.allView(id);
            sendNotification(AllViewComponentMediator.SHOW_NOTE);
        }

        protected function shopHandler(event:Event):void
        {
            sendNotification(ShangChengComponentMediator.SHOW_NOTE);
        }

        protected function planetHandler(event:Event):void
        {
            if (GlobalData.currentSence == SenceTypeEnum.PLANT)
                return;

            sendNotification(PlantioidComponentMediator.SHOW_NOTE);
			buildProxy.isBuild=false;
        }

        protected function cangKuHandler(event:Event):void
        {
            sendNotification(CangkuPackageViewComponentMediator.SHOW_NOTE);
        }

        private function rongYuHandler(event:ZhuJiDiEvent):void
        {
 //           allViewProxy.allView(id);
            sendNotification(RongYuComponentMediator.SHOW_NOTE);
        }

        protected function mainSenceHandler(event:Event):void
        {
            if (GlobalData.currentSence == SenceTypeEnum.MAIN)
                return;
            sendNotification(EnterMainSenceViewCommand.ENTER_MAIN_SENCE_VIEW_COMMAND);
        }
		
		protected function groupHandler(event:Event):void
		{
			if(userInforProxy.userInfoVO.legion_id!=null)
			{
				groupProxy.refreshGroup(userInforProxy.userInfoVO.player_id,function():void
				{
					sendNotification(GroupComponentMediator.SHOW_NOTE);
					
				});
			}else
			{
				groupProxy.searchGroup("",function():void
				{
					sendNotification(NotJoinGroupComponentMediator.SHOW_NOTE);
					
				});
				
			}
			
		}		
		
    }
}
