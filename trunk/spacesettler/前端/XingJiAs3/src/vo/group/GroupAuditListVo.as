package vo.group
{
	import ui.vo.ValueObject;
	
	/**
	 *军团审核Vo 
	 * @author Administrator
	 * 
	 */	
	[Bindable]
	public class GroupAuditListVo extends ValueObject
	{
		
		/**
		 *排名 
		 */		
		public var prestige_rank:int;
		
		/**
		 *VIP等级 
		 */		
		public var vip_level:int;
		
		/**
		 *人员名称 
		 */		
		public var nickname:String;
		
		/**
		 *玩家ID
		 */		
		public var player_id:String;
		
		/**
		 *军团ID
		 */		
		public var legion_id:String;
		
		/**
		 *申请ID
		 */		
		public var id:String;
		
		/**
		 *军衔
		 */		
		public var military_rank:String;
		
		public function GroupAuditListVo()
		{
			super();
		}
	}
}