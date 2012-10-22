package vo.allView
{
	import ui.vo.ValueObject;
	
	/**
	 * 好友和敌人列表数据
	 * @author lw
	 * 
	 */	
	public class FriendInfoVo extends ValueObject
	{
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
		
		
		public function FriendInfoVo()
		{
			super();
		}
	}
}