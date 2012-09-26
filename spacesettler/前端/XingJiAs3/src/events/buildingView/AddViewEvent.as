package events.buildingView
{
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 *登陆
	 * @author zn
	 *
	 */
	public class AddViewEvent extends Event
	{
		public static const ADDDIANCHANGCREATEVIEW_EVENT:String="addDianChangCreateViewEvent";
		public static const ADDCHUANQINCREATEVIEW_EVENT:String="addChuanQinCreateViewEvent";
		public static const ADDCANGKUCREATEVIEW_EVENT:String="addCangKuCreateViewEvent";
		public static const ADDYELIANCREATEVIEW_EVENT:String="addYeLianCreateViewEvent";
		public static const ADDKEJICREATEVIEW_EVENT:String="addKeJiCreateViewEvent";
		public static const ADDJUNGONGCREATEVIEW_EVENT:String="addJunGongCreateViewEvent";
		public static const ADDUPVIEW_EVENT:String="addUpViewEvent";
		public static const ADDINFOVIEW_EVENT:String="addInfoViewEvent";
		public static const ADDSPEEDVIEW_EVENT:String="addSpeedViewEvent";
		
		public static const ADDOTHERVIEW_EVENT:String="addOtherViewEvent";
		public static const LEFT_EVEMT:String = "leftEvent";
		public static const CLOSE_EVENT:String = "CloseEvent";

		private var _buildType:int;
		
		
		public function AddViewEvent(type:String,buildType:int=0)
		{
			super(type, false, false);
			_buildType=buildType;
		}

		public override function clone():Event
		{
			return new AddViewEvent(type,_buildType);
		}
		
		public override function toString():String
		{
			return formatToString("AddViewEvent");
		}

		public function get buildType():int
		{
			return _buildType;
		}

	}
}