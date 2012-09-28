package enum
{
	import com.zn.multilanguage.MultilanguageManager;

	/**
	 *动态加载资源 
	 * @author zn
	 * 
	 */	
	public class ResEnum
	{
		public static function get parentURL():String
		{
			return MultilanguageManager.language+ "/images/";
		}
		
		public static function get senceEquipment():String
		{
			return parentURL+"senceEquipment/";
		}

		
		public static function get crystalIconURL():String
		{
			return MultilanguageManager.language+"/images/icon/crystal.png";
		}
		
		public static function get brokenCrystalIconURL():String
		{
			return MultilanguageManager.language+"/images/icon/broken_crystal.png";
		}

	}
}