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
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/get_quest_reward";
		}
		
		public static function get getCheat():String
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
		 *物品捐献军团
		 * @return 
		 * 
		 */
		public static function get groupDonate():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/donate_dark_matter";
		}
		
		/**
		 *图纸学习 道具使用
		 * @return 
		 * 
		 */
		public static function get useItem():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/use_item";
		}
		
		/**
		 *销毁道具
		 * @return 
		 * 
		 */
		public static function get destroyItem():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/destroy_item";
		}
		
		/**
		 *购买仓库空间
		 * @return 
		 * 
		 */
		public static function get addSpace():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/increase_package";
		}
		
		
		/**
		 *获取背包信息 
		 * @return 
		 * 
		 */
		public static function get getPackageInfo():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/get_package_info";
		}
		
		/**
		 *获取战车信息 
		 * @return 
		 * 
		 */
		public static function get getChariotInfo():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/chariot_query";
		}
		
		/**
		 *获取挂件信息 
		 * @return 
		 * 
		 */
		public static function get getTankPartInfo():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/tank_part_query";
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
		 *熔炼功能
		 * @return 
		 * 
		 */
		public static function get smelte():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/refine_dark_matter";
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
		 *科研信息
		 * @return 
		 * 
		 */
		public static function get scienceResearchInfor():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/get_base_info";
		}
		
		/**
		 *研究（升级）
		 * @return 
		 * 
		 */
		public static function get researchUp():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/research";
		}
		
		/**
		 *研究返回（验证）
		 * @return 
		 * 
		 */
		public static function get researchReturn():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/research_complete";
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
		
		/*********************************************************************************
		 * 排名
		 **********************************************************************************/
		
		/**排名声望接口（日榜）
		 * @return 
		 * 
		 */
		public static function get dayListReputation():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/prestige_daily_rank";
		}
		
		/**排名声望接口（总榜）
		 * @return 
		 * 
		 */
		public static function get listReputation():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/prestige_total_rank";
		}
		
		/**排名财富接口（日榜）
		 * @return 
		 * 
		 */
		public static function get dayListWealth():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/orders_daily_rank";
		}
		
		/**排名财富接口（总榜）
		 * @return 
		 * 
		 */
		public static function get listWealth():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/orders_total_rank";
		}
		
		/**排名要塞接口（日榜）
		 * @return 
		 * 
		 */
		public static function get dayListFortress():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/forts_daily_rank";
		}
		
		/**排名要塞接口（总榜）
		 * @return 
		 * 
		 */
		public static function get listFortress():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/forts_total_rank";
		}
		
		/**排名军团声望接口（日榜）
		 * @return 
		 * 
		 */
		public static function get dayListPrestige():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/legion_prestige_daily_rank";
		}
		
		/**排名军团声望接口（总榜）
		 * @return 
		 * 
		 */
		public static function get listPrestige():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/legion_prestige_total_rank";
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
		
		/*********************************************************************************
		 * 军团
		 **********************************************************************************/
		
		/**
		 *创建军团
		 * @return 
		 * 
		 */
		public static function get createGroup():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/create_legion";
		}
		
		/**
		 *解散军团
		 * @return 
		 * 
		 */
		public static function get dismissGroup():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/dismiss_legion";
		}
		
		/**
		 *搜索军团
		 * @return 
		 * 
		 */
		public static function get searchGroup():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/search_legion";
		}
		
		/**
		 *退出军团
		 * @return 
		 * 
		 */
		public static function get quitGroup():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/quit_legion";
		}
		
		/**
		 *军团成员列表
		 * @return 
		 * 
		 */
		public static function get groupMemberList():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/legion_member_list";
		}
		
		/**
		 *查询玩家所在军团
		 * @return 
		 * 
		 */
		public static function get refreshGroup():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/refresh_legion";
		}
		
		/**
		 *拒绝加入军团
		 * @return 
		 * 
		 */
		public static function get refresJoinGroup():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/refuse_to_join_legion";
		}
		
		/**
		 *允许加入军团
		 * @return 
		 * 
		 */
		public static function get allowJoinGroup():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/allow_to_join_legion";
		}
		
		/**
		 *获取申请军团列表
		 * @return 
		 * 
		 */
		public static function get groupApplyList():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/legion_apply_list";
		}
				
		/**
		 *申请加入军团
		 * @return 
		 * 
		 */
		public static function get applyjoinGroup():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/apply_for_legion";
		}
		
		
		/*********************************************************************************
		 * 聊天
		 **********************************************************************************/
		
		/**
		 *聊天登陆 
		 */		
		public static const chat_login:int=0;
		
		/**
		 *获取历史记录
		 */	
		public static const chat_get_history:int = 1;
		
		/**
		 *聊天
		 */	
		public static const chat_talking:int = 2;
		
		/**
		 *登出
		 */	
		public static const chat_logoff:int = 3;
		
		/**
		 *获取在线人数
		 */	
		public static const chat_get_online_player_number:int = 4;
		
		/**
		 *系统广播
		 */	
		public static const chat_system_boardCast:int = 5;
		
		/**
		 *聊天登陆返回 
		 */		
		public static const chat_login_result:int=1000;
		
		/**
		 *客户端未登陆
		 */		
		public static const chat_not_login:int=1001;
		
		/**
		 *获取在线人数结果
		 */		
		public static const chat_get_online_player_number_result:int=1002;

		/*********************************************************************************
		 * 战场
		 **********************************************************************************/
		/**
		 *获取玩家所有战车信息
		 * @return 
		 * 
		 */
		public static function get getAllZhanCheList():String
		{
			return "http://"+LoginProxy.selectedServerVO.server_ip+"/tanks_info";
		}
		
		/**
		 *gamerServer登陆
		 */
		public static const GAME2CLIENT_LOGIN:int = 0;
		
		/**
		 *登陆gameServer返回 
		 */		
		public static var GAME2CLIENT_LOGIN_RESULT:int=1;
		
		/**
		 *请求战场房间
		 */
		public static const GAME2CLIENT_REQUEST_ROOM:int =2;
		
		/**
		 *请求战场房间返回 
		 */		
		public static var GAME2CLIENT_REQUEST_ROOM_RESULT:int=3;
		
		/**
		 *登陆房间
		 */
		public static const ROOM2CLIENT_LOGIN:int =0;
		
		/**
		 *登陆房间返回 
		 */		
		public static var ROOM2CLIENT_LOGIN_RESULT:int=1000;
    }
}
