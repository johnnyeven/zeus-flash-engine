package events.battle.fight
{
	import flash.events.Event;
	
	public class FightViewEvent extends Event
	{
		public static const RETURN_EVENT:String="return_event";
		
		/**
		 * 结束显示提示
		 */		
		public static const GAME_OVER_EVENT:String="game_over_event";
		
		/**
		 *显示提示 
		 */		
		public static const GAME_EVENT:String="game_event";
		
		/**
		 *游戏结束 游戏失败 
		 */		
		public static const GAME_COMPLETE_EVENT:String="game_complete_event";
		
		public static const CHANGESENCE_EVENT:String="changeSence_event";
		
		public function FightViewEvent(type:String)
		{
			super(type, false, false);
		}
	}
}