package Apollo.Center 
{
	import Apollo.Objects.Data.CResourceParameter;
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class CResourceCenter 
	{
		private var resourcesList: Dictionary;
		private var resourceMax: Array;
		private var resourceTrigger: Array;
		private static var instance: CResourceCenter;
		private static var allowInstance: Boolean = false;
		
		public function CResourceCenter() 
		{
			if (!allowInstance)
			{
				throw new IllegalOperationError("CCommandCenter不允许实例化");
			}
			resourcesList = new Dictionary();
			resourceMax = new Array();
			resourceTrigger = new Array();
		}
		
		public function registerResource(resourceId: uint, resourceParameter: CResourceParameter, resourceMax: uint = 10000): void
		{
			if (resourcesList[resourceId] == null)
			{
				resourcesList[resourceId] = resourceParameter;
				resourceMax[resourceId] = resourceMax;
				resourceTrigger[resourceId] = 0;
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
				resourceMax.splice(resourceId, 1);
				resourceTrigger.splice(resourceId, 1);
			}
		}
		
		public function modifyResource(resourceId: uint, amount: int): void
		{
			if (resourcesList[resourceId] != null)
			{
				var resource: CResourceParameter = resourcesList[resourceId] as CResourceParameter;
				if (resource.resourceAmount + amount >= resourceMax[resourceId]) {
					resource.resourceAmount = resourceMax[resourceId];
					resourcesList[resourceId] = resource;
					return;
				}
				resource.resourceAmount += amount;
				resourcesList[resourceId] = resource;
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