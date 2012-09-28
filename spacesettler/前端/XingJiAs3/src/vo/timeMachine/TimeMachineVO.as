package vo.timeMachine
{
	import com.zn.utils.DateFormatter;
	
	import enum.BuildTypeEnum;
	
	import ui.vo.ValueObject;

	/**
	 *时间机器 
	 * @author lw
	 * 
	 */	
	[Bindable]
	public class TimeMachineVO extends ValueObject
	{
		/**
		 * 事件ID
		 */
		public var eventID:String = "";
		/**
		 * 事件类型   建筑、科技、制造
		 */	
		public var type:String = "";
		/**
		 * 建筑类型
		 */		
		public var building_type:int;
		
		/**
		 * 建筑等级
		 */	
		public var level:int;
		
		/**
		 * 本机事件结束时间
		 */	
		public var finishTime:Number;
		
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
		
		/**
		 * 建筑升级     本机剩余时间
		 */
		public function get remainTime():Number
		{
			return Math.max(0, finishTime - DateFormatter.currentTime);
		}

		
		public var crystalCount:int;
		/**
		 * 消耗暗能水晶总数
		 */
		public var totalCrystal:int;
		
		public function TimeMachineVO()
		{
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
			_remainingTime = value;
		}
	}
}