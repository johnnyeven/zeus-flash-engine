package vo.cangKu
{
	import ui.vo.ValueObject;
	
	/**
	 *图纸学习条件 
	 * @author zn
	 * 
	 */	
	public class RecipesStudyConditionVO extends ValueObject
	{
		/**
		 * 学习条件类型
		 */
		public var science_type:int;
		
		/**
		 * 学习条件等级
		 */
		public var science_level:int;
	}
}