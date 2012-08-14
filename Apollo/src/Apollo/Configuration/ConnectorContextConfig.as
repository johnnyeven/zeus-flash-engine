package Apollo.Configuration 
{
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public final class ConnectorContextConfig 
	{
		private static var server_ip: String = 'localhost';
		private static var server_port: String = '80';
		private static var server_app_root: String = 'game_server';
		private static var useSSL: Boolean = false;
		
		public static const ACK_CONFIRM: int = 1;
		public static const ACK_ERROR: int = 0;
		
		public static var CONTROLLER_INFO: String = "account/info";
		public static var ACTION_LOGIN: String = "login";
		public static var ACTION_REQUEST_CHARACTER: String = "requestCharacterList";
		public static var ACTION_INIT_CHARACTER: String = "initCharacter";
		public static var ACTION_CAMERAVIEW_OBJECT_LIST: String = "requestViewObjects";
		
		public function ConnectorContextConfig() 
		{
		}
		
		public static function get serverPath(): String
		{
			var path: String = useSSL ? "https://" : "http://";
			path += server_ip;
			path += (":" + server_port + "/");
			path += server_app_root + "/";
			return path;
		}
		
	}

}