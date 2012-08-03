package Apollo.Display 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import Apollo.Graphics.CGraphicPool;
	
	/**
	 * ...
	 * @author john
	 */
	public class TextFieldEx extends TextField 
	{
		private var _maxWidth:uint=200;
		private var _lockWidth:uint = 0;
		private var _format:TextFormat;
		public var Filter:GlowFilter;
		public static const FONT:String = 'Verdana';
		public static const LEFT:uint = 0;
		public static const CENTER:uint = 1;
		public static const RIGHT:uint = 2;
		public var Data:*;
		
		public function TextFieldEx(_text: String = '', fontcolor: int = -1, bgcolor: int = -1, border: int = -1, size: uint = 12, font: String = "") 
		{
			super();
			
			if (fontcolor>=0) textColor = fontcolor;
			if (bgcolor>=0) bgColor = bgcolor;
			if (border >= 0) fontBorder = border;
			if (font == "")
			{
				font = FONT;
			}
			else
			{
				var _font: Font = CGraphicPool.getInstance().getFont(font);
				font = _font.fontName;
				embedFonts = true;
			}
			_format = new TextFormat(font, size);
			selectable = false;
			height = size;
			if (_text != '')
			{
				text = _text;
				flush();
			}
			addEventListener(Event.CHANGE, autoAlign);
		}
		
		public function get textFormat(): TextFormat
		{
			return _format;
		}
		
		public function set maxWidth(value: uint): void
		{
			_maxWidth = value;
		}
		
		/**
		 * 自动调整高度宽度
		 */
		public function autoIncrease(): void
		{
			width = (_maxWidth == 0 || multiline == false) ? textWidth + 6 : _maxWidth;
			height = textHeight + 6;
		}
		
		/**
		 * 文本框背景色
		 */
		public function set bgColor(value: uint): void
		{
			background = true;
			backgroundColor = value;
		}
		
		public function set fontBorder(value: uint): void
		{
			var _filter: GlowFilter = new GlowFilter(value, 1, 2, 2, 1000);
			filters = new Array(_filter);
		}
		
		public function set fontSize(value: uint): void
		{
			_format.size = value;
			flush();
		}
		
		public function set fontBold(value: Boolean): void
		{
			_format.bold = value;
			flush();
		}
		
		override public function set multiline(value: Boolean): void
		{
			super.multiline = value;
			wordWrap = value;
		}
		
		override public function set type(value: String): void
		{
			super.type = value;
			selectable = true;
		}
		
		private function autoAlign(event: Event): void
		{
			if (text == "")
			{
				return;
			}
			else
			{
				flush();
			}
		}
		
		public function set align(value: uint): void
		{
			switch(value)
			{
				case CENTER:
					_format.align = TextFormatAlign.CENTER;
					break;
				case LEFT:
					_format.align = TextFormatAlign.LEFT;
					break;
				case RIGHT:
					_format.align = TextFormatAlign.RIGHT;
					break;
			}
			flush();
		}
		
		public function flush(): void
		{
			setTextFormat(_format);
		}
		
		override public function set text(value: String): void
		{
			if (wordWrap)
			{
				wordWrap = false;
				super.text = value;
				if (textWidth > _maxWidth)
				{
					_lockWidth = _maxWidth;
				}
				wordWrap = true;
			}
			else
			{
				super.text = value;
			}
			flush();
		}
		
		override public function set htmlText(value: String): void
		{
			if (wordWrap)
			{
				wordWrap = false;
				super.htmlText = value;
				if (textWidth > _maxWidth)
				{
					_lockWidth = _maxWidth;
				}
				wordWrap = true;
			}
			else
			{
				super.htmlText = value;
			}
			flush();
		}
		
		public function displayOn(o: DisplayObject, ignoreHeight: Boolean = true, padding: uint = 4): void
		{
			width = o.width - 2 * padding;
			if (!ignoreHeight)
			{
				height = o.height - 2 * padding;
			}
			x = o.x + padding;
			y = o.y + padding;
		}
		
		public function clear(): void
		{
			
		}
	}

}