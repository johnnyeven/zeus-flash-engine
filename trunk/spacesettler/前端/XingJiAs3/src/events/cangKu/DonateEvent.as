package events.cangKu
{
	import flash.events.Event;
	
	public class DonateEvent extends Event
	{
		public static const DONATE_EVENT:String="danateEvent";
		
		public static const DESTROY_EVENT:String="destroy_event";
		
		public static const USE_EVENT:String="use_event";
		
		public static const ADDSPACE_EVENT:String="addspace_event";
		
		public var wuPingObj:Object
		public var tempInfo:*;
		public function DonateEvent(type:String,info:*=null,obj:Object=null)
		{
			super(type, false, false);
			tempInfo=info;
			wuPingObj=obj;
		}
	}
}