package utils
{
	public class StringUtils
	{
		public function StringUtils()
		{
		}
		
		public static function empty(value: String): Boolean
		{
			return (value == "") || (value == null);
		}
	}
}