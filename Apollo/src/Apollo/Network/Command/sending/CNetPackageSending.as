package Apollo.Network.Command.sending 
{
	import Apollo.Configuration.ConnectorContextConfig;
	import Apollo.Network.Command.CCommandBase;
	import Apollo.Network.Command.interfaces.INetPackageSending;
	
	import com.adobe.crypto.*;
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class CNetPackageSending extends CCommandBase implements INetPackageSending 
	{
		protected var _urlVariables: URLVariables;
		
		public function CNetPackageSending(controller: String, action: String) 
		{
			super(controller, action);
		}
		
		/* INTERFACE com.Network.INetPackageSending */
		
		public function fill(): void 
		{
			_urlVariables = new URLVariables();
			_urlVariables.game_id = ConnectorContextConfig.GAME_ID;
			_urlVariables.server_section = ConnectorContextConfig.SECTION_ID;
		}
		
		public function get urlVariables(): URLVariables 
		{
			return _urlVariables;
		}
		
		protected function generateCode(): void
		{
			CONFIG::DebugMode
			{
				trace('Please override generateCode()');
			}
		}
		
		protected function generateArrayCode(arr: Array): String
		{
			var originText: String = arr.join("|||");
			originText += ("|||" + ConnectorContextConfig.AUTH_KEY);
			return SHA1.hash(MD5.hash(originText));
		}
		
	}

}