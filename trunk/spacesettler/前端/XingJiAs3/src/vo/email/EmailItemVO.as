package vo.email
{
	import ui.vo.ValueObject;
	
	public class EmailItemVO extends ValueObject
	{
		/**
		 *邮件数量 
		 */		
		public var mails_count:int;
		
		/**
		 *邮件ID
		 */
		public var id:String = "";
		
		/**
		 *何时发送的邮件
		 */
		public var created_at:Number;
		
		/**
		 *邮件类型     1=系统    2=军团    3=个人
		 */
		public var type:int;
		
		/**
		 *发送者昵称
		 */
		public var sender:String = "";
		
		/**
		 *接收者昵称
		 */
		public var receiver:String = "";
		
		/**
		 *标题
		 */
		public var title:String = "";
		
		/**
		 *内容
		 */
		public var content:String = "";
		
		/**
		 *是否已读
		 */
		public var is_read:Boolean;
		
		/**
		 *是否有附件
		 */
		public var attachment:Boolean;
		
		/**
		 *附件类型         TankPart=挂件     Chariot=战车      Crystal=水晶    Tritium=氢氚     BrokenCrystal=暗物质
		 */
		public var attachment_type:String = "";
		
		/**
		 *分类
		 */
		public var category:int;
		
		/**
		 *如果是道具       返回值必带这个参数，道具ID
		 */
		public var attachment_id:String;
		
		/**
		 *如果是资源    返回值必带这个参数，数量
		 */
		public var attachment_count:int;
		
		/**
		 *是否已获取附件
		 */
		public var receive_attachment:Boolean;
		
		
		public function EmailItemVO()
		{

		}
	}
}