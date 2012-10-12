package enum.item
{
	import com.zn.multilanguage.MultilanguageManager;

	/**
	 * 插槽类型
	 * @author zn
	 * 
	 */
	public class SlotEnum
	{
		/**
		 * 大
		 * 攻击
		 */
		public static const BIG:int=1;
		
		/**
		 * 中
		 * 抗性
		 */
		public static const MID:int=2;
		
		/**
		 * 小
		 */
		public static const SMALL:int=3;
		
		public static function getSlotTypeStr(type:int):String
		{
			switch(type)
			{
				case BIG:
				{
					return MultilanguageManager.getString("GuaJianTypeBig");
					break;
				}
				case MID:
				{
					return MultilanguageManager.getString("GuaJianTypeMid");
					break;
				}
				case SMALL:
				{
					return MultilanguageManager.getString("GuaJianTypeSmall");
					break;
				}
			}
			
			return "";
		}
	}
}