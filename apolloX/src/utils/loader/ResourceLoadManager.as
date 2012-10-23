package utils.loader
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;

	public class ResourceLoadManager
	{
		private static var _completeCallbackIndex: Dictionary = new Dictionary();
		private static var _errorCallbackIndex: Dictionary = new Dictionary();
		private static var _progressCallbackIndex: Dictionary = new Dictionary();
		
		public function ResourceLoadManager()
		{
		}
		
		public static function load(url: String, showLoaderBar: Boolean = false, title: String = "", completeCallback: Function = null, progressCallback: Function = null, errorCallback: Function = null): void
		{
			if(completeCallback != null)
			{
				if(_completeCallbackIndex[url] == null)
				{
					_completeCallbackIndex[url] = new Array();
				}
				_completeCallbackIndex[url].push(completeCallback);
			}
			if(progressCallback != null)
			{
				if(_progressCallbackIndex[url] == null)
				{
					_progressCallbackIndex[url] = new Array();
				}
				_progressCallbackIndex[url].push(progressCallback);
			}
			if(errorCallback != null)
			{
				if(_errorCallbackIndex[url] == null)
				{
					_errorCallbackIndex[url] = new Array();
				}
				_errorCallbackIndex[url].push(errorCallback);
			}
			var _loader: ItemLoader = LoaderPool.instance.initLoader(url);
			_loader.load();
		}
		
		private static function resetIndex(key: String): void
		{
			delete _completeCallbackIndex[key];
			delete _progressCallbackIndex[key];
			delete _errorCallbackIndex[key];
		}
		
		private static function onLoadCompelete(evt: Event): void
		{
			
		}
		
		private static function onLoadIOError(evt: IOErrorEvent): void
		{
			
		}
		
		private static function onLoadProgress(evt: ProgressEvent): void
		{
			
		}
	}
}