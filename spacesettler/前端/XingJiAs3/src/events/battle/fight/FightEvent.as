package events.battle.fight
{
	import flash.events.Event;
	
	import view.battle.fight.FightZhanCheComponent;

	public class FightEvent extends Event
	{
		public static const FAIL_EVENT:String = "failEvent";
		
		public function FightEvent(type:String)
		{
			super(type,false,false);
		}

		public override function clone():Event
		{
			return new FightEvent(type);
		}

		public override function toString():String
		{
			return formatToString("FightEvent");
		}
	}
}