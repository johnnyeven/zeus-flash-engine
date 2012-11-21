package events.cangKu
{
	import flash.events.Event;
	
	public class DonateEvent extends Event
	{
		public static const DONATE_EVENT:String="danateEvent";
		
		public static const ANWUZHI_DONATE_EVENT:String="anwuzhi_danateEvent";
		
		public static const DESTROY_EVENT:String="destroy_event";
		
		public static const USE_EVENT:String="use_event";
		
		public static const ADDSPACE_EVENT:String="addspace_event";
		
		public static const CLOSE_EVENT:String="close_event";
		
		public var wuPingObj:Object
		public var tempInfo:*;
		private var _num:int;
		public function DonateEvent(type:String,info:*=null,obj:Object=null,num:int=0)
		{
			super(type, false, false);
			tempInfo=info;
			wuPingObj=obj;
			_num=num;
		}

		public function get num():int
		{
			return _num;
		}

		public function set num(value:int):void
		{
			_num = value;
		}

	}
}