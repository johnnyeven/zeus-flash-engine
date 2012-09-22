package events.buildingView
{
	import flash.events.Event;
	
	/**
	 *登陆
	 * @author zn
	 *
	 */
	public class UpLevelEvent extends Event
	{
		public static const UPLEVEL_EVENT:String="upLevelEvent";
		public static const BACK_EVENT:String = "back_event";
		
		
		public function UpLevelEvent(type:String)
		{
			super(type, false, false);
		}
		
		public override function clone():Event
		{
			return new UpLevelEvent(type);
		}
		
		public override function toString():String
		{
			return formatToString("UpLevelEvent");
		}
	}
}