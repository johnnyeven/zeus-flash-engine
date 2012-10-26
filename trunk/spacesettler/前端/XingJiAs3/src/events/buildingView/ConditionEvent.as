package events.buildingView
{
	import flash.events.Event;
	
	public class ConditionEvent extends Event
	{
		public static const ADDCONDITIONVIEW_EVENT:String="addconditionview_event";
		
		public static const DUIHUAN_EVENT:String="duihuan_event";
		public static const YANJIU_EVENT:String="yanjiu_event";
		public static const SHENGCHAN_EVENT:String="shengchan_event";
		public static const SHENGJI_EVENT:String="shengji_event";
		public static const SHENGJIKEJI_EVENT:String="shengjikeji_event";
		public static const CREATEKEJI_EVENT:String="createkeji_event";
		public static const CLOSE_EVENT:String="close_event";
		
		public var conditionArr:Array;
		
		public function ConditionEvent(type:String, arr:Array=null)
		{
			super(type, true, true);
			conditionArr=arr;
		}

	}
}