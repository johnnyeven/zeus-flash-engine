package mediator.friendList
{
	import events.friendList.FriendListEvent;
	
	import mediator.BaseMediator;
	import mediator.WindowMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.friendList.FriendListComponent;

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

		public function FriendListComponentMediator()
		{
			super(NAME, new FriendListComponent());
			comp.addEventListener(FriendListEvent.CLOSE_FRIEND_LIST_EVENT,closeHandler);
			comp.addEventListener(FriendListEvent.SEARCH_PLATER_EVENT,searchPlayerHandler);
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

		private function searchPlayerHandler(event:FriendListEvent):void
		{
			sendNotification(SearchPlayerComponentMediator.SHOW_NOTE);
		}
	}
}