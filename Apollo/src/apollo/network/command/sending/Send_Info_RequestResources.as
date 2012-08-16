package apollo.network.command.sending 
{
	import apollo.configuration.ConnectorContextConfig;
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class Send_Info_RequestResources extends CNetPackageSending 
	{
		public var AccountId: String;
		
		public function Send_Info_RequestResources() 
		{
			super(ConnectorContextConfig.CONTROLLER_INFO, ConnectorContextConfig.ACTION_REQUEST_RESOURCES);
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_urlVariables.account_id = AccountId;
			
			generateCode();
		}
		
		override protected function generateCode(): void
		{
			var check: Array = new Array(_urlVariables.account_id, _urlVariables.game_id);
			_urlVariables.check_code = generateArrayCode(check);
		}
	}

}