package events.battle
{
	import flash.events.Event;
	
	/**
	 * 玩家竞争购买要塞 
	 * @author lw
	 * 
	 */	
	public class BattleBuyEvent extends Event
	{
		/**
		 *玩家竞争购买要塞 
		 */		
		public static const BATTLE_BUY_EVENT:String = "battleBuyEvent";
		private var _cost:int;
		public function BattleBuyEvent(type:String,cost:int, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_cost = cost;
		}

		public function get cost():int
		{
			return _cost;
		}

		public function set cost(value:int):void
		{
			_cost = value;
		}

	}
}