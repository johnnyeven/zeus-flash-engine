package vo.userInfo
{
	import ui.vo.ValueObject;
	
	public class BuffVo extends ValueObject
	{
		/**
		 *增益类型 
		 */		
		public var type:int;
		
		/**
		 *增益效果 增益量 
		 */		
		public var value:Number;
		
		public function BuffVo()
		{
			super();
		}
	}
}