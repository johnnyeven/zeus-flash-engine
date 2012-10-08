package utils.liteui.component
{
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.engine.TextBaseline;
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextLine;
	
	import utils.UIUtils;
	import utils.liteui.core.Component;
	import utils.liteui.core.ftengine.FTEFormater;
	import utils.liteui.core.ftengine.FTEngine;
	
	public class Label extends Component
	{
		private var _text: String = "";
		private var _align: String = TextFormatAlign.LEFT;
		private var _color: Number = 0x000000;
		private var _size: uint = 12;
		private var _wordWrap: Boolean = false;
		private var _autoSize: Boolean = false;
		private var _bold: Boolean = false;
		private var _ftengine: FTEngine;
		private var _textBlock: TextBlock;
		private var _textBuffer: Sprite;
		private var _hGap: Number = 1;
		private var _vGap: Number = 2;
		private var _fontName: String = "微软雅黑";
		private var _textWidth: Number = 100;
		private var _textHeight: Number = 16;
		public var lock: Boolean = false;
		
		public function Label(_skin:TextField=null)
		{
			super(_skin);
			mouseEnabled = false;
			mouseChildren = false;
			
			_textBlock = new TextBlock();
			_textBlock.baselineZero = TextBaseline.IDEOGRAPHIC_TOP;
			_textBuffer = new Sprite();
			setFilter();
			
			if(_skin != null)
			{
				lock = true;
				
				x = _skin.x;
				y = _skin.y;
				width = _skin.width;
				height = _skin.height;
				
				textWidth = _skin.width;
				textHeight = _skin.height;
				wordWrap = _skin.wordWrap;
				
				var defaultTextFormat: TextFormat = _skin.defaultTextFormat;
				align = defaultTextFormat.align;
				color = defaultTextFormat.color as Number;
				size = defaultTextFormat.size as Number;
				bold = defaultTextFormat.bold as Boolean;
				fontName = defaultTextFormat.font;
				text = FTEFormater.htmlToFTEFormat(_skin.htmlText);
				
				lock = false;
				updateText();
				
				UIUtils.remove(_skin);
			}
		}
		
		override public function dispose(): void
		{
			super.dispose();
			_ftengine = null;
			_textBuffer = null;
			_textBlock = null;
		}
		
		public function updateText(): void
		{
			
		}
		
		private function createLine(): void
		{
			var _textWidth: Number = this._textWidth;
			if(_autoSize)
			{
				_textWidth = 100000;
			}
			var _textLine:TextLine = _textBlock.createTextLine(null, _textWidth);
		}

		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			_text = value;
		}

		public function get align():String
		{
			return _align;
		}

		public function set align(value:String):void
		{
			_align = value;
		}

		public function get color():Number
		{
			return _color;
		}

		public function set color(value:Number):void
		{
			_color = value;
		}

		public function get size():uint
		{
			return _size;
		}

		public function set size(value:uint):void
		{
			_size = value;
		}

		public function get wordWrap():Boolean
		{
			return _wordWrap;
		}

		public function set wordWrap(value:Boolean):void
		{
			_wordWrap = value;
		}

		public function get autoSize():Boolean
		{
			return _autoSize;
		}

		public function set autoSize(value:Boolean):void
		{
			_autoSize = value;
		}

		public function get bold():Boolean
		{
			return _bold;
		}

		public function set bold(value:Boolean):void
		{
			_bold = value;
		}

		public function get hGap():Number
		{
			return _hGap;
		}

		public function set hGap(value:Number):void
		{
			_hGap = value;
		}

		public function get vGap():Number
		{
			return _vGap;
		}

		public function set vGap(value:Number):void
		{
			_vGap = value;
		}

		public function get fontName():String
		{
			return _fontName;
		}

		public function set fontName(value:String):void
		{
			_fontName = value;
		}
		
		public function get textWidth(): Number
		{
			return _textWidth;
		}
		
		public function set textWidth(value: Number): void
		{
			_textWidth = value;
			updateText();
		}
		
		public function get textHeight():Number
		{
			return _textHeight;
		}
		
		public function set textHeight(value:Number):void
		{
			_textHeight = value;
			updateText();
		}
		
		public function get textBlock(): TextBlock
		{
			return _textBlock;
		}
		
		override protected function setFilter(): void
		{
			if(filterEnabled)
			{
				_textBuffer.filters = [
					new GlowFilter(filterColor, 1, 3, 3, 300);
				];
			}
			else
			{
				_textBuffer.filters = [];
			}
		}
	}
}