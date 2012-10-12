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
		public var rank:int;
		
		/**
		 *VIP等级 
		 */		
		public var vipLevel:int;
		
		/**
		 *人员名称 
		 */		
		public var username:String;
		
		/**
		 *军衔
		 */		
		public var rank:String;
		
		public function GroupAuditListVo()
		{
			super();
		}
	}
}