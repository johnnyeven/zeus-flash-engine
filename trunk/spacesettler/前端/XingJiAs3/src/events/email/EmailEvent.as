package events.email
{
	import flash.events.Event;
	
	/**
	 * 邮件
	 * @author lw
	 * 
	 */	
	public class EmailEvent extends Event
	{
		public static const RECEIVE_EMAIL_EVENT:String = "receiveEmailEvent";
		public static const SEND_EMAIL_EVENT:String = "sendEmailEvent";
		public static const DELETE_EMAIL_EVENT:String = "deleteEmailEvent";
		public static const DELETE_SUCCESS_EVENT:String = "deleteSuccessEvent";
		public static const CLOSE_EVENT:String = "closeEvent";
		
		public static const CLOSE_SEND_EMAIL_EVENT:String = "closeSendEmailEvent";
		public static const SEND_NEW_EMAIL_EVENT:String = "sendNewEmailEvent";
		
		/**
		 * 删除一封邮件
		 */	
		public static const DELETE_ONE_EMAIL_EVENT:String = "deleteOneEmailEvent";
		/**
		 * 删除所有已读邮件
		 */	
		public static const DELETE_ALL_READ_EMAIL_EVENT:String = "deleteAllReadEmailEvent";
		
		/**
		 * 显示邮件信息
		 */
		public static const SHOW_EMAIL_INFOR_EVENT:String = "showEmailInforEvent";
		/**
		 * 收取资源或附件
		 */		
		public static const RECEIVE_SOURCE_EVENT:String = "receiveSourceEvent";
		/**
		 * 从查看界面删除邮件
		 */		
		public static const DELETE_EMAIL_BY_VIEW_COMPONENT_EVENT:String = "deleteEmailByViewComponentEvent";
		/**
		 * 从查看界面回复邮件
		 */		
		public static const CALL_BACK_EMAIL_EVENT:String = "callBackEmailEvent";
		
		/**
		 *传送的资源数据
		 */	
		public static const SEND_SOURCE_DATA_EVENT:String = "sendSourceDataEvent";
		
		/**
		 *显示可选择好友列表
		 */	
		public static const SHOW_FRIEND_LIST_EVENT:String = "showFriendListEvent";
		/**
		 *显示可选择军团成员列表
		 */	
		public static const SHOW_ARMY_GROUP_LIST_EVENT:String = "showArmyGroupListEvent";
		
		/**
		 *将军团成员信息发给邮件
		 */	
		public static const SEND_ARMY_GROUP_INFOR_TO_EMAIL_EVENT:String = "sendArmyGroupInforToEmailEvent";
		
		private var _obj:Object;
		
		public function EmailEvent(type:String, obj:Object = null,bubbles:Boolean=false, cancelable:Boolean=false)
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