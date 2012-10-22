package events.factory
{
	import flash.events.Event;
	
	public class FactoryItemEvent extends Event
	{
		
		public static const ZHIZAO_COMPLETE_EVENT:String="zhizao_complete_event";
		
		
		
		public function FactoryItemEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}