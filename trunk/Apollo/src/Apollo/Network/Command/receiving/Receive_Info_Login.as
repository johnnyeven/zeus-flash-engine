package Apollo.Network.Command.receiving 
{
	import Apollo.Configuration.ConnectorContextConfig;
	
	/**
	 * ...
	 * @author john
	 */
	public class Receive_Info_Login extends CNetPackageReceiving 
	{
		public var ServerIP: String;
		public var ServerPort: int = int.MIN_VALUE;
		public var AuthKey: String;
		public var UserId: int = int.MIN_VALUE;
		
		public function Receive_Info_Login() 
		{
			super(ConnectorContextConfig.CONTROLLER_INFO, ConnectorContextConfig.ACTION_LOGIN);
		}
		
		override public function fill(data: Object): void 
		{
			super.fill(data);
			
			if (message == ConnectorContextConfig.ACK_CONFIRM)
			{
				ServerIP = data.server_ip;
				ServerPort = data.server_port;
				AuthKey = data.auth_key;
				UserId = data.user_id;
			}
		}
	}

}