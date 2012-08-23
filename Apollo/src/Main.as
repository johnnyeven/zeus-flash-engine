package 
{
	import apollo.center.CBuildingCenter;
	import apollo.center.CCommandCenter;
	import apollo.configuration.CharacterData;
	import apollo.configuration.GlobalContextConfig;
	import apollo.events.NetworkEvent;
	import apollo.events.ResourceEvent;
	import apollo.graphics.CGraphicPool;
	import apollo.network.command.receiving.Receive_Info_RequestAccountId;
	import apollo.network.command.sending.Send_Info_Login;
	import apollo.network.command.sending.Send_Info_RequestAccountId;
	import apollo.network.CWebConnector;
	import apollo.network.processor.CLoginProcessor;
	import apollo.network.processor.CProcessorRouter;
	import apollo.utils.monitor.CMonitorConsole;
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import org.aswing.event.AWEvent;
	
	import apollo.CGame;
	import apollo.events.GameEvent;
	import apollo.objects.CDirection;
	import apollo.scene.CApolloScene;
	import apollo.utils.monitor.CMonitorFPS;
	import apollo.network.data.CRoleParameter;
	import apollo.utils.monitor.CMonitorResource;
	
	import apollo.ui.*;
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
			
			CGraphicPool.getInstance().addEventListener(ResourceEvent.RESOURCES_LOADED, onResourceLoaded);
			CGraphicPool.getInstance().init();
		}
		
		private function onResourceLoaded(event: ResourceEvent): void
		{
			var target: CGraphicPool = event.target as CGraphicPool;
			GlobalContextConfig.ResourcePool = target;
			
			var login: UILogin = CGraphicPool.getInstance().getUI("UILogin") as UILogin;
			login.setBtnStartListener(start);
			addChild(login);
		}
		
		private function start(evt: AWEvent): void
		{
			addChild(CMonitorConsole.getInstance());
			var processorRouter: CProcessorRouter = CProcessorRouter.getInstance();
			processorRouter.add(new CLoginProcessor());
			
			var loginProtocol: Send_Info_Login = new Send_Info_Login();
			loginProtocol.UserName = "johnnyeven";
			loginProtocol.UserPass = "19871113";
			CCommandCenter.getInstance().send(loginProtocol);
			CCommandCenter.getInstance().addEventListener(NetworkEvent.LOGIN_SUCCESS, onLoginSuccess);
		}
		
		private function onLoginSuccess(evt: NetworkEvent): void
		{
			var requestCharacterProtocol: Send_Info_RequestAccountId = new Send_Info_RequestAccountId();
			requestCharacterProtocol.GUID = CharacterData.Guid;
			CCommandCenter.getInstance().send(requestCharacterProtocol);
			CCommandCenter.getInstance().addEventListener(NetworkEvent.REQUEST_CHARACTER, onCharacterData);
		}
		
		private function onCharacterData(evt: NetworkEvent): void
		{
			var protocol: Receive_Info_RequestAccountId = evt.data as Receive_Info_RequestAccountId;
			CharacterData.AccountId = protocol.AccountId;
			CharacterData.UserName = protocol.NickName;
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
		
		private function deactivate(e:Event):void 
		{
			// auto-close
			//NativeApplication.nativeApplication.exit();
		}
		
	}
	
}