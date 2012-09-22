package events.buildingView
{
	import flash.events.Event;
	
	/**
	 * 主基地
	 * @author lw
	 * 
	 */	
	public class ZhuJiDiEvent extends Event
	{
		public static const ALLVIEW_EVENT:String = "allViewEvent";
		public static const RONGYU_EVENT:String = "rongYuEvent";
		
		public function ZhuJiDiEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new ZhuJiDiEvent(type,true,true);
		}
		
		public override function toString():String
		{
			return formatToString("ZhuJiDiEvent");
		}
	}
}