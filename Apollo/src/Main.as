package 
{
	import Apollo.Center.CBuildingCenter;
	import Apollo.Network.Data.CBuildingParameter;
	import Apollo.Network.CWebConnector;
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import Apollo.CGame;
	import Apollo.Events.GameEvent;
	import Apollo.Objects.CDirection;
	import Apollo.Scene.CApolloScene;
	import Apollo.utils.Monitor.CMonitorFPS;
	import Apollo.Network.Data.CRoleParameter;
	import Apollo.utils.Monitor.CMonitorResource;
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// entry point
			try
			{
				var game: CGame = CGame.getInstance();
				//game.addEventListener(GameEvent.GAME_START, onGameStart);
				addChild(game);
			}
			catch (err: Error)
			{
				var txt: TextField = new TextField();
				txt.textColor = 0xFFFFFF;
				txt.autoSize = TextFieldAutoSize.LEFT;
				txt.text = err.message;
				txt.x = (stage.stageWidth - txt.width) / 2;
				txt.y = (stage.stageHeight - txt.height) / 2;
				var format: TextFormat = new TextFormat();
				format.size = 30;
				txt.setTextFormat(format);
				addChild(txt);
			}
			CONFIG::DebugMode {
				var line: Sprite = new Sprite();
				line.graphics.lineStyle(2, 0xff0000);
				line.graphics.drawRect(0, 0, 960, 640);
				addChild(line);
				
				var fpsMonitor: CMonitorFPS = new CMonitorFPS();
				addChild(fpsMonitor);
				
				var resourceMonitor: CMonitorResource = new CMonitorResource();
				addChild(resourceMonitor);
			}
		}
		
		private function onGameStart(evt: GameEvent):void
		{
			var parameter: CRoleParameter = new CRoleParameter();
			parameter.objectId = "adfasdfasdfasdf";
			parameter.speed = 7;
			parameter.playerName = "test";
			parameter.startX = 400;
			parameter.startY = 500;
			CApolloScene.getInstance().createRole("char1", CDirection.DOWN, parameter);
			
			createBuilding();
		}
		
		private function createBuilding(): void
		{
			var url: String = "http://localhost:8080/getbuilding.php";
			var request: URLRequest = new URLRequest(url);
			var loader: URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.load(request);
		}
		
		private function onLoadComplete(evt: Event): void
		{
			var loader: URLLoader = evt.target as URLLoader;
			var json: Object = JSON.parse(loader.data);
			var buildingParameter: CBuildingParameter = new CBuildingParameter();
			buildingParameter.fill(json);
			CApolloScene.getInstance().createBuilding(buildingParameter);
		}
		
		private function deactivate(e:Event):void 
		{
			// auto-close
			//NativeApplication.nativeApplication.exit();
		}
		
	}
	
}