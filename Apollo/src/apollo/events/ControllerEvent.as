package apollo.events 
{
	/**
	 * ...
	 * @author john
	 */
	public class ControllerEvent extends TransferEvent 
	{
		public static const MOVE_INTO_POSITION: String = 'move_into_position';
		public function ControllerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}