package Apollo.Center 
{
	import Apollo.Network.Data.CBuildingParameter;
	import Apollo.Objects.CBuildingObject;
	import Apollo.Scene.CApolloScene;
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
		
		public function createBuilding(buildingParameter: CBuildingParameter): CBuildingObject
		{
			var building: CBuildingObject = CApolloScene.getInstance().createBuilding(buildingParameter);
			registerBuilding(building);
			return building;
		}
		
		public function registerBuilding(building: CBuildingObject): void
		{
			buildingList[building.objectId] = building;
		}
		
		/**
		 * 
		 * @param	flag 建筑GUID
		 */
		public function getBuilding(flag: String): CBuildingObject
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