package vo.cangKu
{
	import ui.vo.ValueObject;
	
	public class DaoJuInfoVO extends ValueObject
	{
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
		public var inUsing:int;
		/**
		 *强化类型
		 */		
		public var enhanced:int;
		public var type:int;
		public function DaoJuInfoVO()
		{
			super();
		}
	}
}