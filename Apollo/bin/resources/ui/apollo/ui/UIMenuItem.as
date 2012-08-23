package apollo.ui {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.EventDispatcher;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import apollo.ui.assets.MenuItem;
	
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class UIMenuItem extends Sprite
	{
		private var _bitmapCache: Bitmap;
		
		public function UIMenuItem(bg: BitmapData, title: String) 
		{
			super();
			_bitmapCache = new Bitmap(bg);
			addChild(_bitmapCache);
			
			var my_fmt: TextFormat = new TextFormat();
			my_fmt.bold = true;
			my_fmt.font = "Arial";
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