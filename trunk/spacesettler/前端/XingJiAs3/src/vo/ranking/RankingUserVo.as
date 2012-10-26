package vo.ranking
{
	import ui.vo.ValueObject;
	
	public class RankingUserVo extends ValueObject
	{
		/**
		 *财富榜更新时间 
		 */		
		public var orders_rank_updated_time:int;
	
		/**
		 *个人声望榜更新时间 
		 */		
		public var person_prestige_rank_updated_time:int;
	
		/**
		 *军团声望榜更新时间 
		 */		
		public var legion_prestige_rank_updated_time:int;
	
		/**
		 *要塞榜更新时间 
		 */		
		public var forts_count_rank_updated_time:int;
		
		/**
		 *财富榜总榜第一的玩家昵称
		 */		
		public var orders_total_rank_first:String;
		
		/**
		 *财富榜日榜第一的玩家昵称
		 */		
		public var orders_daily_rank_first:String;
		
		/**
		 *个人声望总榜第一的玩家昵称
		 */		
		public var person_prestige_total_rank_first:String;
		
		/**
		 *个人声望日榜第一的玩家昵称
		 */		
		public var person_prestige_daily_rank_first:String;
		
		/**
		 *军团声望总榜第一的军团昵称
		 */		
		public var legion_prestige_total_rank_first:String;
		
		/**
		 *军团声望日榜第一的军团昵称
		 */		
		public var legion_prestige_daily_rank_first:String;
		
		/**
		 *要塞榜总榜第一的军团昵称
		 */		
		public var forts_count_total_rank_first:String;
		
		/**
		 *要塞榜日榜第一的军团昵称
		 */		
		public var forts_count_daily_rank_first:String;
		
		public function RankingUserVo()
		{
			super();
		}
	}
}