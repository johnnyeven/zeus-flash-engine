package events.group
{
	import flash.events.Event;
	
	public class GroupManageEvent extends Event		
	{
		public static const GENGAI_EVENT:String="gengai_event";
		
		public static const SHENHE_EVENT:String="shenhe_event";
		
		public static const ZHIZAO_EVENT:String="zhizao_event";
		
		public static const ZHIZAO_COMPLETE_EVENT:String="zhizao_complete_event";
				
		
		private var _verification:int;
		private var _forbid_getting_warship:int;
		private var _desc:String;
		private var _makeNum:int;
		public function GroupManageEvent(type:String,verification:int,forbid_getting_warship:int,desc:String=null,makeNum:int=0)
		{
			super(type, false, false);
			_verification=verification;
			_forbid_getting_warship=forbid_getting_warship;
			_desc=desc;
			_makeNum=makeNum;
		}

		public function get desc():String
		{
			return _desc;
		}

		public function set desc(value:String):void
		{
			_desc = value;
		}

		public function get forbid_getting_warship():int
		{
			return _forbid_getting_warship;
		}

		public function set forbid_getting_warship(value:int):void
		{
			_forbid_getting_warship = value;
		}

		public function get verification():int
		{
			return _verification;
		}

		public function set verification(value:int):void
		{
			_verification = value;
		}

		public function get makeNum():int
		{
			return _makeNum;
		}

		public function set makeNum(value:int):void
		{
			_makeNum = value;
		}


	}
}