package utils.liteui.component
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
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
		
		public function ScrollBar(_skin:DisplayObjectContainer=null)
		{
			super(_skin);
		}
	}
}