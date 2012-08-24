package ui.components {
	
	import apollo.graphics.CGraphicPool;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	
	public class UIMenu extends Sprite
	{
		private var _menuItem: Vector.<UIMenuItem>;
		private var _menuList: Vector.<String>;
		private var _menuListCallback: Vector.<Function>;
		private var _menuItemBg: BitmapData;
		
		private var _nextX: int;
		private var _nextY: int;
		
		public function UIMenu() {
			super();
			_menuItem = new Vector.<UIMenuItem>();
			_menuList = new Vector.<String>();
			_menuListCallback = new Vector.<Function>();
			_menuItemBg = CGraphicPool.getInstance().getUIResource("MenuItem");
			_nextX = 0;
			_nextY = 0;
			addEventListener(Event.ADDED, readyToRender, false, 0, true);
		}
		
		public function addMenuItem(title: String, listener: Function): void
		{
			_menuList.push(title);
			_menuListCallback.push(listener);
		}
		
		private function readyToRender(evt: Event): void
		{
			removeEventListener(Event.ADDED, readyToRender);
			for (var key: String in _menuList)
			{
				var item: UIMenuItem = new UIMenuItem(_menuList[key]);
				
				item.x = _nextX;
				item.y = _nextY;
				item.alpha = 0;
				item.addEventListener(MouseEvent.CLICK, _menuListCallback[key]);
				_menuItem.push(item);
				addChild(item);
				
				_nextY += (_menuItemBg.height + 5);
			}
		}
		
		public function slideDown(): void
		{
			addEventListener(Event.ENTER_FRAME, onSlideDown);
		}
		
		private function onSlideDown(evt: Event): void
		{
			for (var key: String in _menuItem)
			{
				_menuItem[key].alpha += 0.1;
				if (_menuItem[key].alpha >= 1)
				{
					for (var key1: String in _menuItem)
					{
						_menuItem[key1].alpha = 1;
					}
					removeEventListener(Event.ENTER_FRAME, onSlideDown);
				}
			}
		}
		
		public function slideUp(): void
		{
			addEventListener(Event.ENTER_FRAME, onSlideUp);
		}
		
		private function onSlideUp(evt: Event): void
		{
			for (var key: String in _menuItem)
			{
				_menuItem[key].alpha -= 0.1;
				if (_menuItem[key].alpha <= 0)
				{
					for (var key1: String in _menuItem)
					{
						_menuItem[key1].alpha = 0;
					}
					removeEventListener(Event.ENTER_FRAME, onSlideDown);
					clear();
				}
			}
		}
		
		private function clear(): void
		{
			for (var key: String in _menuItem)
			{
				_menuItem[key].removeEventListener(MouseEvent.CLICK, _menuListCallback[key]);
				delete _menuItem[key];
			}
			for (key in _menuList)
			{
				delete _menuList[key];
			}
			
			this.visible = false;
			delete this;
		}
	}
	
}
