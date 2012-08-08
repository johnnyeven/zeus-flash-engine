package Apollo.Objects.Data 
{
	import Apollo.Objects.dependency.CDependency;
	
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class CBuildingParameter 
	{
		private var buildingId: uint;
		private var buildingName: String;
		private var level: uint;
		/**
		 * 消耗的资源
		 */
		private var consumeList: Array;
		/**
		 * 产出的资源
		 */
		private var produceList: Array;
		private var dependency: CDependency;
		
		public function CBuildingParameter() 
		{
			consumeList = new Array();
			produceList = new Array();
		}
		
	}

}