package events.allView
{
	import flash.events.Event;
	
	/**
	 * 总览和荣誉
	 * @author lw
	 * 
	 */	
	public class AllViewEvent extends Event
	{
		public static const VIEW_START_EVENT:String = "viewStartEvent";
		public static const VIEW_RONGYU_EVENT:String = "viewRongYuEvent";
		public static const CLOSED_EVENT:String = "closedEvent";
		public static const CLOSED_RONGYU_EVENT:String = "closedRongYuEvent";
		public static const ALLVIEW_EVENT:String = "allViewEvent";
		public static const RONGYU_EVENT:String = "rongYuEvent";
		
		public function AllViewEvent(type:String)
		{
			super(type, false, false);
		}
		
		public override function clone():Event
		{
			return new AllViewEvent(type);
		}
		
		public override function toString():String
		{
			return formatToString("AllViewEvent");
		}
	}
}