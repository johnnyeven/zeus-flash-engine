package vo.group
{
	import ui.vo.ValueObject;
	
	/**
	 *成员信息 
	 * @author Administrator
	 * 
	 */	
	[Bindable]
	public class GroupMemberListVo extends ValueObject
	{
		/**
		 *用户ID 
		 */		
		public var player_id:String;
		
		/**
		 *成员名称 
		 */		
		public var username:String;
		
		/**
		 *VIP等级 
		 */		
		public var vipLevel:int;
		
		/**
		 *职务等级 
		 */		
		public var level:int;
		
		/**
		 *排名   声望等级
		 */		
		public var rank:int;
		
		/**
		 *可控制战舰数量 
		 */		
		public var controlledNum:int;
		
		/**
		 *捐赠的暗物质数量 
		 */		
		public var donate_dark_matter:int;
		
		private var _job:String;
		public function GroupMemberListVo()
		{
			super();
		}

		/**
		 *职务   根据大小来判断其职务
		 */
		public function get job():String
		{
			if(level==1)
			{
				_job="军团长"
			}else if(level==2)
			{
				_job="副团长"
			}else if(level==3)
			{
				_job="执政官"
			}else if(level==4)
			{
				_job="高级指挥官"
			}else if(level==5)
			{
				_job="指挥官"
			}else if(level==6)
			{
				_job="普通成员"
			}
			return _job;
		}

		/**
		 * @private
		 */
		public function set job(value:String):void
		{
			_job = value;
		}

	}
}