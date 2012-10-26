package events.battle.fight
{
	import flash.events.Event;
	import vo.battle.fight.FightExplodeVO;

	/**
	 *飞机自爆 
	 * @author zn
	 * 
	 */	
	public class FightFeiJiZiBaoEvent extends Event
	{
		public static const FIGHT_FEI_JI_ZI_BAO_EVENT:String = "fightFeiJiZiBaoEvent";

		private var _itemVO:FightExplodeVO;

		public function FightFeiJiZiBaoEvent(type:String, itemVO:FightExplodeVO)
		{
			super(type,false,false);

			this._itemVO = itemVO;
		}

		public function get itemVO():FightExplodeVO
		{
			return _itemVO;
		}

		public override function clone():Event
		{
			return new FightFeiJiZiBaoEvent(type,itemVO);
		}

		public override function toString():String
		{
			return formatToString("FightFeiJiZiBaoEvent","itemVO");
		}
	}
}