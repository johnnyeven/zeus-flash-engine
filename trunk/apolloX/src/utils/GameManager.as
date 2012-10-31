package utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	
	import utils.liteui.core.Component;
	
	public class GameManager extends Component
	{
		private var _baseLayer: Sprite;
		private var _viewLayer: Sprite;
		private var _popUpLayer: Sprite;
		private var _toolTipLayer: Sprite;
		private var _infoLayer: Sprite;
		private static var _setRoot: Boolean = false;
		private static var _root: Stage;
		private static var _allowInstance: Boolean = false;
		private static var _instance: GameManager;
		
		public function GameManager()
		{
			super(null);
			if(_instance != null)
			{
				throw new IllegalOperationError("不能实例化GameManager类");
			}
			_instance = this;
			_baseLayer = new Sprite();
			_viewLayer = new Sprite();
			_popUpLayer = new Sprite();
			_toolTipLayer = new Sprite();
			_infoLayer = new Sprite();
			addChild(_baseLayer);
			addChild(_viewLayer);
			addChild(_popUpLayer);
			addChild(_toolTipLayer);
			addChild(_infoLayer);
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(evt: Event): void
		{
			container = stage;
		}
		
		public function addBase(target: DisplayObject): void
		{
			_baseLayer.addChild(target);
		}
		
		public function removeBase(target: DisplayObject): void
		{
			if(_baseLayer.contains(target))
			{
				_baseLayer.removeChild(target);
			}
		}
		
		public function addInfo(target: DisplayObject): void
		{
			_infoLayer.addChild(target);
		}
		
		public function removeInfo(target: DisplayObject): void
		{
			if(_infoLayer.contains(target))
			{
				_infoLayer.removeChild(target);
			}
		}
		
		public static function get instance(): GameManager
		{
//			if(_instance == null)
//			{
//				_allowInstance = true;
//				_instance = new GameManager();
//				_allowInstance = false;
//			}
			return _instance;
		}
		
		public static function set container(value: Stage): void
		{
			if(!_setRoot)
			{
				_root = value;
				_setRoot = true;
			}
		}
		
		public static function get container(): Stage
		{
			return _root;
		}
	}
}