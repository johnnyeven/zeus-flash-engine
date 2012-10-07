package utils.liteui.core.ftengine
{
	import flash.events.EventDispatcher;
	import flash.text.engine.ContentElement;
	import flash.text.engine.GroupElement;

	public class FTEngine extends EventDispatcher
	{
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