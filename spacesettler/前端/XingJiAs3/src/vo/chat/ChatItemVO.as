package vo.chat
{
	import ui.vo.ValueObject;
	
	/**
	 * 聊天信息
	 * @author lw
	 * 
	 */	
	[Bindable]
	public class ChatItemVO extends ValueObject
	{
		/**
		 *玩家ID
		 */	
		public var playerID:String = "";
		
		/**
		 *玩家名字
		 */	
		public var playerName:String = "";
		
		/**
		 *玩家VIP
		 */	
		public var vipLv:int;
		
		/**
		 *军团ID 
		 */		
		public var legion_id:String;
		
		/**
		 *聊天频道
		 */		
		public var channel:int;
		
		/**
		 *时间戳
		 */		
		public var timeStamp:Number;
		
		/**
		 *内容信息content
		 */		
		public var str:String = "";
		
		/**
		 *系统
		 */		
		public var system:String = "";
		
		/**
		 *类型
		 */		
		public var type:int;
		
		/**
		 *内容信息长度
		 */		
		public var strLength:uint;
		
		/**
		 *阵营
		 */		
		public var campID:uint;
		
		/**
		 *世界在线人数
		 */		
		public var wordOnLineNumber:int;
		
		/**
		 *军团在线人数
		 */
		public var groupOnLineNumber:int;
		
		public function ChatItemVO()
		{
		
		}
	}
}