package events.talk
{
	import enum.chat.ChannelEnum;
	
	import flash.events.Event;
	
	/**
	 *聊天 
	 * @author lw
	 * 
	 */	
	public class TalkEvent extends Event
	{
		
		public static const TALK_EVENT:String="talk_event";
		public static const RONGYU_EVENT:String = "rongYuEvent";
		public static const ZHONGLAN_EVENT:String = "zhongLanEvent";
		
		public static const CHECK_OTHER_PLAYER_EVENT:String = "checkOtherPlayerEvent";
		
		public static const SHOW_BAG_COMPONENT_EVENT:String = "showBagComponentEvent";
		
		public static const SELECTED_COMPONENT_EVENT:String = "selectedComponentEvent";
		
		public static const CHECK_ID_CARD_EVENT:String = "checkIdCardEvent";
		
		public static const PRIVATE_TALK_EVENT:String = "privateTalkEvent";
			
		private var _talk:String;
		private var _channel:String;
		public function TalkEvent(type:String,talk:String,channel:String,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_talk=talk;
			_channel = channel;
		}
		
		public override function clone():Event
		{
			return new TalkEvent(type,talk,channel);
		}

		public override function toString():String
		{
			return formatToString("TalkEvent");
		}
		
		public function get talk():String
		{
			return _talk;
		}

		public function set talk(value:String):void
		{
			_talk = value;
		}

		public function get channel():String
		{
			return _channel;
		}


	}
}