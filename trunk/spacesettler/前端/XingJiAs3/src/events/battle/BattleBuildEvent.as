package events.battle
{
	import flash.events.Event;
	import vo.battle.BattleBuildVO;

	public class BattleBuildEvent extends Event
	{
		public static const BUILD_CLICK_EVENT:String = "buildClickEvent";

		private var _buildVO:BattleBuildVO;

		public function BattleBuildEvent(type:String, buildVO:BattleBuildVO=null)
		{
			super(type,true,true);

			this._buildVO = buildVO;
		}

		public function get buildVO():BattleBuildVO
		{
			return _buildVO;
		}

		public override function clone():Event
		{
			return new BattleBuildEvent(type,buildVO);
		}

		public override function toString():String
		{
			return formatToString("BattleBuildEvent","buildVO");
		}
	}
}