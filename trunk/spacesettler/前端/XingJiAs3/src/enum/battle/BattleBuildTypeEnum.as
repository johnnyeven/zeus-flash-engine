package enum.battle
{
	import com.zn.multilanguage.MultilanguageManager;

	/**
	 *战场建筑类型 
	 * @author zn
	 * 
	 */
    public class BattleBuildTypeEnum
    {
		
		public static const EMPTY:int = 0;

		/**
		 *要塞中心  
		 */		
        public static const JI_DI:int = 1;

		/**
		 *综合采集厂  
		 */		
        public static const CAI_JI:int = 2;

		/**
		 *加农炮塔  
		 */		
        public static const JIA_Xie:int = 3;

		/**
		 *集束激光炮塔  
		 */		
        public static const JI_GUANG:int = 4;

		/**
		 *脉冲炮塔  
		 */		
        public static const DIAN_CI:int = 5;
		/**
		 *辐射炮塔 
		 */
        public static const AN_NENG:int = 6;
		
		public static function getBuildName(type:int):String
		{
			switch(type)
			{
				case JI_DI:
				{
					return MultilanguageManager.getString("battleJiDi");
					break;
				}
				case CAI_JI:
				{
					return MultilanguageManager.getString("battleCaiKuang");
					break;
				}
				case JIA_Xie:
				{
					return MultilanguageManager.getString("battleJiXiePaoTa");
					break;
				}
				case JI_GUANG:
				{
					return MultilanguageManager.getString("battleJiGuangPaoTa");
					break;
				}
				case DIAN_CI:
				{
					return MultilanguageManager.getString("battleDianCiPaoTa");
					break;
				}
				case AN_NENG:
				{
					return MultilanguageManager.getString("battleAnNengPaoTa");
					break;
				}
			}
			
			return "";
		}

		/**
		 *获取建筑描述 
		 * @param type
		 * @return 
		 * 
		 */		
		public static function getBuildDes(type:int):String
		{
			switch(type)
			{
				case JIA_Xie:
				{
					return MultilanguageManager.getString("battleJiXiePaoTaInfo");
					break;
				}
				case JI_GUANG:
				{
					return MultilanguageManager.getString("battleJiGuangPaoTaInfo");
					break;
				}
				case DIAN_CI:
				{
					return MultilanguageManager.getString("battleDianCiPaoTaInfo");
					break;
				}
				case AN_NENG:
				{
					return MultilanguageManager.getString("battleAnNengPaoTaInfo");
					break;
				}
			}
			
			return "";
		}
	}
}
