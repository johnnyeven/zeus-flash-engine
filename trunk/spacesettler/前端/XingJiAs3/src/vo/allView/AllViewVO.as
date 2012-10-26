package vo.allView
{
	import ui.vo.ValueObject;

	/**
	 * 总览条目
	 * @author lw
	 * 
	 */	
	[Bindable]
	public class AllViewVO extends ValueObject
	{
		/**
		 * 玩家名称
		 */	
		public var playerNameTxt:String = "";
		/**
		 * 荣誉
		 */		
		public var rongYuTxt:int;
		/**
		 * 当前科技时代：
		 */	
		public var keJiShiDaiTxt:int;
		/**
		 * 军团：
		 */	
		public var junTuanTxt:String = "";
		/**
		 * 拥有小行星数：
		 */	
		public var startCountTxt:int;
		/**
		 * 军衔
		 */	
		public var junXianTxt:String = "";
		/**
		 * 科技中心等级
		 */	
		public var scienceLvTxt:int;
		/**
		 *金晶矿：
		 */	
		public var jinJingCountTxt:int;
		/**
		 * 氚气：
		 */	
		public var chuanQiCountTxt:int;
		/**
		 *暗物质：
		 */	
		public var anWuZhiCountTxt:int;
		/**
		 * 产量：
		 */	
		public var powerCountTxt:int;
		/**
		 * 消耗：
		 */	
		public var usePowerCountTxt:int;
		/**
		 * 勋章类型
		 */	
		public var medals_type:int;
		/**
		 * 勋章等级
		 */	
		public var medals_level:int;
		
		
		public function AllViewVO()
		{
		}
		
		/**
		 * 根据科技时代等级获取   科技时代的名称
		 */
		public function get getKeJiShiDaiNameByKeJiShiDaiLevel():String
		{
			var name:String = "";
			switch(keJiShiDaiTxt)
			{
				case 1:
				{
					name = "机械时代";
					break;
				}
				case 2:
				{
					name = "激光时代";
					break;
				}
				case 3:
				{
					name = "电磁时代";
					break;
				}
				case 4:
				{
					name = "暗能时代";
					break;
				}
			}
			return name;
		}
		
	}
}