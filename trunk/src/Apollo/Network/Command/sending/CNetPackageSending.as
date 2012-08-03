package Apollo.Network.Command.sending 
{
	import Apollo.Network.Command.CCommandBase;
	import Apollo.Network.Command.interfaces.INetPackageSending;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class CNetPackageSending extends CCommandBase implements INetPackageSending 
	{
		protected var _byteArray: ByteArray;
		
		public function CNetPackageSending(controller:int, action:int) 
		{
			_byteArray = new ByteArray();
			super(controller, action);
		}
		
		/* INTERFACE com.Network.INetPackageSending */
		
		public function fill():void 
		{
			_byteArray.clear();
			_byteArray.writeByte((controller << 4) | action);
		}
		
		public function get byteArray():ByteArray 
		{
			return _byteArray;
		}
		
	}

}