package vo.scienceResearch
{
	import com.zn.utils.DateFormatter;
	
	import ui.vo.ValueObject;

	/**
	 *科研 
	 * @author lw
	 * 
	 */	
	[Bindable]
	public class ScienceResearchVO extends ValueObject
	{
		
		public static const FIELD_SCIENCE_TYPE:String="science_type";
		
		public static const SPEEDCOST:int=1;
		
		/**
		 * 科技ID
		 */	
		public var id:String ="";
		/**
		 * 科技的类型
		 */		
		public var science_type:int;
		
		/**
		 * 科技名称
		 */		
		public var scienceName:String = "";
		
		/**
		 * 科技的地址
		 */		
		public var scienceIconURL:String = "";
		/**
		 * 科技的等级
		 */	
		public var level:int;
		/**
		 * 研究事件的ID
		 */	
		public var eventID:String ="";
		/**
		 * 研究需要的时间
		 */	
		public var time:Number;
		/**
		 * 研究开始的时间
		 */	
		public var start_time:Number;
		/**
		 * 研究结束的时间
		 */	
		public var finish_time:Number;
		
		/**
		 * 本机事件结束时间
		 */	
		public var finishTime:Number;
		
		/**
		 * 当前时间
		 */	
		public var current_time:Number;
		/**
		 *事件类型
		 */	
		public var eventType:String ="";
		/**
		 * 消耗氚氢
		 */	
		public var tritium:int;
		/**
		 * 消耗水晶
		 */	
		public var crystal:int;
		/**
		 * 消耗暗物质
		 */	
		public var broken_crystal:int;
		
		/**
		 * 需要的基地中心等级达到多少级
		 */	
		public var command_center_level:int;
		
		/**
		 * 需要科学院等级达到多少级
		 */	
		public var academy_level:int;
		
		public function ScienceResearchVO()
		{
		}
		
		private var _remainingTime:Number;
		
		/**
		 * 研究升级     本机剩余时间
		 */
		public function get remainTime():Number
		{
			return Math.max(0, finishTime - DateFormatter.currentTime);
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
		
		/**
		 *图纸研究的当前科技等级 
		 */		
		public var currentLevel:int=0;
		
		/**
		 *所有科技等级 
		 */		
		public var allLevel:int=0;
	}
}