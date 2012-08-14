package Apollo.Network.Command.receiving 
{
	import Apollo.Configuration.ConnectorContextConfig;
	
	/**
	 * ...
	 * @author john
	 */
	public class Receive_Info_InitCharacter extends CNetPackageReceiving 
	{
		public var Guid: String;
		public var AuthKey: String;
		public var CharacterLevel: int = int.MIN_VALUE;
		public var CharacterName: String;
		
		public function Receive_Info_InitCharacter() 
		{
			super(ConnectorContextConfig.CONTROLLER_INFO, ConnectorContextConfig.ACTION_INIT_CHARACTER);
		}
		
		override public function fill(data: Object):void 
		{
			super.fill(data);
			
			if (message == ConnectorContextConfig.ACK_CONFIRM)
			{
				Guid = data.guid;
				AuthKey = data.auth_key;
				CharacterLevel = data.character_level;
				CharacterName = data.character_name;
			}
		}
	}

}