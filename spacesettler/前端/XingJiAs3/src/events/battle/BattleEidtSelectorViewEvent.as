package events.battle
{
	import flash.events.Event;
	
	import vo.battle.BattleBuildVO;

	public class BattleEidtSelectorViewEvent extends Event
	{
		public static const UP_EVENT:String = "upEvent";
		public static const DOWN_EVENT:String = "downEvent";
		public static const LEFT_EVENT:String = "leftEvent";
		public static const RIGHT_EVENT:String = "rightEvent";
		
		public function BattleEidtSelectorViewEvent(type:String)
		{
			super(type,false,false);
		}

		public override function clone():Event
		{
			return new BattleEidtSelectorViewEvent(type);
		}

		public override function toString():String
		{
			return formatToString("BattleEidtSelectorViewEvent");
		}
	}
}