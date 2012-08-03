package Apollo.Events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author john
	 */
	public class ResourceEvent extends Event 
	{
		public static const RESOURCES_LOADED: String = 'resources_loaded';
		public function ResourceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
	}

}