package vo.timeMachine
{
	import enum.BuildTypeEnum;
	
	import ui.vo.ValueObject;

	/**
	 *时间机器 
	 * @author lw
	 * 
	 */	
	public class TimeMachineVO extends ValueObject
	{
		/**
		 * 建筑类型
		 */		
		public var building_type:int;
		
		/**
		 * 建筑等级
		 */	
		public var level:int;
		
		/**
		 * 事件开始时间
		 */	
		public var start_time:Number;
		
		/**
		 * 事件结束时间
		 */	
		public var finish_time:Number;
		
		/**
		 * 服务器当前时间
		 */
		public var current_time:Number;
		
		
		private var _upTotalTome:Number;
		private var _remainingTime:Number;
		
		private var _crystalCount:int;
		/**
		 * 消耗暗能水晶总数
		 */
		public var totalCrystal:int;
		
		public function TimeMachineVO()
		{
			totalCrystal = _crystalCount;
		}

		/**
		 * 建筑升级总时间
		 */
		public function get upTotalTome():Number
		{
			return _upTotalTome;
		}

		/**
		 * @private
		 */
		public function set upTotalTome(value:Number):void
		{
			upTotalTome = finish_time - start_time;
			_upTotalTome = value;
		}

		/**
		 * 建筑升级剩余时间
		 */
		public function get remainingTime():Number
		{
			return _remainingTime;
		}

		/**
		 * @private
		 */
		public function set remainingTime(value:Number):void
		{
			remainingTime = upTotalTome - (current_time - start_time);
			_remainingTime = value;
		}

		/**
		 * 消耗暗能水晶
		 */
		public function get crystalCount():int
		{
			_crystalCount = BuildTypeEnum.getCrystalCountByBuildLevel(level);
			return _crystalCount
		}
	}
}