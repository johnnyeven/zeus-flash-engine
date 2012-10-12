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
		
		
		public function ChatItemVO()
		{
		
		}
	}
}