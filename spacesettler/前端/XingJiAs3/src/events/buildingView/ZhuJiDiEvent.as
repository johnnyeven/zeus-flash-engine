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
		
		public static const CANGKU_EVENT:String = "cangKuEvent";
		
		public static const PLANET_EVENT:String="planet_event";
		
		public static const SHOP_EVENT:String="shop_event";
		
		public static const SYSTEM_EVENT:String="system_event";
		
		public static const MAIN_SENCE_EVENT:String="MAIN_SENCE_EVENT";
		
		
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