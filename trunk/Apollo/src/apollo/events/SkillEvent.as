package apollo.events 
{
	/**
	 * ...
	 * @author john
	 */
	public class SkillEvent extends TransferEvent 
	{
		public static const SING_COMPLETED: String = 'sing_completed';
		public static const FIRE_COMPLETED: String = 'fire_completed';
		public static const RANGE_SELECTED: String = 'range_selected';
		
		public function SkillEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
	}

}