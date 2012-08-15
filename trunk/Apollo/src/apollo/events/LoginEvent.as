package apollo.events 
{
	/**
	 * ...
	 * @author john
	 */
	public class LoginEvent extends TransferEvent 
	{
		public static const GAME_START: String = "game_start";
		public static const CHARACTER_INIT: String = "character_init";
		
		public function LoginEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
	}

}