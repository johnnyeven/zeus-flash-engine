package vo.allView
{
	import ui.vo.ValueObject;
	
	[Bindable]
	public class ShopInfoVo extends ValueObject
	{	
		/**
		 *道具类型有type的为图纸图标无type的为道具图标
		 */		
		public var type:String;
		
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
		public var time:int=-1;
		
		/**
		 *道具id  2:21:1:6
		 */		
		public var recipe_id:String;
		
		
		public var key:String;
		public var index:String;
		
		
		
		public function ShopInfoVo()
		{
			super();
		}
	}
}