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
		 * 军衔级别
		 */	
		public var junXianLvTxt:int;
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
		
		public function AllViewVO()
		{
		}
	}
}