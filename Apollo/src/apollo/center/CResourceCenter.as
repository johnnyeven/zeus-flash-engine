package apollo.center 
{
	import apollo.configuration.GlobalContextConfig;
	import apollo.network.data.CResourceParameter;
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class CResourceCenter 
	{
		private var resourcesList: Dictionary;
		private var resourceMax: Dictionary;
		private var startTime: int;
		private var resourceUpdateTime: uint;
		private var resourcePerUpdateTime: Number;
		private static var instance: CResourceCenter;
		private static var allowInstance: Boolean = false;
		
		public function CResourceCenter() 
		{
			if (!allowInstance)
			{
				throw new IllegalOperationError("CCommandCenter不允许实例化");
			}
			resourcesList = new Dictionary();
			resourceMax = new Dictionary();
			startTime = GlobalContextConfig.Timer;
			resourceUpdateTime = 30;
			resourcePerUpdateTime = resourceUpdateTime / GlobalContextConfig.resourceDelay;
		}
		
		public function registerResource(resourceId: uint, resourceParameter: CResourceParameter, _resourceMax: uint = 10000): void
		{
			if (resourcesList[resourceId] == null)
			{
				resourcesList[resourceId] = resourceParameter;
				resourceMax[resourceId] = _resourceMax;
			}
			else
			{
				CONFIG::DebugMode {
					trace('Resource Id Duplicated: ' + resourceId);
				}
			}
		}
		
		public function removeResource(resourceId: uint): void
		{
			if (resourcesList[resourceId] != null)
			{
				resourcesList[resourceId] = null;
				delete resourcesList[resourceId];
				resourceMax[resourceId] = null;
				delete resourceMax[resourceId];
			}
		}
		
		public function modifyResource(resourceId: uint, amount: int): void
		{
			if (resourcesList[resourceId] != null)
			{
				var resource: CResourceParameter = resourcesList[resourceId] as CResourceParameter;
				resource.resourceModified += amount;
				resourcesList[resourceId] = resource;
			}
		}
		
		public function getResourceList(): Dictionary
		{
			return resourcesList;
		}
		
		public function calcResource(): void
		{
			var timer: int = GlobalContextConfig.Timer - startTime;
			if (timer >= resourceUpdateTime * 1000)
			{
				//更新资源
				for (var key: Object in resourcesList)
				{
					var resource: CResourceParameter = resourcesList[key] as CResourceParameter;
					var modified: Number = resource.resourceModified * resourcePerUpdateTime;
					if ((resource.resourceAmount + modified) < 0)
					{
						resource.resourceAmount = 0;
					}
					else if (resource.resourceAmount + modified > resourceMax[key as uint])
					{
						resource.resourceAmount = resourceMax[key as uint];
					}
					else
					{
						resource.resourceAmount += modified;
					}
					resourcesList[key] = resource;
				}
				startTime = GlobalContextConfig.Timer;
			}
		}
		
		public static function getInstance(): CResourceCenter
		{
			if (instance == null)
			{
				allowInstance = true;
				instance = new CResourceCenter();
				allowInstance = false;
			}
			return instance;
		}
		
	}

}