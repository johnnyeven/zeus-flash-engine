package apollo.network.command.receiving 
{
	import apollo.configuration.ConnectorContextConfig;
	
	/**
	 * ...
	 * @author john
	 */
	public class Receive_Info_RequestCharacter extends CNetPackageReceiving 
	{
		public var Guid: String;
		public var AuthKey: String;
		public var CharacterName: String;
		
		public function Receive_Info_RequestCharacter() 
		{
			super(ConnectorContextConfig.CONTROLLER_INFO, ConnectorContextConfig.ACTION_REQUEST_CHARACTER);
		}
		
		override public function fill(data: Object): void 
		{
			super.fill(data);
			
			if (message == ConnectorContextConfig.ACK_CONFIRM)
			{
				Guid = data.guid;
				AuthKey = data.auth_key;
				CharacterName = data.character_name;
			}
		}
	}

}