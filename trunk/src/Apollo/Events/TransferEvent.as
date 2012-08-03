package Apollo.Events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author john
	 */
	public class TransferEvent extends Event 
	{
		public var data: *;
		public function TransferEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
	}

}