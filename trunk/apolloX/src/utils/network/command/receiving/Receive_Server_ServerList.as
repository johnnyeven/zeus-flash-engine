package utils.network.command.receiving 
{
	import configuration.ConnectorContextConfig;
	
	/**
	 * ...
	 * @author john
	 */
	public class Receive_Server_ServerList extends CNetPackageReceiving 
	{
		public var ServerList: Array;
		
		public function Receive_Server_ServerList() 
		{
			super(ConnectorContextConfig.CONTROLLER_SERVER, ConnectorContextConfig.ACTION_SERVERLIST);
		}
		
		override public function fill(data: Object): void 
		{
			super.fill(data);
			
			if (message == ConnectorContextConfig.ACK_CONFIRM)
			{
				ServerList = data.server;
			}
		}
	}

}