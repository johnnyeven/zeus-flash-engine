package Apollo.Network.Command.receiving 
{
	import Apollo.Network.Command.interfaces.INetPackageReceiving;
	import Apollo.Network.Command.CCommandBase;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author john
	 */
	public class CNetPackageReceiving extends CCommandBase implements INetPackageReceiving 
	{
		public var success: int;
		
		public function CNetPackageReceiving(controller:int, action:int) 
		{
			super(controller, action);
		}
		
		/* INTERFACE INetPackageReceiving */
		
		public function fill(bytes:ByteArray):void 
		{
			success = bytes.readByte();
			bytes.readShort();
		}
		
	}

}