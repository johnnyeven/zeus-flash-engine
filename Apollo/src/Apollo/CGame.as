package Apollo 
{
	import Apollo.Center.CBuildingCenter;
	import Apollo.Center.CResourceCenter;
	import Apollo.Display.CCamera;
	import Apollo.Network.Data.CResourceParameter;
	import Apollo.Objects.*;
	import Apollo.Scene.CBaseScene;
	import Apollo.Objects.Effects.*;
	import Apollo.Controller.CControllerCenter;
	import Apollo.Maps.CWorldMap;
	import Apollo.Graphics.CGraphicPool;
	import Apollo.Events.*;
	import Apollo.Scene.CApolloScene;
	import Apollo.Configuration.*;
	import Apollo.Objects.Effects.screen.*;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.errors.IllegalOperationError;
	
	/**
	 * ...
	 * @author john
	 */
	public class CGame extends Sprite
	{
		private static var instance: CGame;
		private static var allowInstance: Boolean = false;
		private var loader: URLLoader;
		protected var _scene: CApolloScene;
		protected var _camera: CCamera;
		protected var _config: String;
		protected var _data: XML;
		protected var _mapId: String;
		protected var _player_startX: uint = 0;
		protected var _player_startY: uint = 0;
		protected var _isChangingMap: Boolean = false;
		protected var reconfigMapData: Function;
		
		public function CGame() 
		{
			super();
			if (!allowInstance)
			{
				throw new IllegalOperationError("CGame不允许实例化");
			}
			
			_config = "game_config";
			addEventListener(Event.ADDED_TO_STAGE, setup);
		}
		
		public static function getInstance(): CGame
		{
			if (instance == null)
			{
				allowInstance = true;
				instance = new CGame();
				allowInstance = false;
			}
			return instance;
		}
		
		protected function setup(event: Event): void
		{
			removeEventListener(Event.ADDED_TO_STAGE, setup);
			GlobalContextConfig.Width = stage.stageWidth;
			GlobalContextConfig.Height = stage.stageHeight;
			GlobalContextConfig.container = this;
			GlobalContextConfig.stage = stage;
			
			if (_config != '')
			{
				loadConfig();
			}
			//捕捉地图切换事件
			//_stage.addEventListener(MapEvent.MAP_CHANGE, onMapChange);
		}
		
		protected function onMapChange(event: MapEvent): void
		{
			_mapId = event.mapId;
			_player_startX = event.startX;
			_player_startY = event.startY;
			reconfigMapData = rebuildScene;
			_isChangingMap = true;
			clear();
			/*
			if (_scene.player != null)
			{
				_scene.player.visible = false;
			}
			*/
		}
		
		/**
		 * 加载游戏配置
		 */
		protected function loadConfig(): void
		{
			loader = new URLLoader();
			loader.addEventListener(IOErrorEvent.IO_ERROR, onConfigLoadError);
			loader.addEventListener(Event.COMPLETE, installConfig);
			loader.load(new URLRequest(SocketContextConfig.resource_server_ip + GlobalContextConfig.CONFIG_PATH + _config + '.xml'));
		}
		
		protected function onConfigLoadError(event: IOErrorEvent): void
		{
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onConfigLoadError);
			trace(event.text);
		}
		
		protected function installConfig(event: Event): void
		{
			loader.removeEventListener(Event.COMPLETE, installConfig);
			_data = XML(loader.data);
			
			_mapId = _data.defaultMapId;
			
			CGraphicPool.getInstance().addEventListener(ResourceEvent.RESOURCES_LOADED, onResourceLoaded);
			CGraphicPool.getInstance().init();
		}
		
		public function rebuildScene(): void
		{
			_scene = CApolloScene.getInstance();
			_scene.addEventListener(SceneEvent.SCENE_READY, onSceneReady);
			_scene.initMap(_mapId);
		}
		
		protected function onSceneReady(event: SceneEvent): void
		{
			_scene.removeEventListener(SceneEvent.SCENE_READY, onSceneReady);
			_data = null;
			_camera = new CCamera(_scene);
			
			if (!_isChangingMap)
			{
				var centerPos: Point = new Point();
				centerPos.x = parseInt(_scene.map.mapXMLData.startTileX);
				centerPos.y = parseInt(_scene.map.mapXMLData.startTileY);
				var centerMapPos: Point = CWorldMap.blockToMapPosition(centerPos);
				_player_startX = centerMapPos.x;
				_player_startY = centerMapPos.y;
			}
			else
			{
				_isChangingMap = false;
			}
			
			//initialPlayer();
			//createOhterPlayer();
			//createMonster();
			
			/**
			 * 开始运行游戏
			 */
			startGame();
		}
		
		protected function onResourceLoaded(event: ResourceEvent): void
		{
			var target: CGraphicPool = event.target as CGraphicPool;
			GlobalContextConfig.ResourcePool = target;
			
			initCenter();
			
			_scene = CApolloScene.getInstance();
			_scene.addEventListener(SceneEvent.SCENE_READY, onSceneReady);
			_scene.initMap(_mapId);
		}
		
		private function initCenter(): void
		{
			CBuildingCenter.getInstance();
			CResourceCenter.getInstance();
			
			CONFIG::DebugMode
			{
				var resource: CResourceParameter = new CResourceParameter(0xFF01, "水晶", 2000, 90);
				CResourceCenter.getInstance().registerResource(0xFF01, resource, 10000);
				var resource1: CResourceParameter = new CResourceParameter(0xFF01, "光明", 1000, 30);
				CResourceCenter.getInstance().registerResource(0xFF02, resource1, 5000);
			}
		}
		
		public function get camera(): CCamera
		{
			return _camera;
		}
		
		public function get ctrlCenter(): CControllerCenter
		{
			return _scene.ctrlCenter;
		}
		
		public function clear(): void
		{
			stopGame();
			
			var timer: Timer = new Timer(500);
			timer.addEventListener(TimerEvent.TIMER, autoClearNext);
			timer.start();
		}
		
		protected function autoClearNext(event: TimerEvent): void
		{
			var timer: Timer = event.target as Timer;
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, autoClearNext);
			timer = null;
			
			CApolloScene.terminateInstance();
			
			if (reconfigMapData != null)
			{
				reconfigMapData();
				reconfigMapData = null;
			}
		}
		
		public function startGame(): void
		{
			_scene.showMap();
			//var blackScreen: CBlackScreen = new CBlackScreen(CEaseType.None, 5000, 0);
			//stage.addChild(blackScreen);
			if (hasEventListener(Event.ENTER_FRAME))
			{
				return;
			}
			addEventListener(Event.ENTER_FRAME, render);
			if (_scene.player != null)
			{
				_scene.player.controller.setupListener();
			}
			dispatchEvent(new GameEvent(GameEvent.GAME_START));
		}
		
		public function stopGame(): void
		{
			removeEventListener(Event.ENTER_FRAME, render);
			if (_scene.player != null)
			{
				_scene.player.controller.removeListener();
			}
		}
		
		protected function render(event: Event): void
		{
			GlobalContextConfig.Timer = getTimer();
			
			CResourceCenter.getInstance().calcResource();
			if (_scene.isReady)
			{
				_scene.render();
				for each (var o: CGameObject in _scene.getAllObjects())
				{
					if (o.controller != null)
					{
						o.controller.calcAction();
					}
				}
			}
		}
	}

}