package events.login
{
	import flash.events.Event;
	
	/**
	 * 呢称和邮件
	 * @author lw
	 * 
	 */	
	public class PkEvent extends Event
	{
		public static const BACK_EVENT:String="back_event";
		
		public static const START_EVENT:String="start_event";
		
		private var _campID:int;
		
		public function PkEvent(type:String, alliance:int = 0)
		{
			super(type, false, false);
			
			_campID=alliance;
		}

		public override function clone():Event
		{
			return new PkEvent(type,campID);
		}
		
		public override function toString():String
		{
			return formatToString("PkEvent");
		}
		
		public function get campID():int
		{
			return _campID;
		}

	}
}