package events.task
{
	import flash.events.Event;
	
	import vo.task.TaskInfoVO;
	
	public class TaskEvent extends Event
	{
		public static const CLOSE_EVENT:String="close_event";
		
		public var taskVo:TaskInfoVO;
		
		private var _username:String;
		private var _passWord:String;
		private var _nickName:String;
		private var _email:String;
		
		public function TaskEvent(type:String,taskVo:TaskInfoVO=null,username:String=null,passWord:String=null,nickName:String=null,email:String=null)
		{
			super(type, false, false);
			this.taskVo=taskVo;
			_username=username;
			_passWord=passWord;
			_nickName=nickName;
			_email=email;
		}

		public function get username():String
		{
			return _username;
		}

		public function set username(value:String):void
		{
			_username = value;
		}

		public function get passWord():String
		{
			return _passWord;
		}

		public function set passWord(value:String):void
		{
			_passWord = value;
		}

		public function get nickName():String
		{
			return _nickName;
		}

		public function set nickName(value:String):void
		{
			_nickName = value;
		}

		public function get email():String
		{
			return _email;
		}

		public function set email(value:String):void
		{
			_email = value;
		}


	}
}