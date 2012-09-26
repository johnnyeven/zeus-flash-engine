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
		public function WuPingInfoVO()
		{
			
		}
	}
}