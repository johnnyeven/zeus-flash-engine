package events.login
{
	import flash.events.Event;
	
	/**
	 *注册第二步
	 * @author lw
	 *
	 */
	public class NameInforEvent extends Event
	{
		public static const BACK_EVENT:String = "back_event";
		
		public static const NEXT_EVENT:String = "next_event";
		
		private var _name:String;
		private var _email:String;
		
		public function NameInforEvent(type:String, name:String="", email:String="")
		{
			super(type, false, false);
			
			_name = name;
			_email = email;
		}
		
		public override function clone():Event
		{
			return new NameInforEvent(type,name,email);
		}
		
		public override function toString():String
		{
			return formatToString("NameInforEvent");
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get email():String
		{
			return _email;
		}
	}
}