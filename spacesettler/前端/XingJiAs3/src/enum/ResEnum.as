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
	}
}