package apollo.network.command.sending 
{
	import apollo.configuration.ConnectorContextConfig;
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class Send_Info_RequestAccountId extends CNetPackageSending 
	{
		public var GUID: String;
		
		public function Send_Info_RequestAccountId() 
		{
			super(ConnectorContextConfig.CONTROLLER_INFO, ConnectorContextConfig.ACTION_REQUEST_CHARACTER);
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_urlVariables.guid = GUID;
			_urlVariables.server_id = ConnectorContextConfig.SERVER_ID;
			
			generateCode();
		}
		
		override protected function generateCode(): void
		{
			var check: Array = new Array(_urlVariables.guid, _urlVariables.game_id, _urlVariables.server_section, _urlVariables.server_id);
			_urlVariables.check_code = generateArrayCode(check);
		}
	}

}