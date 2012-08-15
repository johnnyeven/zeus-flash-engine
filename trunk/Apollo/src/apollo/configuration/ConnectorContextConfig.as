package apollo.configuration 
{
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public final class ConnectorContextConfig 
	{
		private static var server_ip: String = '66.148.112.175';
		private static var server_port: String = '80';
		private static var server_app_root: String = 'game_server';
		private static var useSSL: Boolean = false;
		
		public static const ACK_CONFIRM: int = 1;
		public static const ACK_ERROR: int = 0;
		
		public static var CONTROLLER_INFO: String = "game/initialization";
		public static var ACTION_LOGIN: String = "login";
		public static var ACTION_REQUEST_CHARACTER: String = "requestCharacterList";
		public static var ACTION_INIT_CHARACTER: String = "initCharacter";
		public static var ACTION_CAMERAVIEW_OBJECT_LIST: String = "requestViewObjects";
		
		public static var GAME_ID: String = "A";
		public static var SECTION_ID: String = "Z";
		public static var SERVER_ID: String = "Z";
		public static var AUTH_KEY: String = "bbc904d185bb824e5ae5eebf5cc831cf49f44b2b";
		
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