package enum.groupFightEnum
{
	import vo.groupFight.GroupFightVo;

	public class GroupFightEnum
	{
		public static const ZHU_STAR:String="5000";
		
		public static const ZIYUAN1_STAR:String="4001";
		
		public static const ZIYUAN2_STAR:String="4002";
		
		public static const ZIYUAN3_STAR:String="4003";
		
		public static const MAINSTAR_TYPE:int=1;
		
		public static const MONEY:int=1;
		
		
		/**
		 *当前选中的行星Vo 
		 */		
		public static var CURRTENT_STARVO:GroupFightVo;
		
		/**
		 *当前需要到达目的地的行星VO 
		 */		
		public static var CURRTENT_TO_STARVO:GroupFightVo;
		
		public static var NUM:int;
		public function GroupFightEnum()
		{
			
		}
	}
}