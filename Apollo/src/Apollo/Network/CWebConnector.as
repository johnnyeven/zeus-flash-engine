package Apollo.Network 
{
	import Apollo.Configuration.ConnectorContextConfig;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class CWebConnector implements IEventDispatcher 
	{
		private var coreLoader: URLLoader;
		private var eventDispatcher: EventDispatcher;
		protected var callback: Function;
		protected static var instance: CWebConnector;
		protected static var allowInstance: Boolean = false;
		
		public function CWebConnector() 
		{
			if (!allowInstance)
			{
				throw new IllegalOperationError("CWebConnector不允许实例化");
			}
			eventDispatcher = new EventDispatcher(this);
			coreLoader = new URLLoader();
			coreLoader.dataFormat = URLLoaderDataFormat.TEXT;
			coreLoader.addEventListener(Event.COMPLETE, onDataCallback);
			coreLoader.addEventListener(Event.COMPLETE, loaderCompleteHandler, false, 0, true);
			coreLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true);
			coreLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false, 0, true);
			coreLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
		}
		
		private function ioErrorHandler(e:IOErrorEvent):void 
		{
			dispatchEvent(e);
		}
		
		private function securityErrorHandler(e:SecurityErrorEvent):void 
		{
			dispatchEvent(e);
		}
		
		private function httpStatusHandler(e:HTTPStatusEvent):void 
		{
			dispatchEvent(e);
		}
		
		private function loaderCompleteHandler(e:Event):void 
		{
			dispatchEvent(e);
		}
		
		public function addCallback(callback: Function): void
		{
			this.callback = callback;
		}
		
		protected function onDataCallback(evt: Event): void
		{
			var loader: URLLoader = evt.target as URLLoader;
			process(loader.data as String);
		}
		
		private function process(data: String): void
		{
			if (data)
			{
				try
				{
					var json: Object = JSON.parse(data);
					var flag: uint = parseInt(json.flag);
					if (callback != null)
					{
						callback(flag, json);
					}
				}
				catch (err: Error)
				{
					CONFIG::DebugMode
					{
						trace("Error: CWebConnector.as[93] JSON.parse error - error id: " + err.errorID + ", error message: " + err.message);
					}
				}
			}
			else
			{
				CONFIG::DebugMode
				{
					trace("Warning: URLLoader.data is empty");
				}
			}
		}
		
		public function send(url: String, variables: URLVariables): void
		{
			var path: String = ConnectorContextConfig.serverPath + url;
			var request: URLRequest = new URLRequest(path);
			if (variables != null)
			{
				request.data = variables;
				request.method = URLRequestMethod.POST;
				try
				{
					coreLoader.load(request);
				}
				catch (err: Error)
				{
					CONFIG::DebugMode
					{
						trace("Error: CWebConnector.as[122] URLLoader.load error - error id: " + err.errorID + ", error message: " + err.message);
					}
				}
			}
			else
			{
				CONFIG::DebugMode
				{
					trace("Warning: CWebConnector.as[130] URLVariables is empty");
				}
			}
		}
		
		public static function getInstance(): CWebConnector
		{
			if (instance == null)
			{
				allowInstance = true;
				instance = new CWebConnector();
				allowInstance = false;
			}
			return instance;
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