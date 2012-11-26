package vo.groupFight
{
	import com.zn.utils.DateFormatter;
	
	import ui.vo.ValueObject;
	
	public class RewardsStarVo extends ValueObject
	{
		
		/**
		 *军团获得暗物质 
		 */		
		public var broken_crystal:int;
		
		/**
		 *军团获得暗能水晶 
		 */		
		public var dark_crystal:int;
		
		/**
		 *增益类型  type=1 水晶矿产量增加type=3 氚氢产量增加type=2 暗物质产量增加 
		 */		
		public var type:int;
		
		/**
		 *增益值 1为100%
		 */		
		public var value:Number;
		
		/**
		 *刷新时间
		 */		
		public var time:int;
		
		/**
		 *军团成员个人获得资源多少
		 */		
		public var count:int;
		
		/**
		 *个人获得资源TYPE type=1 水晶矿增加   type=3 氚氢增加   type=2 暗物质增加  4 为暗能水晶
		 */		
		public var resource_type:int;
		
		public var endTime:int=0;
		
		public function RewardsStarVo()
		{
			super();
		}
		
		/**
		 *剩余时间 
		 * @return 
		 * 
		 */		
		public function get remainTime():Number
		{
			return Math.max(0,endTime-DateFormatter.currentTime);
		}
		
		public function initTime():void
		{
			endTime= DateFormatter.currentTime + (time);
		}
	}
}