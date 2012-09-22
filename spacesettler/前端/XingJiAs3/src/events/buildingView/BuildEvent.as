package events.buildingView
{
	import flash.events.Event;

	public class BuildEvent extends Event
	{
		public static const UP_EVENT:String = "upEvent";
		public static const BUILD_EVENT:String = "buildEvent";
		public static const INFO_EVENT:String = "infoEvent";
		public static var SPEED_EVENT:String="speedEvent";
		public static var BACK_EVENT:String="backEvent";

		public function BuildEvent(type:String)
		{
			super(type,false,false);
		}

		public override function clone():Event
		{
			return new BuildEvent(type);
		}

		public override function toString():String
		{
			return formatToString("BuildEvent");
		}
	}
}