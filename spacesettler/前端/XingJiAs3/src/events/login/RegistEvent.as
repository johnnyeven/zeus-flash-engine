package events.login
{
	import flash.events.Event;
	
	/**
	 *注册
	 * @author lw
	 *
	 */
	public class RegistEvent extends Event
	{
		public static const BACK_EVENT:String = "back_event";
		
		public static const NEXT_EVENT:String = "next_event";
		
		private var _severName:String;
		private var _userName:String;
		private var _passWord:String;
		private var _passAgainWord:String;
		
		public function RegistEvent(type:String, severName:String="", userName:String="",passWord:String="",passAgainWord:String="")
		{
			super(type, false, false);
			
			_severName = severName;
			_userName = userName;
			_passWord = passWord;
			_passAgainWord = passAgainWord;
		}

		public override function clone():Event
		{
			return new RegistEvent(type,severName,userName,passWord,passAgainWord);
		}
		
		public override function toString():String
		{
			return formatToString("RegistEvent");
		}
		
		public function get severName():String
		{
			return _severName;
		}

		public function get userName():String
		{
			return _userName;
		}

		public function get passWord():String
		{
			return _passWord;
		}

		public function get passAgainWord():String
		{
			return _passAgainWord;
		}


	}
}