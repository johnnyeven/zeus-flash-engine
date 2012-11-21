package events.battle.fight
{
	import flash.events.Event;
	import vo.battle.fight.FightItemVO;

	/**
	 *战斗物品 
	 * @author zn
	 * 
	 */	
	public class FightItemEvent extends Event
	{
		public static const FIGHT_ITEM_EVENT:String = "fightItemEvent";

		private var _itemVO:FightItemVO;

		public function FightItemEvent(type:String, itemVO:FightItemVO)
		{
			super(type,false,false);

			this._itemVO = itemVO;
		}

		public function get itemVO():FightItemVO
		{
			return _itemVO;
		}

		public override function clone():Event
		{
			return new FightItemEvent(type,itemVO);
		}

		public override function toString():String
		{
			return formatToString("FightItemEvent","itemVO");
		}
	}
}