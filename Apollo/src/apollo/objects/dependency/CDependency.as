package apollo.objects.dependency 
{
	import apollo.center.CResourceCenter;
	import apollo.network.data.basic.CBuildingParameter;
	import apollo.network.data.CResourceParameter;
	
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class CDependency 
	{
		public var resource: Vector.<CResourceParameter>;
		public var building: Vector.<CBuildingParameter>;
		
		public function CDependency()
		{
			resource = new Vector.<CResourceParameter>();
			building = new Vector.<CBuildingParameter>();
		}
		
		public function isAvailable(): Boolean
		{
			for (var keyResource: String in resource)
			{
				var resourceId: uint = resource[keyResource].resourceId;
				var resourceList: Dictionary = CResourceCenter.getInstance().getResourceList();
				if (resourceList[resourceId] != null)
				{
					if (resource[keyResource].resourceAmount > (resourceList[resourceId] as CResourceParameter).resourceAmount)
					{
						return false;
					}
				}
				else
				{
					return false;
				}
			}
			
			return true;
		}
	}

}