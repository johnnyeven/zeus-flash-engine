package ui.components {
	
	import apollo.graphics.CGraphicPool;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	
	public class UIMenu extends Sprite
	{
		private var _menuList: Vector.<String>;
		private var _menuListCallback: Vector.<Function>;
		private var _menuItemBg: BitmapData;
		
		private var _nextX: int;
		private var _nextY: int;
		
		public function UIMenu() {
			super();
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
				item.addEventListener(MouseEvent.CLICK, _menuListCallback[key]);
				addChild(item);
				
				_nextY += (_menuItemBg.height + 5);
			}
		}
		
		public function slideDown(): void
		{
			
		}
		
		public function slideUp(): void
		{
			
		}
	}
	
}
