package apollo.graphics 
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
	
	import apollo.events.MapEvent;
	import apollo.configuration.*;
	import apollo.utils.loader.CClassLoader;
	import apollo.events.ResourceEvent;
	import apollo.utils.Conversion;
	
	/**
	 * ...
	 * @author john
	 */
	public class CGraphicPool implements IEventDispatcher 
	{
		private static var instance: CGraphicPool;
		private static var allowInstance: Boolean = false;
		private var eventDispatcher: EventDispatcher;
		private var graphicPool: IGraphicPool;
		
		public function CGraphicPool() 
		{
			if (!allowInstance)
			{
				throw new IllegalOperationError("CGraphicPool类不允许实例化");
				return;
			}
			eventDispatcher = new EventDispatcher(this);
			if (GlobalContextConfig.platform == WoohaPlatform.PLATFORM_IOS)
			{
				graphicPool = CGraphicPoolEmbed.getInstance();
			}
			else
			{
				graphicPool = CGraphicPoolV3.getInstance();
			}
		}
		
		public static function getInstance(): CGraphicPool
		{
			if (instance == null)
			{
				allowInstance = true;
				instance = new CGraphicPool();
				allowInstance = false;
			}
			return instance;
		}
		
		public function init(): void
		{
			//加载资源列表
			graphicPool.addEventListener(ResourceEvent.RESOURCES_LOADED, onResourceLoaded);
			graphicPool.init();
		}
		
		private function onResourceLoaded(event: ResourceEvent): void
		{
			event.stopImmediatePropagation();
			event = null;
			graphicPool.removeEventListener(ResourceEvent.RESOURCES_LOADED, onResourceLoaded);
			dispatchEvent(new ResourceEvent(ResourceEvent.RESOURCES_LOADED));
		}
		
		public function addResource(resourceId: String, content: BitmapData): void
		{
			graphicPool.addResource(resourceId, content);
		}
		
		public function getResource(domainId: String, resourceId: String): BitmapData
		{
			return graphicPool.getResource(domainId, resourceId);
		}
		
		public function getCharacter(resourceId: String): BitmapData
		{
			return graphicPool.getCharacter(resourceId);
		}
		
		public function getBuilding(resourceId: String): BitmapData
		{
			return graphicPool.getBuilding(resourceId);
		}
		
		public function getFont(resourceId: String): Font
		{
			return graphicPool.getFont(resourceId);
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