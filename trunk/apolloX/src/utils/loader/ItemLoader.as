package utils.loader
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import utils.GUIDUtils;
	import utils.RequestUtils;
	import utils.StringUtils;
	import utils.enum.LoaderStatus;
	
	public class ItemLoader extends EventDispatcher
	{
		public var name: String;
		public var url: String;
		public var version: String;
		public var isDispose: Boolean = false;
		public var loaderStatus: int = LoaderStatus.READY;
		protected var _contentLoaded: Object;
		protected var _urlRequest: URLRequest;
		protected var _bytesTotal: uint;
		protected var _bytesLoaded: uint;
		
		public function ItemLoader(url: String = "", name: String = "", loaderConfig: XML = null)
		{
			super(this);
			if(loaderConfig == null)
			{
				this.url = url;
				if(StringUtils.empty(name))
				{
					this.name = GUIDUtils.create();
				}
				else
				{
					this.name = name;
				}
			}
			else
			{
				
			}
			init();
		}
		
		protected function init(): void
		{
			_urlRequest = RequestUtils.getRequestByVersion(url, version);
		}
		
		public function dispose(): void
		{
			if(isDispose)
			{
				return;
			}
			isDispose = true;
			_contentLoaded = null;
			_urlRequest = null;
		}
		
		public function load(): void
		{
			loaderStatus = LoaderStatus.LOADING;
		}
		
		protected function onLoadComplete(evt: Event): void
		{
			loaderStatus = LoaderStatus.COMPLETE;
		}
		
		protected function onLoadProgress(evt: ProgressEvent): void
		{
			_bytesLoaded = evt.bytesLoaded;
			_bytesTotal = evt.bytesTotal;
		}
		
		protected function onLoadIOError(evt: IOErrorEvent): void
		{
			loaderStatus = LoaderStatus.ERROR;
		}

		public function get bytesLoaded():uint
		{
			return _bytesLoaded;
		}

		public function get bytesTotal():uint
		{
			return _bytesTotal;
		}

		public function get contentLoaded():Object
		{
			return _contentLoaded;
		}

	}
}