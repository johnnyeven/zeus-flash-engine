package Apollo.Network.Command.sending 
{
	import Apollo.Configuration.ConnectorContextConfig;
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class Send_Info_Login extends CNetPackageSending 
	{
		public var UserName: String;
		public var UserPass: String;
		
		public function Send_Info_Login() 
		{
			super(ConnectorContextConfig.CONTROLLER_INFO, ConnectorContextConfig.ACTION_LOGIN);
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_urlVariables.user_name = UserName;
			_urlVariables.user_pass = UserPass;
		}
	}

}