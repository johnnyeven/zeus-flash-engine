package vo.groupFight
{
	import ui.vo.ValueObject;
	
	public class LossReportVo extends ValueObject
	{
		/**
		 *派遣数量 
		 */		
		public var send_warships:int;
		
		/**
		 *剩余数量
		 */		
		public var left_warships:int;
		
		
		/**
		 *损失数量
		 */		
		public var lost_warships:int;
		
		/**
		 *星球上剩余战舰数
		 */		
		public var total_warships:int;	
		
		
		/**
		 *敌人损失数量
		 */		
		public var lost_warships_1:int;
		
		/**
		 *敌人剩余数量
		 */		
		public var left_warships_1:int;
		
		/**
		 *敌人派遣数量
		 */		
		public var send_warships_1:int;
		
		public function LossReportVo()
		{
			super();
		}
	}
}