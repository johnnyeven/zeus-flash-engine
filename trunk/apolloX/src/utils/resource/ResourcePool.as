package utils.resource
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import utils.StringUtils;

	public class ResourcePool
	{
		private static var _instance: ResourcePool;
		private static var _allowInstance: Boolean = false;
		private static var _pool: Dictionary;
		private static var _resourceLoadedIndex: Dictionary;
		
		public function ResourcePool()
		{
			if(_allowInstance)
			{
				_pool = new Dictionary();
				_resourceLoadedIndex = new Dictionary();
			}
			else
			{
				throw new IllegalOperationError("You cant get instance trough constructor.");
			}
		}
		
		public static function get instance(): ResourcePool
		{
			if(_instance == null)
			{
				_allowInstance = true;
				_instance = new ResourcePool();
				_allowInstance = false;
			}
			return _instance;
		}
		
		public static function getResource(className: String): DisplayObject
		{
			var _resource: DisplayObject = getResourceFromPool(className);
			if(_resource == null)
			{
				try
				{
					var _class: Class = getDefinitionByName(className) as Class;
					_resource = new _class();
					if(_resource is BitmapData)
					{
						_resource = new Bitmap(_resource as BitmapData);
					}
				}
				catch(err: Error)
				{
					
				}
			}
			return _resource;
		}
		
		public static function getResourceByLoader(url: String, className: String, callback: Function = null): DisplayObject
		{
			var _resource: DisplayObject = getResourceFromPool(className);
			if(_resource == null)
			{
				if(StringUtils.empty(url))
				{
					return null;
				}
			}
			return _resource;
		}
		
		private static function getResourceFromPool(key: String): DisplayObject
		{
			if(_pool[key] != null)
			{
				return _pool[key] as DisplayObject;
			}
			return null;
		}
	}
}