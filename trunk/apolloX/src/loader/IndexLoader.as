package loader
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import utils.language.LanguageManager;
	
	import view.loader.LoaderProgressBarComponent;
	
	[SWF(width="1028", height="600", backgroundColor="0xFFFFFF",frameRate="30")]
	public class IndexLoader extends Sprite
	{
		private var _msgText: TextField;
		private var _progressBar: LoaderProgressBarComponent;
		
		public function IndexLoader()
		{
			LanguageManager.language = Capabilities.language;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_msgText = new TextField();
			_msgText.text = "初始化Loader...";
			_msgText.autoSize = TextFieldAutoSize.CENTER;
			_msgText.width = 500;
			
			var txtFormat: TextFormat = new TextFormat(null, 14, 0x000000, true);
			_msgText.defaultTextFormat = txtFormat;
			addChild(_msgText);
			
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
			
			loadLoaderProgressBar();
		}
		
		private function loadLoaderProgressBar(): void
		{
			loaderMessage = LanguageManager.getInstance().lang("load_loader_progress_ui");
			
			var _loader: Loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onProgressBarLoaded);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadIOError);
			
			var urlRequest: URLRequest = new URLRequest("resources/ui/loader/processBar.swf");
			var loaderContext: LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			_loader.load(urlRequest, loaderContext);
		}
		
		private function onProgressBarLoaded(evt: Event): void
		{
			_progressBar = new LoaderProgressBarComponent();
			addChild(_progressBar);
			removeChild(_msgText);
			_msgText = null;
			
			center();
			
			loadMain();
		}
		
		private function loadMain(): void
		{
			_progressBar.title = LanguageManager.getInstance().lang("load_main");
			_progressBar.percentage = 0;
		}
		
		private function onLoadIOError(evt: IOErrorEvent): void
		{
			loaderMessage = evt.text;
		}
		
		private function center():void
		{
			var sw:Number = stage.stageWidth * 0.5;
			var sh:Number = stage.stageHeight * 0.5;
			
			if (_msgText != null)
			{
				_msgText.x = sw - _msgText.width * 0.5;
				_msgText.y = sh - _msgText.height * 0.5;
			}
			
			if (_progressBar)
			{
				_progressBar.x = sw - _progressBar.width * 0.5;
				_progressBar.y = sh - _progressBar.height * 0.5;
			}
		}
		
		private function set loaderMessage(value: String):void
		{
			_msgText.text = value;
			center();
		}
	}
}