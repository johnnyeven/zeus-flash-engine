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
		 *玩家自己ID
		 */	
		public var myID:String = "";
		
		/**
		 *玩家自己名字
		 */	
		public var myName:String = "";
		
		/**
		 *玩家VIP
		 */	
		public var myVIP:int;
		
		/**
		 *其他玩家ID
		 */	
		public var otherID:String = "";
		
		/**
		 *其他玩家名字
		 */	
		public var otherName:String = "";
		
		/**
		 *其他玩家VIP
		 */	
		public var otherVIP:int;
		
		/**
		 *军团ID 
		 */		
		public var legion_id:String;
		
		/**
		 *聊天频道
		 */		
		public var channel:String;
		/**
		 *当前自己设置的通道
		 */		
		public var mySetChannel:String;
		
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
		 *类型  0为一般系统公告   1为副本系统公告
		 */		
		public var type:String;
		
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