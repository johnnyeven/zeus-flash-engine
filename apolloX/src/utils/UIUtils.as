package utils
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import utils.GameManager;
	import utils.liteui.core.Component;

	public class UIUtils
	{
		public function UIUtils()
		{
		}
		
		public static function remove(child: DisplayObject): void
		{
			if(child.parent != null)
			{
				child.parent.removeChild(child);
			}
		}
		
		public static function center(target: DisplayObject): void
		{
			var _stageCenter: Point = stageCenter;
			target.x = _stageCenter.x - (target.width * target.scaleX) / 2;
			target.y = _stageCenter.y - (target.height * target.scaleY) / 2;
		}
		
		public static function setCommonProperty(target: Component, source: DisplayObject): void
		{
			target.name = source.name;
			target.x = source.x;
			target.y = source.y;
		}
		
		private static function get stageCenter(): Point
		{
			var _stage: Stage = GameManager.container;
			
			return new Point(_stage.stageWidth / 2, _stage.stageHeight / 2);
		}
		
		public static function componentCenterInStage(comp: DisplayObject, width: Number = NaN, height: Number = NaN): Point
		{
			var _stage: Stage = GameManager.container;
			var _rect: Rectangle = comp.getRect(comp);
		}
	}
}