package Apollo.Events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author john
	 */
	public class GameEvent extends Event 
	{
		public static const GAME_START: String = 'game_start';
		public function GameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
	}

}