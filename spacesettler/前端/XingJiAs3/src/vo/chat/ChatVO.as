package vo.chat
{
	import ui.vo.ValueObject;
	
	[Bindable]
	public class ChatVO extends ValueObject
	{
		/**
		 * 聊天频道
		 */		
		public var channel:String;
		
		/**
		 * 世界频道数据列表
		 */		
		public var wordList:Array = [];
		/**
		 * 阵营频道数据列表
		 */		
		public var campList:Array = [];
		
		/**
		 * 军团频道数据列表
		 */		
		public var armyGroupList:Array = [];
		
		/**
		 * 私聊频道数据列表
		 */		
		public var privateList:Array = [];
		
		/**
		 * 其他频道数据列表
		 */		
		public var otherList:Array = [];
		
		public function ChatVO()
		{

		}
	}
}