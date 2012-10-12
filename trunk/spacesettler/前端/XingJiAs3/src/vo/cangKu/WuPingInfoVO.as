package vo.cangKu
{
	import ui.vo.ValueObject;

	[Bindable]
	public class WuPingInfoVO extends ValueObject
	{
		/**
		 *物品ID
		 */		
		public var id:int;
		/**
		 *物品名字
		 */		
		public var name:String;
		/**
		 *物品类型  "Chariot" "TankPart" "item" "recipes"
		 */		
		public var itemType:String;
		/**
		 *物品分类
		 */		
		public var category:int;
		/**
		 *强化类型
		 */		
		public var enhanced:int;
		/**
		 *型号
		 */		
		public var type:int;
		/**
		 *等级
		 */		
		public var level:int;
		/**
		 *评分
		 */		
		public var value:int;
		/**
		 *挂件插槽类型
		 */		
		public var slotType:int;
		/**
		 *挂件是否被挂载
		 */		
		public var isMounted:Boolean;
		/**
		 *折合暗物质
		 */		
		public var darkMatterValue:int;
		/**
		 *图纸类型
		 */		
		public var recipeType:int;
		/**
		 *是否已用
		 */		
		public var canUse:Boolean;
		/**
		 *图纸挂件类型
		 */		
		public var tankPartType:int;
		/**
		 *道具
		 */		
		public var inUsing:Boolean;
		/**
		 *属性
		 */		
		public var property:Object;
		
		public function WuPingInfoVO()
		{
			
		}
	}
}