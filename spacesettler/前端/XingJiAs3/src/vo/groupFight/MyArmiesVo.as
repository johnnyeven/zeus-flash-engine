package vo.groupFight
{
	import ui.vo.ValueObject;
	
	public class MyArmiesVo extends ValueObject
	{
		/**
		 *行星名 
		 */		
		public var name:String;
		
		/**
		 *该星球现有战舰数 
		 */		
		public var warship:int;
		
		public function MyArmiesVo()
		{
			super();
		}
	}
}