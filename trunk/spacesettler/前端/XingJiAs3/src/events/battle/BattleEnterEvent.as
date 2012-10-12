package events.battle
{
	import flash.events.Event;
	
	import vo.cangKu.ZhanCheInfoVO;

	/**
	 *战场进入 
	 * @author zn
	 * 
	 */	
	public class BattleEnterEvent extends Event
	{
		public static const BATTLE_ENTER_EVENT:String = "battleEnterEvent";

		private var _selectedZhanChe:ZhanCheInfoVO;

		public function BattleEnterEvent(type:String, selectedZhanChe:ZhanCheInfoVO)
		{
			super(type,true,true);

			this._selectedZhanChe = selectedZhanChe;
		}

		public function get selectedZhanChe():ZhanCheInfoVO
		{
			return _selectedZhanChe;
		}

		public override function clone():Event
		{
			return new BattleEnterEvent(type,selectedZhanChe);
		}

		public override function toString():String
		{
			return formatToString("BattleEnterEvent","selectedZhanChe");
		}
	}
}