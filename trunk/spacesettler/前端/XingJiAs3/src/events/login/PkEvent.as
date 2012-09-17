package events.login
{
	import flash.events.Event;
	
	public class PkEvent extends Event
	{
		public static const BACK_EVENT:String="back_event";
		
		public static const START_EVENT:String="start_event";
		
		private var _alliance:String;
		
		public function PkEvent(type:String, alliance:String="")
		{
			super(type, false, false);
			
			_alliance=alliance;
		}

		public override function clone():Event
		{
			return new PkEvent(type,alliance);
		}
		
		public override function toString():String
		{
			return formatToString("PkEvent");
		}
		
		public function get alliance():String
		{
			return _alliance;
		}

	}
}