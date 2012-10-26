package events.battle.fight
{
	import flash.events.Event;
	
	public class FightViewEvent extends Event
	{
		public static const RETURN_EVENT:String="return_event";
		
		public static const GAME_OVER_EVENT:String="game_over_event";
		
		public static const GAME_EVENT:String="game_event";
		
		public static const GAME_COMPLETE_EVENT:String="game_complete_event";
		
		public function FightViewEvent(type:String)
		{
			super(type, false, false);
		}
	}
}