package vo.cangKu
{
	import ui.vo.ValueObject;
	
	public class TuZhiInfoVO extends ValueObject
	{
		/**
		 *图纸ID
		 */		
		public var id:int;
		/**
		 *图纸名字
		 */		
		public var name:String;
		/**
		 *图纸类型
		 */		
		public var recipeType:int;
		/**
		 *图纸分类
		 */		
		public var category:int;
		/**
		 *图纸强化类型
		 */		
		public var enhanced:int;
		/**
		 *图纸型号
		 */		
		public var type:int;
		/**
		 *是否已用
		 */		
		public var canUse:Boolean;
		/**
		 *图纸挂件类型
		 */		
		public var tankPartType:int;
		
		public function TuZhiInfoVO()
		{
			super();
		}
	}
}