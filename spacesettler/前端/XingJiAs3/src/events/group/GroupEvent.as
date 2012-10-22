package events.group
{
	import flash.events.Event;
	
	public class GroupEvent extends Event
	{
		/**
		 *创建军团 
		 */		
		public static const CREAT_GROUP:String="creat_group";			
		
		/**
		 *申请加入军团 
		 */		
		public static const APPLYJOIN_GROUP:String="applyjoin_Group";
		
		/**
		 *退出军团 
		 */		
		public static const QUITE_GROUP:String="quite_Group";
		
		private var _groupName:String;
		private var _id:String;

		public function GroupEvent(type:String,groupName:String=null,id:String=null)
		{
			super(type, false, false);
			_groupName=groupName;
			_id=id;
		}
		
		/**
		 *军团名 
		 * @return 
		 * 
		 */		
		public function get groupName():String
		{
			return _groupName;
		}
		
		public function set groupName(value:String):void
		{
			_groupName = value;
		}
		
		/**
		 *军团ID 
		 * @return 
		 * 
		 */		
		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}
	}
}