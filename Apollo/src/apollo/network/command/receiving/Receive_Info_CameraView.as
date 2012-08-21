package apollo.network.command.receiving 
{
	import apollo.configuration.ConnectorContextConfig;
	import apollo.network.data.CBuildingParameter;
	
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
					var parameter: CBuildingParameter = new CBuildingParameter();
					parameter.fill(data.building_list[key]);
					BuildingList.push(parameter);
				}
			}
		}
	}
}