package Apollo.Center 
{
	import Apollo.Objects.Data.CBuildingParameter;
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
				throw new IllegalOperationError("CCommandCenter不允许实例化");
			}
			buildingList = new Dictionary();
		}
		
		/**
		 * 
		 * @param	flag 建筑ID
		 */
		public function getBuildingParameter(flag: int): CBuildingParameter
		{
			if (buildingList[flag] != null)
			{
				return buildingList[flag];
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