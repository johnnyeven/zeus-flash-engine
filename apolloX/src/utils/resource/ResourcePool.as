package utils.resource
{
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;

	public class ResourcePool
	{
		private static var _instance: ResourcePool;
		private static var _allowInstance: Boolean = false;
		private static var _pool: Dictionary;
		
		public function ResourcePool()
		{
			if(_allowInstance)
			{
				_pool = new Dictionary();
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
	}
}