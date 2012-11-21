package enum.command
{
	import proxy.login.LoginProxy;

	public class CommandEnum
	{
		/**
		 *获取服务器地址
		 */
		public static var get_server_list:String="";
		
		/**
		 *向服务器发送步骤记录  
		 */		
		public static var recordURL:String="";
		
		/**
		 *快速登陆
		 */
		public static function get startLogin():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/web_demo";
		}

		/**
		 *登陆
		 */
		public static function get login():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/web_login";
		}
		
		/**
		 *查询账号是否重复
		 */
		public static function get web_check_account():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/web_check_account";
		}

		/**
		 *注册
		 */
		public static function get regist():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/web_register";
		}

		/**
		 *总览和荣誉
		 */
		public static function get allView():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/get_base_info";
		}

		/**
		 *行星要塞
		 */
		public static function get xingXing():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/get_my_forts_info";
		}

		/**
		 *请求新手任务
		 * @return
		 *
		 */
		public static function get getFreshmanTask():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/get_quest_reward";
		}
		
		/**
		 *游戏内注册修改用户信息
		 * @return
		 *
		 */
		public static function get web_update():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/web_update";
		}

		public static function get getCheat():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/cheat";
		}

		/**
		 *查询奖励
		 * @return
		 *
		 */
		public static function get getRewardInfo():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/reward_check";
		}
		
		/**
		 *领取奖励
		 * @return
		 *
		 */
		public static function get getReceiveReward():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/reward_receive";
		}
		
		/**
		 *在线礼包奖品查询
		 * @return
		 *
		 */
		public static function get getOnlineRewardInfo():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/reward_list";
		}
		
		/**
		 *获取常量信息
		 * @return
		 *
		 */
		public static function get getContentInfo():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/update_const";
		}

		/**
		 *物品捐献军团
		 * @return
		 *
		 */
		public static function get groupDonate():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/donate_dark_matter";
		}

		/**
		 *图纸学习 道具使用
		 * @return
		 *
		 */
		public static function get useItem():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/use_item";
		}

		/**
		 *销毁道具
		 * @return
		 *
		 */
		public static function get destroyItem():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/destroy_item";
		}

		/**
		 *购买仓库空间
		 * @return
		 *
		 */
		public static function get addSpace():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/increase_package";
		}


		/**
		 *获取背包信息
		 * @return
		 *
		 */
		public static function get getPackageInfo():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/get_package_info";
		}

		/**
		 *获取战车信息
		 * @return
		 *
		 */
		public static function get getChariotInfo():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/chariot_query";
		}

		/**
		 *获取挂件信息
		 * @return
		 *
		 */
		public static function get getTankPartInfo():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/tank_part_query";
		}

		/**
		 *建造建筑
		 * @return
		 *
		 */
		public static function get buildBuild():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/create_building";
		}

		/**
		 *升级建筑
		 * @return
		 *
		 */
		public static function get upBuild():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/upgrade_building";
		}

		/**
		 *加快升级建筑
		 * @return
		 *
		 */
		public static function get speedUpBuild():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/upgrade_building_speed_up";
		}
		
		/**
		 *请求时间机器
		 * @return
		 *
		 */
		public static function get create_time_machine():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/create_time_machine";
		}

		/**
		 *更新json
		 * @return
		 *
		 */
		public static function get updateInfo():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/get_base_info";
		}

		/**
		 *时间机器信息
		 * @return
		 *
		 */
		public static function get timeMachine():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/get_base_info";
		}

		/**
		 *熔炼功能
		 * @return
		 *
		 */
		public static function get smelte():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/refine_dark_matter";
		}

		/**
		 *全部加速
		 * @return
		 *
		 */
		public static function get allSpeed():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/speed_up_all";
		}

		/**
		 *科研信息
		 * @return
		 *
		 */
		public static function get scienceResearchInfor():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/get_base_info";
		}

		/**
		 *研究（升级）
		 * @return
		 *
		 */
		public static function get researchUp():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/research";
		}

		/**
		 *研究（加速升级）
		 * @return
		 *
		 */
		public static function get speedResearchUp():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/research_speed_up";
		}

		/**
		 *研究返回（验证）
		 * @return
		 *
		 */
		public static function get researchReturn():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/research_complete";
		}

		/**
		 *购买资源
		 * @return
		 *
		 */
		public static function get buyResources():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/buy_resource";
		}

		/**
		 *购买暗能水晶
		 * @return
		 *
		 */
		public static function get buyCrystal():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/web_buy_dark_crystal";
		}

		/**
		 *购买图纸
		 * @return
		 *
		 */
		public static function get buyItem():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/buy_item";
		}

		/*********************************************************************************
		 * 排名
		 **********************************************************************************/

		/**排名初始化
		 * @return
		 *
		 */
		public static function get rank_info():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/rank_info";
		}

		/**排名声望接口（日榜）
		 * @return
		 *
		 */
		public static function get dayListReputation():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/prestige_daily_rank";
		}

		/**排名声望接口（总榜）
		 * @return
		 *
		 */
		public static function get listReputation():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/prestige_total_rank";
		}

		/**排名财富接口（日榜）
		 * @return
		 *
		 */
		public static function get dayListWealth():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/orders_daily_rank";
		}

		/**排名财富接口（总榜）
		 * @return
		 *
		 */
		public static function get listWealth():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/orders_total_rank";
		}

		/**排名要塞接口（日榜）
		 * @return
		 *
		 */
		public static function get dayListFortress():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/forts_daily_rank";
		}

		/**排名要塞接口（总榜）
		 * @return
		 *
		 */
		public static function get listFortress():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/forts_total_rank";
		}

		/**排名军团声望接口（日榜）
		 * @return
		 *
		 */
		public static function get dayListPrestige():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/legion_prestige_daily_rank";
		}

		/**排名军团声望接口（总榜）
		 * @return
		 *
		 */
		public static function get listPrestige():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/legion_prestige_total_rank";
		}

		/*********************************************************************************
		 * 小行星
		 **********************************************************************************/

		/**
		 *获取小行星带
		 * @return
		 *
		 */
		public static function get getPlantioidList():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/get_world_map_info";
		}

		/**
		 *获取单个要塞信息
		 * @return
		 *
		 */
		public static function get getPlantioidInfo():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/get_fort_info";
		}

		/**
		 *修建要塞建筑
		 * @return
		 *
		 */
		public static function get buildPaoTa():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/create_fort_building";
		}

		/**
		 *摧毁要塞建筑
		 * @return
		 *
		 */
		public static function get destroyPaoTa():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/destroy_fort_building";
		}
		
		/**
		 *强制攻打小行星
		 * @return
		 *
		 */
		public static function get break_into_fort():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/break_into_fort";
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
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/create_legion";
		}

		/**
		 *搜索军团
		 * @return
		 *
		 */
		public static function get searchGroup():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/search_legion";
		}

		/**
		 *退出军团
		 * @return
		 *
		 */
		public static function get quitGroup():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/quit_legion";
		}

		/**
		 *军团成员列表
		 * @return
		 *
		 */
		public static function get groupMemberList():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/legion_member_list";
		}

		/**
		 *查询玩家所在军团
		 * @return
		 *
		 */
		public static function get refreshGroup():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/refresh_legion";
		}

		/**
		 *军团成员管理
		 * @return
		 *
		 */
		public static function get legion_member_manage():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/legion_member_manage";
		}

		/**
		 *军团管理
		 * @return
		 *
		 */
		public static function get legion_manage():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/legion_manage";
		}

		/**
		 *拒绝加入军团
		 * @return
		 *
		 */
		public static function get refresJoinGroup():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/refuse_to_join_legion";
		}

		/**
		 *允许加入军团
		 * @return
		 *
		 */
		public static function get allowJoinGroup():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/allow_to_join_legion";
		}

		/**
		 *获取申请军团列表
		 * @return
		 *
		 */
		public static function get groupApplyList():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/legion_apply_list";
		}

		/**
		 *申请加入军团
		 * @return
		 *
		 */
		public static function get applyjoinGroup():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/apply_for_legion";
		}
		
		/**
		 *获取军团地图
		 * @return
		 *
		 */
		public static function get get_star_map():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/get_star_map";
		}
		
		/**
		 *星球移动 首先调用的接口
		 * @return
		 *
		 */
		public static function get move_to_star():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/move_to_star";
		}
		
		/**
		 *获取战斗过程
		 * @return
		 *
		 */
		public static function get get_battle_result():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/get_battle_result";
		}

		/**
		 *制造战舰
		 * @return
		 *
		 */
		public static function get produce_warship():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/produce_warship";
		}

		/**
		 *制造战舰完成
		 * @return
		 *
		 */
		public static function get update_produce_warship():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/update_produce_warship";
		}

		/**
		 *领取战舰
		 * @return
		 *
		 */
		public static function get get_warship():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/get_warship";
		}

		/**
		 *拒绝所有请求
		 * @return
		 *
		 */
		public static function get refuse_all():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/refuse_all";
		}

		/**
		 *接受所有请求
		 * @return
		 *
		 */
		public static function get allow_all():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/allow_all";
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
		public static const chat_get_history:int=1;

		/**
		 *聊天
		 */
		public static const chat_talking:int=2;

		/**
		 *登出
		 */
		public static const chat_logoff:int=3;

		/**
		 *获取在线人数
		 */
		public static const chat_get_online_player_number:int=4;

		/**
		 *系统广播
		 */
		public static const chat_system_boardCast:int=5;

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


		/**
		 *好友列表
		 * @return
		 *
		 */
		public static function get friendList():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/friends_list";
		}

		/**
		 *搜寻玩家
		 * @return
		 *
		 */
		public static function get searchPlayer():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/players/search";
		}

		/**
		 *删除好友
		 * @return
		 *
		 */
		public static function get deletedFriend():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/remove_friend";
		}

		/**
		 *添加好友
		 * @return
		 *
		 */
		public static function get addFriend():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/make_friends";
		}

		/**
		 *查看玩家军官证
		 * @return
		 *
		 */
		public static function get viewPlayerIDCard():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/overall_info";
		}

		/*********************************************************************************
		 * 邮件
		 **********************************************************************************/
		/**
		 *获取邮件列表
		 * @return
		 *
		 */
		public static function get emailList():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/receive_mails";
		}

		/**
		 *发送邮件
		 * @return
		 *
		 */
		public static function get sendEmail():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/send_personal_mail";
		}

		/**
		 *标记已读邮件
		 * @return
		 *
		 */
		public static function get isRead():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/mark_as_read";
		}

		/**
		 *删除邮件
		 * @return
		 *
		 */
		public static function get deleteEmail():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/delete_mails";
		}

		/**
		 *收取邮件附件
		 * @return
		 *
		 */
		public static function get receiveEmailSource():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/receive_attachment";
		}

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
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/tanks_info";
		}

		/**
		 *gamerServer登陆
		 */
		public static const GAME2CLIENT_LOGIN:int=0;

		/**
		 *登陆gameServer返回
		 */
		public static var GAME2CLIENT_LOGIN_RESULT:int=1;

		/**
		 *请求战场房间
		 */
		public static const GAME2CLIENT_REQUEST_ROOM:int=2;

		/**
		 *请求战场房间返回
		 */
		public static var GAME2CLIENT_REQUEST_ROOM_RESULT:int=3;

		/**
		 *登陆房间
		 */
		public static const ROOM2CLIENT_LOGIN:int=0;

		/**
		 *撤退
		 */
		public static const ROOM2CLIENT_SURRENDER:int=7;

		/**
		 *登陆房间返回
		 */
		public static var ROOM2CLIENT_LOGIN_RESULT:int=1000;

		/**
		 *攻击者对象移动
		 */
		public static const ROOM2CLIENT_MOVING:int=2;

		/**
		 *可移动对象移动历史
		 */
		public static var ROOM2CLIENT_MOVING_HISTORY:int=1004;

		/**
		 * 开火
		 */
		public static const ROOM2CLIENT_FIRE:int=3;

		/**
		 *自定义消息
		 */
		public static const ROOM2CLIENT_BOARDCAST_MESSAGE:int=11;

		/**
		 *爆炸伤害
		 */
		public static const ROOM2CLIENT_ATTACKED:int=4;

		/**
		 *捡到物品
		 */
		public static const ROOM2CLIENT_REQUEST_BUFFER:int=13;

		/**
		 *捡到物品 返回
		 */
		public static const ROOM2CLIENT_REQUEST_BUFFER_RESULT:int=1015;

		/**
		 *生成小飞机
		 */
		public static const ROOM2CLIENT_NPC_CHARIOT_ENTER:int=1017;
		/**
		 *获取控制权
		 */
		public static const ROOM2CLIENT_REQUEST_CONTROL:int=8;
		/**
		 *请求控制结果
		 */
		public static const ROOM2CLIENT_REQUEST_CONTROL_RESULT:int=1005;
		/**
		 *释放控制权
		 */
		public static const ROOM2CLIENT_RELEASE_CONTROL:int=9;
		
		/**
		 *广播消息（开始投票）
		 */
		public static const  ROOM2CLIENT_VOTE_STARTUP:int=1008;
		
		/**
		 *投票操作调用接口
		 */
		public static const  ROOM2CLIENT_VOTE:int=10;
		
		/**
		 *投票操作调用接口返回（结束投票）
		 */
		public static const  ROOM2CLIENT_VOTE_RESULT:int=1009;

		/**
		 *广播受到伤害对象当前
		 */
		public static const ROOM2CLIENT_BOARDCAST_STATUS:int=1001;

		/**
		 *更新对象属性 改基地耐久为5%，攻击去掉
		 */
		public static const ROOM2CLIENT_UPDATE_OBJECT:int=1019;

		/**
		 *击毁建筑（炮台）获得荣誉
		 */
		public static const ROOM2CLIENT_OBTAIN_HONOR:int=1018;

		/**
		 *新玩家进入房间
		 */		
		public static const ROOM2CLIENT_PLAYER_ENTER:int=1007;
		
		/**
		 *游戏结束 
		 */		
		public static const ROOM2CLIENT_FINISH:int=1002;
		
		/**
		 *游戏超时结束 
		 */		
		public static const ROOM2CLIENT_FINISH_TIMEOUT:int=1003;
		
		/**
		 *断开连接，赢了才会有战斗结果 
		 */		
		public static const ROOM2CLIENT_SHUTDOWN:int=1010;
		
		/**
		 *复活 
		 */		
		public static const ROOM2CLIENT_OBJECT_REQUEST_RELIVE:int=12;
		
		
		/**
		 *物品掉落 
		 */		
		public static const ROOM2CLIENT_BUFFER_GENERATED:int=1014;
		/*********************************************************************************
		 * 军工厂
		 **********************************************************************************/

		/**
		 *请求已学会图纸列表
		 * @return
		 */
		public static function get makeFactoryList():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/recipe_list";
		}

		/**
		 *开始制造
		 * @return
		 *
		 */
		public static function get makeStar():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/produce";
		}

		/**
		 *维修功能
		 * @return
		 *
		 */
		public static function get repair():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/repair";
		}

		/**
		 *回收功能
		 * @return
		 *
		 */
		public static function get recycle():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/recycle";
		}

		/**
		 *强化功能
		 * @return
		 *
		 */
		public static function get enhance_chariot():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/enhance_chariot";
		}

		/**
		 *挂载挂件
		 * @return
		 */
		public static function get mount():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/mount";
		}

		/**
		 *卸载单个挂件
		 * @return
		 */
		public static function get unmount():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/unmount";
		}

		/**
		 *卸载全部挂件
		 * @return
		 */
		public static function get unmount_all():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/unmount_all";
		}

		/**
		 *加速制造
		 * @return
		 */
		public static function get produce_speed_up():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/produce_speed_up";
		}

		/**
		 *制造完成刷新
		 * @return
		 */
		public static function get update_produce():String
		{
			return "http://" + LoginProxy.selectedServerVO.server_ip + "/update_produce";
		}

	}
}
