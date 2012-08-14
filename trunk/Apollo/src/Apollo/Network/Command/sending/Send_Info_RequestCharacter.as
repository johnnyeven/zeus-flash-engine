package Apollo.Network.Command.sending 
{
	import Apollo.Configuration.SocketContextConfig;
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class Send_Info_RequestCharacter extends CNetPackageSending 
	{
		public var AuthKey: String;
		public var UserId: int;
		
		public function Send_Info_RequestCharacter() 
		{
			super(SocketContextConfig.CONTROLLER_INFO, SocketContextConfig.ACTION_REQUEST_CHARACTER);
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_urlVariables.auth_key = AuthKey;
			_urlVariables.user_id = UserId;
		}
	}

}