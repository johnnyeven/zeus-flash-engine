package events.friendList
{
	import flash.events.Event;
	
	/**
	 *好友
	 * @author lw
	 *
	 */
	public class FriendListEvent extends Event
	{
		public static const FRIEND_LIST_EVENT:String = "friendListEvent";
		
		public static const CLOSE_FRIEND_LIST_EVENT:String = "closeFriendListEvent";
		
		public static const SEARCH_PLATER_EVENT:String = "searchPlayerEvent";
		
		public static const CLOSE_SEARCH_PLAYER_EVENT:String = "closeSearchPlayerEvent";
		
		public static const RENEW_FRIENF_LIST_EVENT:String = "renewFriendListEvent";
		
		public static const ENEMY_LIST_EVENT:String ="enemyListEvent";
		
		public function FriendListEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}