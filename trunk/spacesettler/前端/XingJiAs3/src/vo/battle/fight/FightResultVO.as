package vo.battle.fight
{
	import flash.utils.ByteArray;
	
	import ui.vo.ValueObject;
	
	/**
	 * 战斗结果
	 * @author 
	 *
	 */
	public class FightResultVO extends ValueObject
	{
		/**
		 * 结果
		 * 
		 */
		public var result:int;
		
		public function FightResultVO()
		{
			super();
		}
		
		public function toObj(by:ByteArray):void
		{
			result=by.readInt();
		}
	}
}