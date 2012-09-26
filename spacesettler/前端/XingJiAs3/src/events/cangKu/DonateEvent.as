package events.cangKu
{
	import flash.events.Event;
	
	public class DonateEvent extends Event
	{
		public static const DONATE_EVENT:String="danateEvent";
		
		public function DonateEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}