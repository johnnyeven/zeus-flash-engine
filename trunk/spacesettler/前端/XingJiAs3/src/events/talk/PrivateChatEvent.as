package events.talk
{
	import flash.events.Event;
	
	public class PrivateChatEvent extends Event
	{
		/**
		 *从私聊选择框选择私聊 
		 */		
		public static const PRIVATE_CHAT_SELECTED_BY_PRIVATE_SELECTED:String = "privateChatSelectedByPrivateSelected";
		private var _obj:Object;
		
		private var _isPrivateSelected:Boolean;
		public function PrivateChatEvent(type:String, obj:Object = null, isPrivateSelected:Boolean = false, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		public function get obj():Object
		{
			return _obj;
		}

		public function set obj(value:Object):void
		{
			_obj = value;
		}

		public function get isPrivateSelected():Boolean
		{
			return _isPrivateSelected;
		}

		public function set isPrivateSelected(value:Boolean):void
		{
			_isPrivateSelected = value;
		}


	}
}