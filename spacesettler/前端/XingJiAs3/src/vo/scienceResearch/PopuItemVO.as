package vo.scienceResearch
{
	import ui.vo.ValueObject;
	
	/**
	 * 弹出框信息条目
	 * @author lw
	 * 
	 */	
	public class PopuItemVO extends ValueObject
	{
		/**
		 *建筑类型
		 */	
		public var type:int;
		
		/**
		 *需要建筑等级条件
		 */	
		public var needCondition:int;
		
		/**
		 *建筑当前等级
		 */	
		public var currentLevel:int;
		
		public function PopuItemVO()
		{
		}
	}
}