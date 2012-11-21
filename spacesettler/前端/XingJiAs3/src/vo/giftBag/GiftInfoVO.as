package vo.giftBag
{
	import ui.vo.ValueObject;
	
	public class GiftInfoVO extends ValueObject
	{
		/**
		 * 暗物质
		 */
		public var broken_crystal:int;
		/**
		 * 金晶矿
		 */
		public var crystal:int;
		/**
		 * 暗晶
		 */
		public var dark_crystal:int;
		/**
		 * 氚气
		 */
		public var tritium:int;
		/**
		 * 登陆天数
		 */
		public var day:int;
		/**
		 * 
		 */
		public var level:int;
		/**
		 * 
		 */
		public var time:int;
		/**
		 * 礼包类型
		 */
		public var type:String;
		public function GiftInfoVO()
		{
			super();
		}
	}
}