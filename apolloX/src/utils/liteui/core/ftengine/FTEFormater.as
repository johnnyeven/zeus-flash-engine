package utils.liteui.core.ftengine
{
	public class FTEFormater
	{
		public function FTEFormater()
		{
			
		}
		
		public static function htmlToFTEFormat(value: String): String
		{
			XML.ignoreWhitespace = false;
			var _xml: XML = FTEngine.convertToXML(value);
			var _xmlConverted: XML = new XML();
			
			for(var key: String in _xml.children())
			{
				createNode(_xml.child(key), _xmlConverted);
			}
			
			XML.ignoreWhitespace = true;
			return _xmlConverted.toXMLString();
		}
		
		private static function createNode(source: XMLList, target: XML): void
		{
			switch(source.localName())
			{
				case "FONT":
					createFont(source, target);
					break;
				case "A":
					createAnchor(source, target);
					break;
				case "P":
					createParagraph(source, target);
					break;
				default:
					createText(source, target);
			}
		}
		
		private static function createFont(source: XMLList, target: XML): void
		{
			for(var key: String in source.children())
			{
				createNode(source.child(key), target);
			}
		}
		
		private static function createAnchor(source: XMLList, target: XML): void
		{
			var _color: String;
			if(source.parent().hasOwnProperty("@COLOR"))
			{
				_color = "0x" + (source.parent().@COLOR as String).replace("#", "");
			}
			var _href: String = (source.@HREF as String).replace("event:", "");
			if(_color != null)
			{
				target.appendChild(new XML("<a value=\"" + _href + "\"><string color=\"" + _color + "\">" + source + "</string></a>"));
			}
			else
			{
				target.appendChild(new XML("<a value=\"" + _href + "\"><string>" + source + "</string></a>"));
			}
		}
		
		private static function createParagraph(source: XMLList, target: XML): void
		{
			for(var key: String in source.children())
			{
				createNode(source.child(key), target);
			}
		}
		
		private static function createText(source: XMLList, target: XML): void
		{
			var _color: String;
			if(source.parent().hasOwnProperty("@COLOR"))
			{
				_color = "0x" + (source.parent().@COLOR as String).replace("#", "");
			}
			if(_color != null)
			{
				target.appendChild(new XML("<string color=\"" + _color + "\">" + source + "</string>"));
			}
			else
			{
				target.appendChild(new XML("<string>" + source + "</string>"));
			}
		}
	}
}