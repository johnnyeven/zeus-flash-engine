package events.login
{
	import flash.events.Event;

	/**
	 *登陆
	 * @author zn
	 *
	 */
	public class LoginEvent extends Event
	{
		public static const LOGIN_EVENT:String="loginEvent";
		public static const BACK_EVENT:String = "back_event";
		public static const NULL_EVENT:String = "null_event";
		private var _userName:String;
		private var _password:String;

		public function LoginEvent(type:String, userName:String="", password:String="")
		{
			super(type, false, false);
			this._userName=userName;
			this._password=password;
		}

		public override function clone():Event
		{
			return new LoginEvent(type,userName,password);
		}

		public override function toString():String
		{
			return formatToString("LoginEvent");
		}


		public function get userName():String
		{
			return _userName;
		}

		public function get password():String
		{
			return _password;
		}

	}
}