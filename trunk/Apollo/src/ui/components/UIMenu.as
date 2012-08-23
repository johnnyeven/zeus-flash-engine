package ui.components {
	
	import apollo.graphics.CGraphicPool;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	
	public class UIMenu extends Sprite
	{
		private var _menuList: Dictionary;
		private var _menuItemBg: BitmapData;
		
		private var _nextX: int;
		private var _nextY: int;
		
		public function UIMenu() {
			// constructor code
			super();
			_menuList = new Dictionary();
			_menuItemBg = CGraphicPool.getInstance().getUIResource("MenuItem");
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
				var item: UIMenuItem = new UIMenuItem(key as String);
				
				item.x = _nextX;
				item.y = _nextY;
				item.addEventListener(MouseEvent.CLICK, _menuList[key]);
				addChild(item);
				
				_nextY += (_menuItemBg.height + 5);
			}
		}
	}
	
}
