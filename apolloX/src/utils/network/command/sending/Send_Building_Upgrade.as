package apollo.network.command.sending 
{
	import apollo.configuration.CharacterData;
	import apollo.configuration.ConnectorContextConfig;
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class Send_Building_Upgrade extends CNetPackageSending 
	{
		public var ObjectId: String;
		
		public function Send_Building_Upgrade() 
		{
			super(ConnectorContextConfig.CONTROLLER_BUILDING, ConnectorContextConfig.ACTION_UPGRADE);
			
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_urlVariables.object_id = ObjectId;
			_urlVariables.account_id = CharacterData.AccountId;
			
			generateCode();
		}
		
		override protected function generateCode(): void
		{
			var check: Array = new Array(_urlVariables.object_id, _urlVariables.account_id, _urlVariables.game_id);
			_urlVariables.check_code = generateArrayCode(check);
		}
		
	}

}