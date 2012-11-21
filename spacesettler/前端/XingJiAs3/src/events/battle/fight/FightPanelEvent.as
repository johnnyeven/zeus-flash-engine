package events.battle.fight
{
	import flash.events.Event;
	
	public class FightPanelEvent extends Event
	{
		public static const CLOSE_EVENT:String="closeEvent";
		
		
		public function FightPanelEvent(type:String)
		{
			super(type, false, true);
		}
	}
}