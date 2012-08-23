package ui.components {
	import apollo.graphics.CGraphicPool;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.EventDispatcher;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class UIMenuItem extends Sprite
	{
		private var _bitmapCache: Bitmap;
		
		public function UIMenuItem(title: String) 
		{
			super();
			_bitmapCache = new Bitmap(CGraphicPool.getInstance().getUIResource("MenuItem"));
			addChild(_bitmapCache);
			
			var _font: Font = CGraphicPool.getInstance().getFont("FontWRYH");
			var my_fmt: TextFormat = new TextFormat();
			my_fmt.bold = true;
			my_fmt.font = _font.fontName;
			my_fmt.size = 14;
			my_fmt.color = 0xFFFFFF;

			var fpsText: TextField = new TextField();
			fpsText.defaultTextFormat = my_fmt;
			fpsText.autoSize = TextFieldAutoSize.CENTER;
			fpsText.text = title;
			fpsText.selectable = false
			addChild(fpsText);
		}
	}

}