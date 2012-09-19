package enum.command
{
    import proxy.login.LoginProxy;

    public class CommandEnum
    {
        /**
         *获取服务器地址
         */
        public static var get_server_list:String = "";

		/**
		 *快速登陆
		 */
		public static function get startLogin():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip + "/demo";
		}
		
		/**
		 *登陆
		 */
		public static function get login():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip + "/login";
		}

		/**
		 *注册
		 */
		public static function get regist():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip + "/register";
		}
    }
}
