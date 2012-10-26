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
		
		/**
		 *关闭好友列表界面
		 */	
		public static const CLOSE_FRIEND_LIST_EVENT:String = "closeFriendListEvent";
		
		/**
		 *关闭敌人列表界面
		 */	
		public static const CLOSE_ENEMY_LIST_EVENT:String = "closeEnemyListEvent";
		/**
		 *搜询玩家 
		 */		
		public static const SEARCH_PLATER_EVENT:String = "searchPlayerEvent";
		
		public static const CLOSE_SEARCH_PLAYER_EVENT:String = "closeSearchPlayerEvent";
		
		public static const RENEW_FRIENF_LIST_EVENT:String = "renewFriendListEvent";
		
		public static const ENEMY_LIST_EVENT:String ="enemyListEvent";
		/**
		 *查看玩家军官证
		 */	
		public static const CHECK_PLAYER_ID_CARD_EVENT:String = "checkPlayerIdCardEvent";
		/**
		 *删除好友
		 */	
		public static const DELETED_FRIEND_INFOR_EVENT:String = "deletedFriendInforEvent";
		/**
		 *与好友私聊
		 */	
		public static const CHAT_WITH_FRIEND_EVENT:String = "chatWithFriendEvent";
		
		/**
		 *反击敌人
		 */	
		public static const ATTACK_ENEMY_EVENT:String = "attackEnemyEvent";
		
		/**
		 *搜寻界面中 查看玩家军官证
		 */	
		public static const SEARCH_CHECK_PLAYER_ID_CARD_EVENT:String = "searchCheckPlayerIdCardEvent";
		/**
		 *搜寻界面中 添加好友
		 */	
		public static const SEARCH_ADD_FRIEND_EVENT:String = "searchAddFriendEvent";
		
		/**
		 *军官证界面中查看要塞
		 */	
		public static const CHECK_FORT_BY_ID_CARD_EVENT:String = "checkFortByIdCardEvent";
		
		/**
		 *军官证界面 中  添加好友
		 */	
		public static const ADD_FRIEND_BY_ID_CARD_EVENT:String = "addFriendByIdCardEvent";
		
		/**
		 *军官证界面 中  发送邮件
		 */	
		public static const SEND_EMAIL_BY_ID_CARD_EVENT:String = "sendEmailByIdCardEvent";
		
		/**
		 * 向邮件界面发送数据
		 */	
		public static const SEND_DATA_TO_EMAIL_EVENT:String = "sendDataToEmailEvent";
		
		private var _obj:Object;
		public function FriendListEvent(type:String,obj:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_obj = obj;
		}

		public function get obj():Object
		{
			return _obj;
		}

		public function set obj(value:Object):void
		{
			_obj = value;
		}

	}
}