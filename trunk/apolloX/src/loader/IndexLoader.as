package loader
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import utils.language.LanguageManager;
	
	[SWF(width="1028", height="600", backgroundColor="0xFFFFFF",frameRate="30")]
	public class IndexLoader extends Sprite
	{
		private var msgText: TextField;
		
		public function IndexLoader()
		{
			LanguageManager.language = Capabilities.language;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			msgText = new TextField();
			msgText.text = "初始化Loader...";
			msgText.autoSize = TextFieldAutoSize.CENTER;
			msgText.width = 500;
			
			var txtFormat: TextFormat = new TextFormat(null, 14, 0x000000, true);
			msgText.defaultTextFormat = txtFormat;
			addChild(msgText);
			
			loadVersion();
		}
		
		private function loadVersion(): void
		{
			loaderMessage = "loading version xml...";
			
			var urlLoader: URLLoader = new URLLoader();
			var urlRequest: URLRequest = new URLRequest("config/" + LanguageManager.language + "/version.xml");
			urlLoader.addEventListener(Event.COMPLETE, onVersionLoaded);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onLoadIOError);
			
			urlLoader.load(urlRequest);
		}
		
		private function onVersionLoaded(evt: Event): void
		{
			loadLanguage();
		}
		
		private function loadLanguage(): void
		{
			loaderMessage = "loading language...";
			
			var urlLoader: URLLoader = new URLLoader();
			var urlRequest: URLRequest = new URLRequest("config/" + LanguageManager.language + "/language.xml");
			urlLoader.addEventListener(Event.COMPLETE, onLanguageLoaded);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onLoadIOError);
			
			urlLoader.load(urlRequest);
		}
		
		private function onLanguageLoaded(evt: Event): void
		{
			var _loader: URLLoader = evt.target as URLLoader;
			var _xml: XML = XML(_loader.data);
			LanguageManager.getInstance().init(_xml);
		}
		
		private function onLoadIOError(evt: IOErrorEvent): void
		{
			loaderMessage = evt.text;
		}
		
		private function center():void
		{
			var sw:Number = stage.stageWidth * 0.5;
			var sh:Number = stage.stageHeight * 0.5;
			
			if (msgText != null)
			{
				msgText.x = sw - msgText.width * 0.5;
				msgText.y = sh - msgText.height * 0.5;
			}
			/*
			if (_loaderBar)
			{
				var obj:DisplayObject = _loaderBar as DisplayObject;
				
				obj.x = sw - obj.width * 0.5;
				obj.y = sh - obj.height * 0.5;
			}
			*/
		}
		
		private function set loaderMessage(value: String):void
		{
			msgText.text = value;
			center();
		}
	}
}