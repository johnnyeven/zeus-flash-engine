package apollo.network.command.receiving 
{
	import apollo.configuration.ConnectorContextConfig;
	
	/**
	 * ...
	 * @author john
	 */
	public class Receive_Info_RequestAccountId extends CNetPackageReceiving 
	{
		public var AccountId: String;
		public var NickName: String;
		
		public function Receive_Info_RequestAccountId() 
		{
			super(ConnectorContextConfig.CONTROLLER_INFO, ConnectorContextConfig.ACTION_REQUEST_ACCOUNTID);
		}
		
		override public function fill(data: Object): void 
		{
			super.fill(data);
			
			if (message == ConnectorContextConfig.ACK_CONFIRM)
			{
				AccountId = data.account_id;
				NickName = data.nick_name;
			}
		}
	}

}