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
		protected var _fontSize: Number = 0;
		
		public function FTEngine()
		{
		}
		
		public function createElement(value: String): GroupElement
		{
			XML.ignoreWhitespace = false;
			var _parsedXML: XML = convertToXML(value);
			var _groupElement:Vector.<ContentElement> = new Vector.<ContentElement>();
			
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