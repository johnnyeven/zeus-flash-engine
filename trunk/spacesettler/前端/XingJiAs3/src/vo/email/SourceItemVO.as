package vo.email
{
	import ui.vo.ValueObject;
	
	public class SourceItemVO extends ValueObject
	{
		
		/**
		 *附件类型         TankPart=挂件     Chariot=战车      Crystal=水晶    Tritium=氢氚     BrokenCrystal=暗物质
		 */
		public var attachment_type:String = "";
		/**
		 *如果是道具       返回值必带这个参数，道具ID
		 */
		public var attachment_id:String;
		
		/**
		 *如果是资源    返回值必带这个参数，数量
		 */
		public var attachment_count:int;
		
		public var count:int = 1;
		
		public function SourceItemVO()
		{
		}
	}
}