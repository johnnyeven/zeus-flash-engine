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
			return "http://"+LoginProxy.selectedServerVO.server_ip + "/web_login";
		}

		/**
		 *注册
		 */
		public static function get regist():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip + "/register";
		}
		
		/**
		 *总览
		 */
		public static function get allView():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip + "/get_base_info";
		}
		
		/**
		 *请求新手任务
		 * @return 
		 * 
		 */
		public static function get getFreshmanTask():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/get_quest_reward";
		}
		
		/**
		 *获取常量信息 
		 * @return 
		 * 
		 */
		public static function get getContentInfo():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/update_const";
		}
		
		/**
		 *建造建筑
		 * @return 
		 * 
		 */
		public static function get buildBuild():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/create_building";
		}
		
		/**
		 *升级建筑
		 * @return 
		 * 
		 */
		public static function get upBuild():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/upgrade_building";
		}
		
		/**
		 *加快升级建筑
		 * @return 
		 * 
		 */
		public static function get speedUpBuild():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/upgrade_building_speed_up";
		}
    }
}
