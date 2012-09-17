package events.login
{
	import flash.events.Event;
	
	/**
	 *快速登陆
	 * @author lw
	 *
	 */
	
	public class StartLoginEvent extends Event
	{
		public static const START_LIGIN_EVENT:String = "start_login_event";
		
		public static const ACCOUNT_EVENT:String = "account_event";
		
		public static const REGIST_EVENT:String = "regist_event";
		
		public function StartLoginEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}