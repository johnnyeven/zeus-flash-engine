package events.talk
{
	import flash.events.Event;
	
	public class ChatEvent extends Event
	{
		/**
		 * 从聊天框选择的私聊信息
		 */		
		public static const PRIVATE_CHAT_BY_CHAT_COMPONENT:String = "privateChatByChatComponent";
		
		/**
		 *选择的聊天表情
		 */	
		public static const SELECTED_CHAT_FACE:String = "selectedChatFace";
		
		private var _obj:Object = {};
		
		public function ChatEvent(type:String, obj:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
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