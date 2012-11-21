package enum.giftBag
{
	/**
	 *礼包种类
	 * @author rl
	 * 
	 */	
	public class GiftBagTypeEnum
	{
		/**
		 *新手礼包
		 */		
		public static const GiftBag_New:int = 1;
		/**
		 *连续登录奖
		 */		
		public static const GiftBag_LoginEvery:int = 2;
		/**
		 *每天首次登陆奖
		 */		
		public static const GiftBag_LoginFirst:int = 3;
		/**
		 *在线礼包
		 */		
		public static const GiftBag_Online:int = 4;
		/**
		 *日声望排名礼包
		 */		
		public static const GiftBag_PopRank:int = 5;
		/**
		 *每日要塞排行礼包
		 */		
		public static const GiftBag_FortRank:int = 6;
		/**
		 *每日财富排名礼包
		 */		
		public static const GiftBag_RichRank:int = 7;
		/**
		 *消费返回活动
		 */		
		public static const GiftBag_ConsumeBack:int = 8;
		/**
		 *0消耗购车
		 */		
		public static const GiftBag_BuyChiort:int = 9;
		
		public function GiftBagTypeEnum()
		{
		}
	}
}