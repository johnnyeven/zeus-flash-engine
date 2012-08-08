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
		private static var instance: CResourceCenter;
		private static var allowInstance: Boolean = false;
		
		public function CResourceCenter() 
		{
			if (!allowInstance)
			{
				throw new IllegalOperationError("CCommandCenter不允许实例化");
			}
			resourcesList = new Dictionary();
		}
		
		public function registerResource(resourceId: uint, resourceParameter: CResourceParameter): void
		{
			if (resourcesList[resourceId] == null)
			{
				resourcesList[resourceId] = resourceParameter;
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