package events.buildEvent
{
	import flash.events.Event;

	public class CaiKuangCheEffectEvent extends Event
	{
		public static const BACK_EVENT:String = "backEvent";
		public static const OUT_EVENT:String = "outEvent";

		public function CaiKuangCheEffectEvent(type:String)
		{
			super(type,false,false);
		}

		public override function clone():Event
		{
			return new CaiKuangCheEffectEvent(type);
		}

		public override function toString():String
		{
			return formatToString("CaiKuangCheEffectEvent");
		}
	}
}