package events.battle.fight
{
	import flash.events.Event;
	import vo.battle.fight.FightFireVO;

	/**
	 *开火事件 
	 * @author zn
	 * 
	 */	
	public class FightFireEvent extends Event
	{
		public static const FIGHT_FIRE_EVENT:String = "fightFireEvent";

		private var _fireVO:FightFireVO;

		public function FightFireEvent(type:String, fireVO:FightFireVO)
		{
			super(type,true,true);

			this._fireVO = fireVO;
		}

		public function get fireVO():FightFireVO
		{
			return _fireVO;
		}

		public override function clone():Event
		{
			return new FightFireEvent(type,fireVO);
		}

		public override function toString():String
		{
			return formatToString("FightFireEvent","fireVO");
		}
	}
}