package apollo.network.command.receiving 
{
	import apollo.configuration.ConnectorContextConfig;
	import apollo.network.data.basic.CBuildingParameter;
	import apollo.network.data.CCollectionBuildingParameter;
	
	/**
	 * ...
	 * @author john
	 */
	public class Receive_Info_CameraView extends CNetPackageReceiving 
	{
		public var BuildingList: Vector.<CBuildingParameter>;
		
		public function Receive_Info_CameraView() 
		{
			super(ConnectorContextConfig.CONTROLLER_INFO, ConnectorContextConfig.ACTION_CAMERAVIEW_OBJECT_LIST);
		}
		
		override public function fill(data: Object): void 
		{
			super.fill(data);
			
			if (message == ConnectorContextConfig.ACK_CONFIRM)
			{
				BuildingList = new Vector.<CBuildingParameter>();
				for (var key: String in data.building_list)
				{
					if (data.building_list[key].building_type == "COLLECTION")
					{
						var parameter: CCollectionBuildingParameter = new CCollectionBuildingParameter();
					}
					parameter.fill(data.building_list[key]);
					BuildingList.push(parameter);
				}
			}
		}
	}
}