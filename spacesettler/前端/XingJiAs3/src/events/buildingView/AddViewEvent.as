package events.buildingView
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import view.buildingView.SelectorViewComponent;
	
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

		public static const SEND_STAR_EVENT:String = "send_star_event";
		private var _buildType:int;
		
		private var _comp:SelectorViewComponent;
		public function AddViewEvent(type:String,buildType:int=0,comp:SelectorViewComponent=null)
		{
			super(type, false, false);
			_buildType=buildType;
			_comp=comp;
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

		public function get comp():SelectorViewComponent
		{
			return _comp;
		}

		public function set comp(value:SelectorViewComponent):void
		{
			_comp = value;
		}


	}
}