package 
{
	import Apollo.Objects.CDirection;
	import Apollo.Scene.CApolloScene;
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import Apollo.CGame;
	import Apollo.Events.GameEvent;
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
				game.addEventListener(GameEvent.GAME_START, onGameStart);
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
		}
		
		private function onGameStart(evt: GameEvent):void
		{
			var parameter: Object = new Object();
			parameter.objectId = "adfasdfasdfasdf";
			parameter.speed = 7;
			parameter.playerName = "test";
			parameter.startX = 400;
			parameter.startY = 500;
			CApolloScene.getInstance().createRole("char1", CDirection.DOWN, parameter);
		}
		
		private function deactivate(e:Event):void 
		{
			// auto-close
			//NativeApplication.nativeApplication.exit();
		}
		
	}
	
}