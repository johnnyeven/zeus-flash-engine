package mediator.mainView
{
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.StringUtil;
    
    import controller.EnterMainSenceViewCommand;
    import controller.mainSence.ShowMainSenceComponentMediatorCommand;
    import controller.plantioid.ShowPlantioidComponentMediatorCommand;
    import controller.task.TaskCommand;
    
    import enum.BuildTypeEnum;
    import enum.SenceTypeEnum;
    
    import events.buildingView.ZhuJiDiEvent;
    import events.friendList.FriendListEvent;
    import events.talk.ChatEvent;
    import events.talk.TalkEvent;
    
    import flash.events.Event;
    
    import mediator.BaseMediator;
    import mediator.MainMediator;
    import mediator.allView.AllViewComponentMediator;
    import mediator.allView.RongYuComponentMediator;
    import mediator.battle.BattleFightMediator;
    import mediator.cangKu.CangkuPackageViewComponentMediator;
    import mediator.email.EmailComponentMediator;
    import mediator.friendList.EnemyListComponentMediator;
    import mediator.friendList.ViewIdCardComponentMediator;
    import mediator.giftBag.GiftBagViewComponentMediator;
    import mediator.group.GroupComponentMediator;
    import mediator.group.NotJoinGroupComponentMediator;
    import mediator.mainSence.MainSenceComponentMediator;
    import mediator.plantioid.PlantioidComponentMediator;
    import mediator.prompt.PromptCloseMediator;
    import mediator.ranking.RankingComponentMediator;
    import mediator.shangCheng.ShangChengComponentMediator;
    import mediator.systemView.SystemComponentMediator;
    
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;
    
    import proxy.BuildProxy;
    import proxy.allView.AllViewProxy;
    import proxy.friendList.FriendProxy;
    import proxy.group.GroupProxy;
    import proxy.rankingProxy.RankingProxy;
    import proxy.taskGift.GiftBagProxy;
    import proxy.userInfo.UserInfoProxy;
    
    import view.mainView.MainViewComponent;
    
    import vo.GlobalData;
    import vo.userInfo.UserInfoVO;

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

        public static const HIDE_RIGHT_VIEW_NOTE:String = "HIDE_RIGHT_VIEW_NOTE" + NAME;
		
        public static const SHOW_RIGHT_VIEW_NOTE:String = "SHOW_RIGHT_VIEW_NOTE" + NAME;

        public static const HIDE_RENWU_VIEW_NOTE:String = "HIDE_RENWU_VIEW_NOTE" + NAME;
		
        public static const SHOW_RENWU_VIEW_NOTE:String = "SHOW_RENWU_VIEW_NOTE" + NAME;
		/**
		 * 新邮件提示
		 */		
		public static const SHOW_NEW_EMAIL_TIPS_NOTE:String = "showNewEmailTips" + NAME +"Note";
		/**
		 * 礼包提示
		 */		
		public static const SHOW_GIFT_TIPS_NOTE:String = "showGiftTips" + NAME +"Note";
		
		public static const SET_PLANEBTN_NOTE:String = "setPlaneBtn" + NAME +"Note";
		
		
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

			if(userInforProxy.userInfoVO.received_daily_rewards!="" && userInforProxy.userInfoVO.received_daily_rewards=="false")
				comp.prompComp.gift.visible = true;
			if(userInforProxy.userInfoVO.received_continuous_rewards!="" && userInforProxy.userInfoVO.received_continuous_rewards=="false")
				comp.prompComp.gift.visible = true;
			if(userInforProxy.userInfoVO.received_online_rewards!="" && userInforProxy.userInfoVO.received_online_rewards=="false")
				comp.prompComp.gift.visible = true;
			
            comp.addEventListener(ZhuJiDiEvent.RONGYU_EVENT, rongYuHandler);
            comp.addEventListener(ZhuJiDiEvent.SYSTEM_EVENT, systemHandler);
            comp.addEventListener(ZhuJiDiEvent.ALLVIEW_EVENT, zhongLanHandler);
            comp.addEventListener(ZhuJiDiEvent.SHOP_EVENT, shopHandler);
            comp.addEventListener(ZhuJiDiEvent.PLANET_EVENT, planetHandler);
            comp.addEventListener(ZhuJiDiEvent.CANGKU_EVENT, cangKuHandler);
            comp.addEventListener(ZhuJiDiEvent.MAIN_SENCE_EVENT, mainSenceHandler);
			
			comp.addEventListener(ZhuJiDiEvent.RANKING_EVENT,rankingHandler);
			comp.addEventListener(ZhuJiDiEvent.GROUP_EVENT,groupHandler);
			
			comp.addEventListener(FriendListEvent.ENEMY_LIST_EVENT,enemyListHandler);
			comp.addEventListener(FriendListEvent.CHECK_PLAYER_ID_CARD_EVENT,showCardHandler);
			
			comp.addEventListener(ZhuJiDiEvent.JOB_EVENT,jobHandler);
			comp.addEventListener(ZhuJiDiEvent.EMAIL_EVENT,emailHAndler);
			comp.addEventListener(ZhuJiDiEvent.GIFT_EVENT,giftHandler);
			
			comp.prompComp.visible=true;
			//查看军官证
			comp.addEventListener(TalkEvent.CHECK_ID_CARD_EVENT,checkIdCardHandler);
			//私聊
			comp.addEventListener(ChatEvent.PRIVATE_CHAT_BY_CHAT_COMPONENT,privateTalkHandler);
			//复制聊天信息到剪切板
			comp.addEventListener(TalkEvent.COPY_INFOR_EVENT,copyHandler);
        }
		
        /**
         *添加要监听的消息
         * @return
         *
         */
        override public function listNotificationInterests():Array
        {
            return [ DESTROY_NOTE,HIDE_RIGHT_VIEW_NOTE,
                     SHOW_TOP_VIEW_NOTE, HIDE_TOP_VIEW_NOTE,
					 SHOW_RIGHT_VIEW_NOTE,SET_PLANEBTN_NOTE,
					 SHOW_NEW_EMAIL_TIPS_NOTE,
					 SHOW_GIFT_TIPS_NOTE,HIDE_RENWU_VIEW_NOTE,
					 SHOW_RENWU_VIEW_NOTE];
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
                case HIDE_RIGHT_VIEW_NOTE:
                {
                    comp.controlComp.visible = false;
                    break;
                }
                case SHOW_RIGHT_VIEW_NOTE:
                {
                    comp.controlComp.visible = true;
                    break;
                }
				case SHOW_NEW_EMAIL_TIPS_NOTE:
				{
					comp.prompComp.mail.visible = true;
					break;
				}
				case SHOW_GIFT_TIPS_NOTE:
				{
					comp.prompComp.gift.visible = true;
					break;
				}
				case HIDE_RENWU_VIEW_NOTE:
				{
					comp.prompComp.visible=false;
					break;
				}
				case SHOW_RENWU_VIEW_NOTE:
				{
					comp.prompComp.visible=true;
					break;
				}
				case SET_PLANEBTN_NOTE:
				{
					comp.controlComp.setPlaneBtn();
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
			var rankProxy:RankingProxy=getProxy(RankingProxy);
			rankProxy.rank_info(function():void
			{				
				sendNotification(RankingComponentMediator.SHOW_NOTE);
			});
		}
		
        public override function show():void
        {
			Main.removeBG();
            MainMediator(getMediator(MainMediator)).component.addView(uiComp);
        }

        private function systemHandler(event:ZhuJiDiEvent):void
        {
            sendNotification(SystemComponentMediator.SHOW_NOTE);
        }

        private function zhongLanHandler(event:ZhuJiDiEvent):void
        {
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
			sendNotification(HIDE_RENWU_VIEW_NOTE);
            sendNotification(PlantioidComponentMediator.SHOW_NOTE);
			buildProxy.isBuild=false;
        }

        protected function cangKuHandler(event:Event):void
        {
			if(!buildProxy.hasBuild(BuildTypeEnum.CANGKU))
			{
				var obj:Object={}
				obj.showLable=MultilanguageManager.getString("notHasCangKu");
				sendNotification(PromptCloseMediator.SHOW_NOTE,obj);
				return;
			}

			var userID:String=UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO.player_id;
//			var giftProxy:giftBagProxy=getProxy(giftBagProxy);
//			giftProxy.checkReward(userID);
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
			
			Main.addBG();
			sendNotification(SHOW_RENWU_VIEW_NOTE);
            sendNotification(EnterMainSenceViewCommand.ENTER_MAIN_SENCE_VIEW_COMMAND);
        }
		
		protected function groupHandler(event:Event):void
		{
			//if(userInforProxy.userInfoVO.legion_id!=null)
			if(!StringUtil.isEmpty(userInforProxy.userInfoVO.legion_id))
			{
				groupProxy.refreshGroup(function():void
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
		
		private function enemyListHandler(event:FriendListEvent):void
		{
			sendNotification(EnemyListComponentMediator.SHOW_NOTE,userInforProxy.userInfoVO.player_id);
		}
		
		protected function jobHandler(event:Event):void
		{
			var userInfoVO:UserInfoVO=userInforProxy.userInfoVO;
			var obj:Object={index:userInfoVO.index, isFinished:userInfoVO.is_finished ,isRewarded:userInfoVO.is_rewarded};
			sendNotification(TaskCommand.ADDTASKINFO_COMMAND,obj);
		}
		
		private function emailHAndler(event:ZhuJiDiEvent):void
		{
			sendNotification(EmailComponentMediator.SHOW_NOTE);
		}
		
		private function giftHandler(event:ZhuJiDiEvent):void
		{
			var giftProxy:GiftBagProxy=getProxy(GiftBagProxy);
			giftProxy.checkReward(function ():void
			{
				sendNotification(GiftBagViewComponentMediator.SHOW_NOTE);
			});
		}
		
		private function checkIdCardHandler(event:TalkEvent):void
		{
			sendNotification(ChatViewMediator.SHOW_CHECKID,event.talk);
		}
		
		private function privateTalkHandler(event:ChatEvent):void
		{
			sendNotification(ChatViewMediator.SHOW_PRIVATE_TALK,event.obj);
		}
		
		private function showCardHandler(evnet:FriendListEvent):void
		{
			var userInfoVO:UserInfoVO=UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO;
			var friendProxy:FriendProxy=getProxy(FriendProxy);
			friendProxy.checkOtherPlayer(userInfoVO.player_id,function():void
			{
				sendNotification(ViewIdCardComponentMediator.SHOW_NOTE);
			});
		}

		private function copyHandler(event:TalkEvent):void
		{
			sendNotification(ChatViewMediator.SHOW_COPY_INFOR,event.talk);
		}
		
    }
}
