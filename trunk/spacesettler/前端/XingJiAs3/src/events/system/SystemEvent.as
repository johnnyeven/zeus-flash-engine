package events.system
{
	import flash.events.Event;
	
	public class SystemEvent extends Event
	{
		/**
		 *关闭系统菜单 
		 */		
		public static const CLOSE_ALL:String="close_all";
		
		/**
		 *单独的关闭 
		 */		
		public static const CLOSE:String="close";
		
		/**
		 *显示帮助菜单 
		 */		
		public static const SHOW_HELPBOUNDARY:String="show_helpboundary";
		
		/**
		 *显示选项菜单 
		 */		
		public static const SHOW_OPTIONBOUNDARY:String="show_optionboundary";
		
		/**
		 *显示我的账户 
		 */		
		public static const SHOW_ACCOUNTNUMBERBOUNDARY:String="show_accountnumberboundary";
		
		/**
		 *登出
		 */		
		public static const LOGIN_OUT:String="login_out";
		
		
		public function SystemEvent(type:String)
		{
			super(type, false, false);
		}
	}
}