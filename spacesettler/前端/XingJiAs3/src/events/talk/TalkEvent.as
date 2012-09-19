package events.talk
{
	import flash.events.Event;
	
	public class TalkEvent extends Event
	{
		
		public static const TALK_EVENT:String="talk_event"
			
		private var _talk:String;
		public function TalkEvent(type:String,tlak:String="" )
		{
			super(type, false, false);
			this.talk=talk;
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