package enum.battle
{

	/**
	 *战场BUFF物品类型
	 * @author zn
	 *
	 */
	public class FightBuffItemTypeEnum
	{
		/**
		 *耐久
		 */
		public static const naiJiu:int=0;

		/**
		 *护盾
		 */
		public static const huDun:int=1;

		/**
		 *金晶
		 */
		public static const jinJing:int=2;
		/**
		 *氚氢
		 */
		public static const chuanQing:int=3;
		/**
		 *暗物质
		 */
		public static const anWuZhi:int=4;
		/**
		 *暗能水晶
		 */
		public static const anNengShuiJing:int=5;
		/**
		 *僚机
		 */
		public static const liaoJi:int=6;

		public static function setItemType(buffVO:BUFFER_DEF):void
		{
			if (buffVO.type == 0)
			{
				if (buffVO.subType == 0)
					buffVO.itemType=naiJiu;
				else if (buffVO.subType == 1)
					buffVO.itemType=huDun;
			}
			else if (buffVO.type == 1)
			{
				if (buffVO.subType == 0)
					buffVO.itemType=jinJing;
				else if (buffVO.subType == 1)
					buffVO.itemType=chuanQing;
				else if (buffVO.subType == 2)
					buffVO.itemType=anWuZhi;
				else if (buffVO.subType == 3)
					buffVO.itemType=anNengShuiJing;
			}
			else if (buffVO.type == 2)
				buffVO.itemType=liaoJi;
		}
	}
}
