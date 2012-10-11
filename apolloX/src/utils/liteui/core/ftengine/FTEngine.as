package utils.liteui.core.ftengine
{
	import flash.events.EventDispatcher;
	import flash.text.engine.ContentElement;
	import flash.text.engine.GroupElement;

	public class FTEngine extends EventDispatcher
	{
		public var defaultFontName: String = "黑体";
		public var defaultFontSize: Number = 12;
		public var defaultFontColor: uint = 0x000000;
		public var defaultBold: Boolean = false;
		public var defaultHGap: Number = 0;
		
		protected var _fontName: String;
		protected var _fontSize: int = 0;
		protected var _fontColor: int = -1;
		protected var _bold: Boolean = false;
		protected var _hGap: Number = -1;
		private var _hasBold: Boolean = false;
		
		public function FTEngine()
		{
		}
		
		public function createElement(value: String): GroupElement
		{
			XML.ignoreWhitespace = false;
			var _parsedXML: XML = convertToXML(value);
			var _groupElement:Vector.<ContentElement> = new Vector.<ContentElement>();
			
			_fontName = _parsedXML.hasOwnProperty("@fontName") ? (_parsedXML.@fontName as String) : "";
			_fontSize = _parsedXML.hasOwnProperty("@size") ? int(_parsedXML.@size) : 0;
			_fontColor = _parsedXML.hasOwnProperty("@color") ? int(_parsedXML.@color) : -1;
			_hGap = _parsedXML.hasOwnProperty("@hGap") ? (_parsedXML.@hGap as Number) : -1;
			if(_parsedXML.hasOwnProperty("@bold"))
			{
				_bold = _parsedXML.@bold as Boolean;
				_hasBold = true;
			}
			else
			{
				_bold = false;
				_hasBold = false;
			}
			var _parsedChild: XMLList;
			for(var key: String in _parsedXML.children())
			{
				_parsedChild = _parsedXML.child(key);
				switch(_parsedChild.localName())
				{
					case "string":
						
						break;
					case "graphic":
						
						break;
					case "a":
						
						break;
					case "n":
						
						break;
				}
			}
			XML.ignoreWhitespace = true;
			return new GroupElement(_groupElement);
		}
		
		public static function convertToXML(value: String): XML
		{
			var _xml: XML;
			try
			{
				_xml = XML(value);
			}
			catch(err: Error)
			{
				CONFIG::DebugMode
				{
					trace("FTEngine.convertToXML Error: " + err.message);
				}
			}
			return _xml;
		}
	}
}