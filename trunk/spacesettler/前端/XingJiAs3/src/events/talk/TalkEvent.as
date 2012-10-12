package events.talk
{
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
			
		private var _talk:String;
		public function TalkEvent(type:String,tlak:String="" )
		{
			super(type, false, false);
			this.talk=talk;
		}
		
		public override function clone():Event
		{
			return new TalkEvent(type,talk);
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

	}
}