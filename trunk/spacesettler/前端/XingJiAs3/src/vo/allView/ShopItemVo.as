package vo.allView
{
	import ui.vo.ValueObject;
	
	[Bindable]
	public class ShopItemVo extends ValueObject
	{
		/**
		 *道具标示vip_level_1 
		 * 有type的为图纸图标无type的为道具图标
		 */		
		public var key:String;
		
		/**
		 *道具名称
		 */		
		public var name:String;
		
		/**
		 *道具暗能水晶消耗
		 */		
		public var dark_crystal:int;
		
		/**
		 *道具介绍
		 */		
		public var description:String;
		
		/**
		 *道具持续时间
		 */		
		public var time:int;
		
		/**
		 *折扣
		 */		
		public var discount:Number;
		
		/**
		 *水晶增产量
		 */		
		public var crystal_inc:Number;
		
		/**
		 *暗物质增产量
		 */		
		public var broken_crystal_inc:Number;
		
		/**
		 *氚气增产量
		 */		
		public var tritium_inc:Number;
		/**
		 *道具id  2:21:1:6
		 */		
		public var recipe_id:String;
		
		public var index:String;
		
		
		public function ShopItemVo()
		{
			super();
		}
	}
}