package mediator.friendList
{
	import com.greensock.TweenLite;
	
	import events.friendList.FriendListEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.WindowMediator;
	import mediator.email.SendEmailComponentMediator;
	import mediator.mainView.ChatViewMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.friendList.FriendProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import view.friendList.FriendListComponent;
	
	import vo.allView.FriendInfoVo;

	/**
	 *好友列表
	 * @author lw
	 *
	 */
	public class FriendListComponentMediator extends WindowMediator implements IMediator
	{
		public static const NAME:String="FriendListComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		private var friendProxy:FriendProxy;
		private var userInforProxy:UserInfoProxy;
		public function FriendListComponentMediator()
		{
			super(NAME, new FriendListComponent());
			comp.med=this;
			level = 1;
			friendProxy = getProxy(FriendProxy);
			userInforProxy = getProxy(UserInfoProxy);
			
			comp.addEventListener(FriendListEvent.CLOSE_FRIEND_LIST_EVENT,closeHandler);
			comp.addEventListener(FriendListEvent.SEARCH_PLATER_EVENT,searchPlayerHandler);
			comp.addEventListener(FriendListEvent.RENEW_FRIENF_LIST_EVENT,renewFriendListHandler);
			
			comp.addEventListener(FriendListEvent.CHECK_PLAYER_ID_CARD_EVENT,checkPlayerIdCardHandler);
			comp.addEventListener(FriendListEvent.DELETED_FRIEND_INFOR_EVENT,deletedFriendHandler);
			comp.addEventListener(FriendListEvent.CHAT_WITH_FRIEND_EVENT,privateChatWithFriendHandler);
			comp.addEventListener(FriendListEvent.SEND_DATA_TO_EMAIL_EVENT,sendDatToEmailHandler);
		}
		
		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [DESTROY_NOTE];
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
					//销毁对象
					destroy();
					break;
				}
			}
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		protected function get comp():FriendListComponent
		{
			return viewComponent as FriendListComponent;
		}

		/**
		 * 设置mediator的显示层级
		 * @param mediatorLevel
		 * 
		 */		
		public function setMediatorLevel(mediatorLevel:int):void
		{
			comp.med=this;
			level = mediatorLevel;
		}
		
	    public function setIsSendEmail(vaule:Boolean):void
		{
			comp.isSendEmail = vaule;
		}
		
		private function searchPlayerHandler(event:FriendListEvent):void
		{
			friendProxy.searchPlayerList.length = 0;
			sendNotification(SearchPlayerComponentMediator.SHOW_NOTE);
		}
		
		private function renewFriendListHandler(event:FriendListEvent):void
		{
			//刷新列表
			friendProxy.getFriendList(userInforProxy.userInfoVO.player_id);
		}
		
		private function checkPlayerIdCardHandler(event:FriendListEvent):void
		{
			if((event.obj as FriendInfoVo).componentInforType == "shangComponentSkin")
			{
				comp.shangRemove_clickHandler(null);
			}
			else if((event.obj as FriendInfoVo).componentInforType == "xiaComponentSkin")
			{
				comp.xiaRemove_clickHandler(null);
			}
			friendProxy.checkOtherPlayer((event.obj as FriendInfoVo).id,function():void
			{
				sendNotification(ViewIdCardComponentMediator.SHOW_NOTE);
			});
		}
		
		private function deletedFriendHandler(event:FriendListEvent):void
		{
			if((event.obj as FriendInfoVo).componentInforType == "shangComponentSkin")
			{
				comp.shangRemove_clickHandler(null);
			}
			else if((event.obj as FriendInfoVo).componentInforType == "xiaComponentSkin")
			{
				comp.xiaRemove_clickHandler(null);
			}
			friendProxy.deletedFriend((event.obj as FriendInfoVo).id);
		}
		
		private function privateChatWithFriendHandler(event:FriendListEvent):void
		{
			if((event.obj as FriendInfoVo).componentInforType == "shangComponentSkin")
			{
				comp.shangRemove_clickHandler(null);
			}
			else if((event.obj as FriendInfoVo).componentInforType == "xiaComponentSkin")
			{
				comp.xiaRemove_clickHandler(null);
			}
			//私聊
			sendNotification(ChatViewMediator.SHOW_PRIVATE_TALK_SELECTED_BY_FRIENDLIST,event.obj);
		}
		
		private function sendDatToEmailHandler(event:FriendListEvent):void
		{
			//关闭自己
			sendNotification(DESTROY_NOTE);
			sendNotification(SendEmailComponentMediator.SEND_EMAIL_DATA_BY_FRIEND_LISE,event.obj);
		}
	}
}