package
{
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.RequestUtil;
    import com.zn.utils.VersionUtils;
    
    import flash.display.DisplayObject;
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.system.ApplicationDomain;
    import flash.system.Capabilities;
    import flash.system.LoaderContext;
    import flash.text.Font;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    
    import view.loader.IndexLoaderBarComponent;


    [SWF(width = "1067", height = "600", backgroundColor = "0x000000", frameRate = "15")]
    public class index extends Sprite
    {
        public static var version:String = "";

        private var _loaderBar:IndexLoaderBarComponent;

        private var _tf:TextField;

        private var main:DisplayObject;

        public var loaderBG:Loader;

        private var bgUrl:String;

        public function index()
        {
//            MultilanguageManager.language = Capabilities.language;
			MultilanguageManager.language="zh_CN";

            _tf = new TextField();
            _tf.width = 300;
            _tf.autoSize = TextFieldAutoSize.CENTER;
			
			var textFormat:TextFormat=_tf.defaultTextFormat;
			textFormat.color=0xFFFFFF;
			_tf.defaultTextFormat=textFormat;
			
            addChild(_tf);

            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.addEventListener(Event.RESIZE, stageResizeHandler);

            loaderBG = new Loader();
            loaderBG.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, bgIoErrorHandler);
            addChildAt(loaderBG, 0);

            var index:int = Math.random() * 10 + 1;
            bgUrl = MultilanguageManager.language + "/images/loaderBG/bg_" + index + ".jpg";
            var urlRequest:URLRequest = new URLRequest(bgUrl);
            RequestUtil.setRequestURL(urlRequest, bgUrl, "version=" + VersionUtils.getVersion("indexLoader"));
            loaderBG.load(urlRequest);

            loadVersion();
        }

        protected function bgIoErrorHandler(event:IOErrorEvent):void
        {
            trace("index", "ioErrorHandler", "背景加载错误:" + bgUrl);
        }

        private function loadVersion():void
        {
            tfText = "load version file.";

            var urlLoader:URLLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE, function(event:Event):void
            {
                var rootXML:XML = XML(urlLoader.data);
                RequestUtil.version = version = rootXML.version;
                VersionUtils.initVersionFile(rootXML);

                loaderLanguageResouce();
            });

            urlLoader.addEventListener(IOErrorEvent.IO_ERROR, function(event:Event):void
            {
                tfText = "load version file error.";
            });

            var url:String = "config/" + MultilanguageManager.language + "/version.xml";
            var urlRequest:URLRequest = new URLRequest(url);
            var time:Number = new Date().time;
            RequestUtil.setRequestURL(urlRequest, url, "time=" + time);

            urlLoader.load(urlRequest);
        }

        private function loaderLanguageResouce():void
        {
            tfText = "load language file.";

            var urlLoader:URLLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE, function(event:Event):void
            {
                var rootXML:XML = XML(urlLoader.data);
                MultilanguageManager.initConfig(rootXML);

                loaderIndex();
            });

            urlLoader.addEventListener(IOErrorEvent.IO_ERROR, function(event:Event):void
            {
                tfText = "load language file error.";
            });

            var url:String = "config/" + MultilanguageManager.language + "/languageResouce.xml";
            var urlRequest:URLRequest = new URLRequest(url);
            RequestUtil.setRequestURL(urlRequest, url, "version=" + VersionUtils.getVersion("languageResouce"));

            urlLoader.load(urlRequest);
        }

        private function loaderIndex():void
        {
            tfText = "load indexLoader file.";
            var _loader:Loader = new Loader();
            _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(event:Event):void
            {
                _loaderBar = new IndexLoaderBarComponent();
                _loaderBar.percent = 0;
                addChild(_loaderBar as DisplayObject);

                removeChild(_tf);
                center();

				loaderFont();
            });

            _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(event:Event):void
            {
                tfText = "load indexLoader file error.";
            });

            var url:String = MultilanguageManager.language + "/indexLoader.swf";
            var urlRequest:URLRequest = new URLRequest(url);
            RequestUtil.setRequestURL(urlRequest, url, "version=" + VersionUtils.getVersion("indexLoader"));
            var loaderContext:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
            _loader.load(urlRequest, loaderContext);
        }

		private function loaderFont():void
		{
			_loaderBar.titleInfo = MultilanguageManager.getString("loadFont");
			
			var _loader:Loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(event:Event):void
			{
				var yaHeiClass:Class =Class(ApplicationDomain.currentDomain.getDefinition("Font_YaHei"));
				if (yaHeiClass)
					Font.registerFont(yaHeiClass);
				
				loaderMain();
			});
			
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(event:Event):void
			{
				_loaderBar.titleInfo = MultilanguageManager.getString("loadFontError");
			});
			
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, function(event:ProgressEvent):void
			{
				var percent:Number = event.bytesLoaded / event.bytesTotal;
				_loaderBar.percent = percent;
			});
			
			var url:String = "font/font_yaHei.swf";
			var urlRequest:URLRequest = new URLRequest(url);
			RequestUtil.setRequestURL(urlRequest, url, "version=" + VersionUtils.getVersion("font"));
			var loaderContext:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			_loader.load(urlRequest, loaderContext);
		}
		
        private function loaderMain():void
        {
            _loaderBar.titleInfo = MultilanguageManager.getString("loadMain");

            var _loader:Loader = new Loader();
            _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(event:Event):void
            {
                main = _loader.contentLoaderInfo.content as DisplayObject;
                loaderBaseUI();
            });

            _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(event:Event):void
            {
                _loaderBar.titleInfo = MultilanguageManager.getString("loadMainError");
            });

            _loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, function(event:ProgressEvent):void
            {
                var percent:Number = event.bytesLoaded / event.bytesTotal;
                _loaderBar.percent = percent;
            });

            var url:String = "Main.swf";
            var urlRequest:URLRequest = new URLRequest(url);
            RequestUtil.setRequestURL(urlRequest, url, "version=" + VersionUtils.getVersion("Main"));
            var loaderContext:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
            _loader.load(urlRequest, loaderContext);
        }

        private function loaderBaseUI():void
        {
            _loaderBar.titleInfo = MultilanguageManager.getString("loadBaseUI");

            var _loader:Loader = new Loader();
            _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(event:Event):void
            {
				loaderResUI();
            });

            _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(event:Event):void
            {
                _loaderBar.titleInfo = MultilanguageManager.getString("loadBaseUIError");
            });

            _loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, function(event:ProgressEvent):void
            {
                var percent:Number = event.bytesLoaded / event.bytesTotal;
                _loaderBar.percent = percent;
            });

            var url:String = MultilanguageManager.language + "/baseUI.swf";
            var urlRequest:URLRequest = new URLRequest(url);
            RequestUtil.setRequestURL(urlRequest, url, "version=" + VersionUtils.getVersion("baseUI"));
            var loaderContext:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
            _loader.load(urlRequest, loaderContext);
        }

        private function loaderResUI():void
        {
            _loaderBar.titleInfo = MultilanguageManager.getString("loadResUI");

            var _loader:Loader = new Loader();
            _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(event:Event):void
            {
                removeChild(_loaderBar as DisplayObject);
                _loaderBar = null;
                _loader = null;

                addChild(main);
                main["start"]();
            });

            _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(event:Event):void
            {
                _loaderBar.titleInfo = MultilanguageManager.getString("loadResUIError");
            });

            _loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, function(event:ProgressEvent):void
            {
                var percent:Number = event.bytesLoaded / event.bytesTotal;
                _loaderBar.percent = percent;
            });

            var url:String = MultilanguageManager.language + "/res.swf";
            var urlRequest:URLRequest = new URLRequest(url);
            RequestUtil.setRequestURL(urlRequest, url, "version=" + VersionUtils.getVersion("res"));
            var loaderContext:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
            _loader.load(urlRequest, loaderContext);
        }

        protected function stageResizeHandler(event:Event):void
        {
            center();
        }

        private function center():void
        {
            var sw:Number = stage.stageWidth * 0.5;
            var sh:Number = stage.stageHeight * 0.5;

            if (_tf)
            {
                _tf.x = sw - _tf.width * 0.5;
                _tf.y = sh - _tf.height * 0.5;
            }

            if (_loaderBar)
            {
                var obj:DisplayObject = _loaderBar as DisplayObject;

                obj.x = sw - obj.width * 0.5;
                obj.y = sh - obj.height * 0.5;
            }
        }

        private function set tfText(str:String):void
        {
            _tf.text = str;
            center();
        }
    }
}
