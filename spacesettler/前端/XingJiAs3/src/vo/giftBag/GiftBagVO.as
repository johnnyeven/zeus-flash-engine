package vo.giftBag
{
	import ui.vo.ValueObject;
	
	[Bindable]
	/**
	 *礼包
	 * @author zn
	 *
	 */
	public class GiftBagVO extends ValueObject
	{
		/**
		 *活动时间
		 * 开始时间
		 */
		public var begin_time:Number;
		
		public var countdown:int;
		/**
		 *活动时间
		 * 结束时间
		 */
		public var end_time:Number;
		/**
		 *奖励物品
		 * 暗物质
		 */
		public var broken_crystal:int;
		/**
		 *奖励物品
		 * 水晶矿
		 */
		public var crystal:int;
		/**
		 *奖励物品
		 * 暗能水晶
		 */
		public var dark_crystal:int;
		/**
		 *奖励物品
		 * 氚氢气
		 */
		public var tritium:int;
		/**
		 *是否已经领取
		 * "2"/true/false  过期/可以领取/已领取
		 */
		public var status:String;
		/**
		 *连续登陆天数
		 */
		public var days:int;
		/**
		 *
		 */
		public var last_time:int;
		/**
		 *
		 */
		public var level:int;
		/**
		 *
		 */
		public var now_time:int;
		/**
		 *
		 */
		public var time:int;
		/**
		 *排名
		 */
		public var rank:int;
		/**
		 *item
		 * 
		 */
		public var category:int;
		/**
		 *item
		 */
		public var enhanced:int;
		/**
		 *item
		 */
		public var r_type:String;
		/**
		 *item
		 */
		public var item_type:int;
		/**
		 *类型
		 */
		public var type:int;
		/**
		 *暗晶历史使用数
		 */
		public var consumer_count:int;
		/**
		 *暗晶返回
		 */
		public var back:int;
		/**
		 * 道具列表
		 */
		public var itemList:Array;
		/**
		 * 倒计时
		 */
		public var timeCount:int;
		
		
		
		
		public function GiftBagVO()
		{
			super();
		}
	}
}