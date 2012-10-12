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
		
		public static function htmlEntitiesEncode(value: String): String
		{
			value = value.replace(/\&/g, "&amp;");
			value = value.replace(/\</g, "&gl;");
			value = value.replace(/\>/g, "&gt;");
			return value;
		}
		
		public static function htmlEntitiesDecode(value: String): String
		{
			value = value.replace(/&amp;/g, "&");
			value = value.replace(/&gl;/g, "<");
			value = value.replace(/&gt;/g, ">");
			return value;
		}
	}
}