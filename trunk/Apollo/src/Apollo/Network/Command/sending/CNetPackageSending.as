package Apollo.Network.Command.sending 
{
	import Apollo.Network.Command.CCommandBase;
	import Apollo.Network.Command.interfaces.INetPackageSending;
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
		}
		
		public function get urlVariables(): URLVariables 
		{
			return _urlVariables;
		}
		
	}

}