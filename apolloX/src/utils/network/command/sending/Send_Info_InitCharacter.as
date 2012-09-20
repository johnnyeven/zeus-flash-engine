package apollo.network.command.sending 
{
	import apollo.configuration.ConnectorContextConfig;
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class Send_Info_InitCharacter extends CNetPackageSending 
	{
		public var Guid: String;
		public var AuthKey: String;
		
		public function Send_Info_InitCharacter() 
		{
			super(ConnectorContextConfig.CONTROLLER_INFO, ConnectorContextConfig.ACTION_INIT_CHARACTER);
		}
		
		override public function fill(): void 
		{
			super.fill();
			
			_urlVariables.guid = Guid;
			_urlVariables.auth_key = AuthKey;
		}
	}

}