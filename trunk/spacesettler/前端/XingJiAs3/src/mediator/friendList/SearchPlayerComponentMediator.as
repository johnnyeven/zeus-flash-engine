package mediator.friendList
{
	import com.greensock.TweenLite;
	
	import events.friendList.FriendListEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.WindowMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.friendList.FriendProxy;
	
	import view.friendList.SearchPlayerComponent;
	
	import vo.allView.FriendInfoVo;

	/**
	 *搜索玩家
	 * @author lw
	 *
	 */
	public class SearchPlayerComponentMediator extends WindowMediator implements IMediator
	{
		public static const NAME:String="SearchPlayerComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		private var friendListProxy:FriendProxy;
		public function SearchPlayerComponentMediator()
		{
			super(NAME, new SearchPlayerComponent());
			comp.med=this;
			level = 2;
			friendListProxy = getProxy(FriendProxy);
			
			comp.addEventListener(FriendListEvent.CLOSE_SEARCH_PLAYER_EVENT,closeHandler);
			comp.addEventListener(FriendListEvent.SEARCH_PLATER_EVENT,searchPlayerHandler);

			comp.addEventListener(FriendListEvent.SEARCH_CHECK_PLAYER_ID_CARD_EVENT,checkPlayerIdCardHandler);
			comp.addEventListener(FriendListEvent.SEARCH_ADD_FRIEND_EVENT,addFriendHandler);
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
		protected function get comp():SearchPlayerComponent
		{
			return viewComponent as SearchPlayerComponent;
		}
		
		private function searchPlayerHandler(event:FriendListEvent):void
		{
			friendListProxy.searchPlayer(event.obj as String);
		}

		private function checkPlayerIdCardHandler(event:FriendListEvent):void
		{
			if((event.obj as FriendInfoVo).componentInforType == "researchShangComponentSkin")
			{
				comp.shangRemove_clickHandler(null);
			}
			else if((event.obj as FriendInfoVo).componentInforType == "researchXiaComponentSkin")
			{
				comp.xiaRemove_clickHandler(null);
			}
			friendListProxy.checkOtherPlayer((event.obj as FriendInfoVo).id,function():void
			{
				sendNotification(ViewIdCardComponentMediator.SHOW_NOTE);
			});
		}
		
		private function addFriendHandler(event:FriendListEvent):void
		{
			if((event.obj as FriendInfoVo).componentInforType == "researchShangComponentSkin")
			{
				comp.shangRemove_clickHandler(null);
			}
			else if((event.obj as FriendInfoVo).componentInforType == "researchXiaComponentSkin")
			{
				comp.xiaRemove_clickHandler(null);
			}
			friendListProxy.addFriend((event.obj as FriendInfoVo).id);
		}
	}
}