package utils.liteui.component
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import utils.enum.ScrollBarPolicy;
	import utils.liteui.core.Component;
	import utils.liteui.core.IViewPort;
	
	public class ScrollBar extends Component
	{
		protected var _upButton: Button;
		protected var _downButton: Button;
		protected var _trackSprite: Sprite;
		protected var _bar: Sprite;
		protected var _barIcon: Sprite;
		protected var _view: IViewPort;
		private var _viewStepScale: Number = 0;
		private var _scrollStepScale: Number = 0;
		private var _scrollPolicy: String = ScrollBarPolicy.AUTO;
		private var _value: Number = 0;
		private var _maxValue: Number = 0;
		private var _autoScroll: Boolean = false;
		private var _oldBarMouseDownPos: Number;
		private var _oldBarMousePos: Number;
		private var _width: Number;
		private var _height: Number;
		
		public function ScrollBar(_skin:DisplayObjectContainer=null)
		{
			super(_skin);
			_upButton = getUI(Button, "btnUp");
			_downButton = getUI(Button, "btnDown");
			_trackSprite = getSkin("track") as Sprite;
			_bar = getSkin("bar") as Sprite;
			_barIcon = getSkin("barIcon") as Sprite;
			sortChildIndex();
			
			_upButton.addEventListener(MouseEvent.CLICK, onUpButtonClick);
			_downButton.addEventListener(MouseEvent.CLICK, onDownButtonClick);
			
			_bar.mouseEnabled = true;
			_bar.buttonMode = true;
			_bar.addEventListener(MouseEvent.MOUSE_DOWN, onBarMouseDown);
			width = _skin.width;
			height = _skin.height;
		}
		
		protected function onUpButtonClick(evt: MouseEvent): void
		{
			
		}
		
		protected function onDownButtonClick(evt: MouseEvent): void
		{
			
		}
		
		protected function onBarMouseDown(evt: MouseEvent): void
		{
			
		}
		
		public function get view(): IViewPort
		{
			return _view;
		}
		
		public function set view(value: IViewPort): void
		{
			if(value != null)
			{
				
			}
		}
	}
}