package utils.loader
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	
	import utils.GUIDUtils;
	import utils.StringUtils;
	import utils.enum.LoaderStatus;
	
	public class ItemLoader extends EventDispatcher
	{
		public var name: String;
		public var url: String;
		public var version: String;
		public var isDispose: Boolean = false;
		public var loaderStatus: int = LoaderStatus.READY;
		protected var _urlRequest: URLRequest;
		
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
			
		}
		
		public function load(): void
		{
			loaderStatus = LoaderStatus.LOADING;
		}
	}
}