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
			return "http://"+LoginProxy.selectedServerVO.server_ip + "/web_register";
		}
		
		/**
		 *总览和荣誉
		 */
		public static function get allView():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip + "/get_base_info";
		}
		
		/**
		 *行星要塞
		 */
		public static function get xingXing():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/get_my_forts_info";
		}
		
		/**
		 *请求新手任务
		 * @return 
		 * 
		 */
		public static function get getFreshmanTask():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/cheat";
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
		
		/**
		 *更新json
		 * @return 
		 * 
		 */
		public static function get updateInfo():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/get_base_info";
		}
		
		/**
		 *时间机器信息
		 * @return 
		 * 
		 */
		public static function get timeMachine():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/get_base_info";
		}
		
		
		/**
		 *全部加速
		 * @return 
		 * 
		 */
		public static function get allSpeed():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/speed_up_all";
		}
		
		
		/**
		 *购买资源
		 * @return 
		 * 
		 */
		public static function get buyResources():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/buy_resource";
		}
		
		/**
		 *购买暗能水晶
		 * @return 
		 * 
		 */
		public static function get buyCrystal():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/buy_dark_crystal";
		}
		
		/**
		 *购买图纸
		 * @return 
		 * 
		 */
		public static function get buyItem():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/buy_item";
		}
		
		/**
		 *获取小行星带
		 * @return 
		 * 
		 */
		public static function get getPlantioidList():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/get_world_map_info";
		}
    }
}
