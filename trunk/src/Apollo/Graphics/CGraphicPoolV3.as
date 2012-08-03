package Apollo.Graphics 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.errors.IllegalOperationError;
	import flash.events.*;
	import flash.system.ApplicationDomain;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.text.Font;
	
	import Apollo.Events.MapEvent;
	import Apollo.Configuration.*;
	import Apollo.utils.Loader.CClassLoader;
	import Apollo.Events.ResourceEvent;
	import Apollo.utils.Conversion;
	
	/**
	 * ...
	 * @author john
	 */
	public class CGraphicPoolV3 implements IGraphicPool 
	{
		private static var instance: CGraphicPoolV3;
		private static var allowInstance: Boolean = false;
		private var eventDispatcher: EventDispatcher;
		protected var _loader: CClassLoader;
		
		/**
		 * 资源池
		 */
		protected var _pool: Dictionary;
		/**
		 * 资源列表
		 */
		protected var _resourceList: Dictionary;
		/**
		 * 待加载的资源
		 */
		protected var _prepareToLoad: Object;
		/**
		 * 待加载的资源标识
		 */
		private var _prepareName: Array;
		
		public function CGraphicPoolV3() 
		{
			if (!allowInstance)
			{
				throw new IllegalOperationError("CGraphicPool类不允许实例化");
				return;
			}
			eventDispatcher = new EventDispatcher(this);
			_loader = new CClassLoader();
			_prepareToLoad = new Object();
			_prepareName = new Array();
			_resourceList = new Dictionary();
			_pool = new Dictionary();
		}
		
		public static function getInstance(): CGraphicPoolV3
		{
			if (instance == null)
			{
				allowInstance = true;
				instance = new CGraphicPoolV3();
				allowInstance = false;
			}
			return instance;
		}
		
		public function init(): void
		{
			//加载资源列表
			var resourceListLoader: URLLoader = new URLLoader();
			resourceListLoader.addEventListener(IOErrorEvent.IO_ERROR, onResourceListIOError);
			resourceListLoader.addEventListener(Event.COMPLETE, onResourceListLoaded);
			resourceListLoader.load(new URLRequest(SocketContextConfig.resource_server_ip + GlobalContextConfig.CONFIG_PATH + "resources.xml"));
		}
		
		private function onResourceListIOError(event: IOErrorEvent): void
		{
			trace(event.text);
		}
		
		private function onResourceListLoaded(event: Event): void
		{
			var loader: URLLoader = event.target as URLLoader;
			var xmlData: XML = new XML();
			xmlData.ignoreComments = true;
			xmlData = XML(loader.data);
			
			for (var i:int = 0; i < xmlData.resource.length(); i++)
			{
				if (xmlData.resource[i].name == "character")
				{
					_prepareToLoad[xmlData.resource[i].name] = SocketContextConfig.resource_server_ip + GlobalContextConfig.CHAR_RES_PATH + xmlData.resource[i].url;
				}
				else if (xmlData.resource[i].name == "font")
				{
					_prepareToLoad[xmlData.resource[i].name] = SocketContextConfig.resource_server_ip + GlobalContextConfig.RESOURCE_PATH + xmlData.resource[i].url;
				}
				_prepareName.push(xmlData.resource[i].name);
			}
			
			startLoadResources();
		}
		
		protected function startLoadResources(): void
		{
			if (_prepareName.length > 0 && _prepareToLoad != null)
			{
				_loader.addEventListener(Event.COMPLETE, onResourceLoaded);
				_loader.name = _prepareName[0];
				_loader.load(_prepareToLoad[_loader.name]);
				
				_prepareName.splice(0, 1);
				_prepareToLoad[_loader.name] = null;
			}
		}
		
		private function onResourceLoaded(event: Event): void
		{
			_loader.removeEventListener(Event.COMPLETE, onResourceLoaded);
			_resourceList[_loader.name] = _loader.getApplicationDomain();
			
			if (_prepareName.length > 0 && _prepareToLoad != null)
			{
				startLoadResources();
			}
			else
			{
				eventDispatcher.dispatchEvent(new ResourceEvent(ResourceEvent.RESOURCES_LOADED));
			}
		}
		
		public function addResource(resourceId: String, content: BitmapData): void
		{
			if (_pool[resourceId] == null)
			{
				_pool[resourceId] = content;
			}
		}
		
		public function getResource(domainId: String, resourceId: String): BitmapData
		{
			if (domainId == "character")
			{
				return getCharacter(resourceId);
			}
			else
			{
				return _pool[resourceId];
			}
		}
		
		public function getCharacter(resourceId: String): BitmapData
		{
			if (_pool[resourceId] == null)
			{
				var _class: Class = _resourceList["character"].getDefinition("wooha.resources.character." + resourceId) as Class;
				var _display: BitmapData = Conversion.Bitmap(_class);
				_pool[resourceId] = _display;
			}
			return _pool[resourceId];
		}
		
		public function getFont(resourceId: String): Font
		{
			if (_pool[resourceId] == null)
			{
				var _class: Class = _resourceList["font"].getDefinition("wooha.resources.font." + resourceId) as Class;
				Font.registerFont(_class);
				var _font: Font = new _class() as Font;
				_pool[resourceId] = _font;
			}
			return _pool[resourceId];
		}
		
		/* INTERFACE flash.events.IEventDispatcher */
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean 
		{
			return eventDispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean 
		{
			return eventDispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean 
		{
			return eventDispatcher.willTrigger(type);
		}
		
	}

}