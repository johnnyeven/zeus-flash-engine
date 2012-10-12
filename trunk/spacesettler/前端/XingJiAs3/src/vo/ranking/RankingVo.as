package vo.ranking
{
	import ui.vo.ValueObject;
	
	public class RankingVo extends ValueObject
	{
		/**
		 *玩家ID 
		 */		
		public var id:String;
		
		/**
		 *昵称 
		 */		
		public var nickname:String;
		
		/**
		 * VIP等级
		 */		
		public var vip_level:int;
		
		/**
		 *军团名 
		 */		
		public var legion_name:String;
		
		/**
		 * 显示
		 */		
		public var show:int;
		
		/**
		 * 排名
		 */		
		public var rank:int;
		
		public function RankingVo()
		{
			super();
		}
		
		
	}
}