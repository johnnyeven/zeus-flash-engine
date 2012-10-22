package events.battle
{
	import flash.events.Event;
	
	public class TimeViewEvent extends Event
	{
		public static const TIMEOVER_EVENT:String="TIMEOVER_EVENT";
		
		public function TimeViewEvent(type:String)
		{
			super(type, false, true);
		}
	}
}