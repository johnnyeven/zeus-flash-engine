package Apollo.Center 
{
	import Apollo.Objects.CBuildingObject;
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class CBuildingCenter
	{
		private var buildingList: Dictionary;
		private static var instance: CBuildingCenter;
		private static var allowInstance: Boolean = false;
		
		public function CBuildingCenter() 
		{
			if (!allowInstance)
			{
				throw new IllegalOperationError("CBuildingCenter不允许实例化");
			}
			buildingList = new Dictionary();
		}
		
		public function registerBuilding(buildingId: uint, buildingParameter: CBuildingObject): void
		{
			
		}
		
		/**
		 * 
		 * @param	flag 建筑ID
		 */
		public function getBuilding(flag: uint): CBuildingObject
		{
			if (buildingList[flag] != null)
			{
				return buildingList[flag] as CBuildingObject;
			}
			return null;
		}
		
		public static function getInstance(): CBuildingCenter
		{
			if (instance == null)
			{
				allowInstance = true;
				instance = new CBuildingCenter();
				allowInstance = false;
			}
			return instance;
		}
	}

}