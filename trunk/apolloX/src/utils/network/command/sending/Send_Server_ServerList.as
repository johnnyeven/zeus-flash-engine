package utils.network.command.sending 
{
	import configuration.ConnectorContextConfig;
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class Send_Server_ServerList extends CNetPackageSending 
	{
		public var GameId: String;
		
		public function Send_Server_ServerList() 
		{
			super(ConnectorContextConfig.CONTROLLER_SERVER, ConnectorContextConfig.ACTION_SERVERLIST);
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_urlVariables.game_id = GameId;
		}
	}

}