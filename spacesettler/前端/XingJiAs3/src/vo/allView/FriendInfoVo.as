package vo.allView
{
	import ui.vo.ValueObject;
	
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
		
		
		
		
		public function FriendInfoVo()
		{
			super();
		}
	}
}