package view.allView
{
	import flash.events.Event;
	
	import vo.plantioid.FortsInforVO;

	public class AllViewXingXingEvent extends Event
	{
		public static const CHECK_EVENT:String = "checkEvent";
		
		public static const MANAGER_EVENT:String="managerEvent";
		
		public static const ATTACK_EVENT:String="attackEvent";

		private var _fortVO:FortsInforVO;

		public function AllViewXingXingEvent(type:String, fortVO:FortsInforVO)
		{
			super(type,true,true);

			this._fortVO = fortVO;
		}

		public function get fortVO():FortsInforVO
		{
			return _fortVO;
		}

		public override function clone():Event
		{
			return new AllViewXingXingEvent(type,fortVO);
		}

		public override function toString():String
		{
			return formatToString("AllViewXingXingEvent","fortVO");
		}
	}
}