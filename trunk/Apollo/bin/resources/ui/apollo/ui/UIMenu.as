package apollo.ui {
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	import apollo.ui.assets.MenuItem;
	
	
	public class UIMenu extends MovieClip
	{
		private var _menuList: Dictionary;
		private var _menuItemBg: MenuItem;
		
		private var _nextX: int;
		private var _nextY: int;
		
		public function UIMenu() {
			// constructor code
			super();
			_menuList = new Dictionary();
			_menuItemBg = new MenuItem();
			_nextX = 0;
			_nextY = 0;
			addEventListener(Event.ADDED_TO_STAGE, render, false, 0, true);
		}
		
		public function addMenuItem(title: String, listener: Function): void
		{
			_menuList[title] = listener;
		}
		
		private function render(evt: Event): void
		{
			for (var key: Object in _menuList)
			{
				var item: UIMenuItem = new UIMenuItem(_menuItemBg, key as String);
				
				item.x = _nextX;
				item.y = _nextY;
				item.addEventListener(MouseEvent.CLICK, _menuList[key]);
				addChild(item);
				
				_nextY += (_menuItemBg.height + 5);
			}
		}
	}
	
}
