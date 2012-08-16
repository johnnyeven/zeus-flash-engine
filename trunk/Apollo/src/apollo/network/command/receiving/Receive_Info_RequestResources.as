package apollo.network.command.receiving 
{
	import apollo.center.CResourceCenter;
	import apollo.configuration.ConnectorContextConfig;
	import apollo.network.data.CResourceParameter;
	
	/**
	 * ...
	 * @author john
	 */
	public class Receive_Info_RequestResources extends CNetPackageReceiving 
	{
		public var ResourcesList: Vector.<CResourceParameter>;
		
		public function Receive_Info_RequestResources() 
		{
			super(ConnectorContextConfig.CONTROLLER_INFO, ConnectorContextConfig.ACTION_REQUEST_ACCOUNTID);
			ResourcesList = new Vector.<CResourceParameter>();
		}
		
		override public function fill(data: Object): void 
		{
			super.fill(data);
			
			if (message == ConnectorContextConfig.ACK_CONFIRM)
			{
				for (var key: String in data.resource_list)
				{
					var resource: CResourceParameter = new CResourceParameter(data.resource_list[key].resource_id, data.resource_list[key].resource_name, data.resource_list[key].resource_current, data.resource_list[key].resource_incremental, data.resource_list[key].resource_max);
					ResourcesList.push(resource);
				}
			}
		}
	}

}