package vo.allView
{
	import ui.vo.ValueObject;
	
	import vo.group.GroupListVo;
	
	/**
	 * 好友和敌人列表数据
	 * @author lw
	 * 
	 */	
	public class FriendInfoVo extends ValueObject
	{
		/**
		 *从上元件或下元件发送的消息
		 */
		public var componentInforType:String = "";
		/**
		 *好友标记
		 */
		public var isMyFriend:Boolean = false;
		/**
		 *敌人标记
		 */
		public var isMyEnemy:Boolean = false;
		/**
		 *好友ID 
		 */		
		public var id:String;
		
		/**
		 *好友昵称 
		 */		
		public var nickname:String;
		
		/**
		 *好友军官证 
		 */		
		public var officer_id:String;
		
		/**
		 *好友的VIP等级 
		 */		
		public var vip_level:int=0;
		
		/**
		 *VIP开始时间
		 */		
		public var vip_start_at:String;
		/**
		 *VIP过期时间
		 */		
		public var vip_expired_at:String;
		
		/**
		 *科技时代
		 */		
		public var age_level:int=0;
		
		/**
		 *上次登录时间（时间戳）
		 */		
		public var last_login_time:Number;
		
		/**
		 *攻击时间（时间戳）
		 */		
		public var attack_time:Number;
		
		/**
		 *攻击的小行星ID
		 */		
		public var attack_fort_id:String;
		
		/**
		 *被攻击小行星左边X
		 */		
		public var x:int;
		
		/**
		 *被攻击小行星左边Y
		 */		
		public var y:int;
		
		/**
		 *被攻击小行星左边Z
		 */		
		public var z:int;
		
		/**
		 *是否被占领
         * 0=否 1=是
		 */		
		public var is_captured:Boolean;
		
		/**
		 *
		 */		
		public var shopping_discount:int;
		
		/**
		 *
		 */		
		public var daily_orders:int;
		
		/**
		 *
		 */		
		public var occupy_forts_total_record:int;
		
		/**
		 *
		 */		
		public var prestige:int;
		
		/**
		 *
		 */		
		public var collecting_factory_count:int;
		
		/**
		 *
		 */		
		public var dark_crystal:int;
		
		/**
		 *
		 */		
		public var package_size:int;
		
		/**
		 *
		 */		
		public var email:int;
		
		/**
		 *
		 */		
		public var camp_id:int;
		
		/**
		 *
		 */		
		public var my_invite_code:int;
		
		/**
		 *
		 */		
		public var player_type:int;
		
		/**
		 *
		 */		
		public var occupy_forts_daily_record:int;
		
		/**
		 *
		 */		
		public var total_orders:int;
		
		/**
		 *军衔
		 */		
		public var military_rank:int;
		
		/**
		 *
		 */		
		public var package_use:int;
		
		/**
		 *
		 */		
		public var current_time:int;
		
		/**
		 *
		 */		
		public var fort_count:int;
		
		/**
		 *科技等级
		 */		
		public var academy_level:int;
		
		/**
		 *
		 */		
		public var new_mail:int;
		
		/**
		 *
		 */		
		public var legion_relation_id:int;
		
		/**
		 *
		 */		
		public var legion_id:int;
		
		/**
		 *
		 */		
		public var count_login_days:int;
		
		/**
		 *军团ID
		 */		
		public var groupID:String;
		
		/**
		 *
		 */		
		public var broken_crystal:int;
		
		/**
		 *军团名字
		 */		
		public var groupName:String;
		
		/**
		 *
		 */		
		public var desc:int;
		
		/**
		 *
		 */		
		public var warship:int;
		
		/**
		 *
		 */		
		public var president:int;
		
		/**
		 *
		 */		
		public var members_count:int;
		
		/**
		 *玩家总的声望
		 */		
		public var total_prestige:int;
		
		/**
		 *玩家总的声望排名
		 */		
		public var total_prestige_rank:int;
		
		/**
		 *玩家每日声望
		 */		
		public var daily_prestige:int;
		
		/**
		 *玩家每日声望排名
		 */		
		public var daily_prestige_rank:int;
		
		/**
		 *玩家军团信息
		 */		
		public var groupListVO:GroupListVo = new GroupListVo();
		
		public function FriendInfoVo()
		{
		}
		
		/**
		 * 根据科技时代等级获取   科技时代的名称
		 */
		public function getKeJiShiDaiNameByKeJiShiDaiLevel(keJiShiDaiTxt:int):String
		{
			var name:String = "";
			switch(keJiShiDaiTxt)
			{
				case 1:
				{
					name = "机械时代";
					break;
				}
				case 2:
				{
					name = "激光时代";
					break;
				}
				case 3:
				{
					name = "电磁时代";
					break;
				}
				case 4:
				{
					name = "暗能时代";
					break;
				}
			}
			return name;
		}
	}
}