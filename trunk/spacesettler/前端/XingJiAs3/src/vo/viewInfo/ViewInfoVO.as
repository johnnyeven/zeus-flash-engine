package vo.viewInfo
{
	import ui.vo.ValueObject;

	[Bindable]
	public class ViewInfoVO extends ValueObject
	{
		/**
		 *建造升级时间 
		 */		
		public var time:int;
		/**
		 *水晶消耗 
		 */		
		public var shuiJinXH:int;
		/**
		 *水晶产量 
		 */		
		public var shuiJinCL:int;
		/**
		 *氚氢消耗 
		 */		
		public var chuanQinXH:int;
		/**
		 *氚氢产量 
		 */		
		public var chuanQinCL:int;
		/**
		 *暗物质消耗 
		 */		
		public var anWuZhiXH:int;
		/**
		 *暗物质产量
		 */		
		public var anWuZhiCL:int;
		/**
		 *电能消耗 
		 */		
		public var DianNengXH:int;
		/**
		 *电能提供 
		 */		
		public var DianNengTG:int;
		/**
		 *水晶容量
		 */		
		public var shuiJinRL:int;
		/**
		 *氚氢容量
		 */		
		public var chuanQinRL:int;
		/**
		 *暗物质容量
		 */		
		public var anWuZhiRL:int;
		/**
		 *暗能水晶容量
		 */		
		public var anNengShuiJinRL:int;
		/**
		 *基地中心升级限制
		 */		
		public var limit:int;
		/**
		 *科技中心及其他建筑升级限制
		 */		
		public var command_center_level:int;
		
		public var all_subjects_level:int;
		
		public function ViewInfoVO()
		{
			
		}
	}
}