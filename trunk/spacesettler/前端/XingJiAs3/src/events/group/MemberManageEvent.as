package events.group
{
	import flash.events.Event;
	
	public class MemberManageEvent extends Event
	{
		public static const SURE_EVENT:String="sure_event";
		
		/**
		 *成员职务等级 1=军团长（表示转让军团）2=副团长3=执政官4=高级指挥官5=指挥官6=普通成员 
		 */		
		public var _member_level:int
		
		/**
		 * 最大可携带的战舰数
		 */		
		public var _member_warship_capacity:int
		
		/**
		 *是否剔除成員 0为否 1为是 默认为否 为0 
		 */		
		public var _kick_member:int
		
		/**
		 *成员ID 
		 */		
		public var _member_id:String
		
		public function MemberManageEvent(member_id:String,member_level:int,member_warship_capacity:int,kick_member:int=0)
		{
			super(SURE_EVENT, false, false);
			_member_level=member_level;
			_member_warship_capacity=member_warship_capacity;
			_kick_member=kick_member;
			_member_id=member_id;
				
		}
	}
}