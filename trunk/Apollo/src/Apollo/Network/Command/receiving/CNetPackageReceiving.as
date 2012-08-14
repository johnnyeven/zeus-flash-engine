package Apollo.Network.Command.receiving 
{
	import Apollo.Network.Command.interfaces.INetPackageReceiving;
	import Apollo.Network.Command.CCommandBase;
	
	/**
	 * ...
	 * @author john
	 */
	public class CNetPackageReceiving extends CCommandBase implements INetPackageReceiving 
	{
		public var message: int;
		
		public function CNetPackageReceiving(controller: String, action: String) 
		{
			super(controller, action);
		}
		
		/* INTERFACE INetPackageReceiving */
		
		public function fill(data: Object): void 
		{
			message = data.message;
		}
		
	}

}