package events.battle
{
	import flash.events.Event;
	
	public class BottomViewEvent extends Event
	{
		public static const EXIT_EVENT:String="EXIT_EVENT";
		
		public function BottomViewEvent(type:String)
		{
			super(type, false, true);
		}
	}
}