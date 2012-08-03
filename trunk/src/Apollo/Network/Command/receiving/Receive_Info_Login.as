package Apollo.Network.Command.receiving 
{
	import Apollo.Configuration.SocketContextConfig;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author john
	 */
	public class Receive_Info_Login extends CNetPackageReceiving 
	{
		public var serverIP: String;
		public var serverPort: int = int.MIN_VALUE;
		public var authKey: String;
		public var userId: int = int.MIN_VALUE;
		
		public function Receive_Info_Login() 
		{
			super(SocketContextConfig.CONTROLLER_INFO, SocketContextConfig.ACTION_LOGIN);
		}
		
		override public function fill(bytes:ByteArray):void 
		{
			super.fill(bytes);
			
			if (success == SocketContextConfig.ACK_CONFIRM)
			{
				var length: int;
				var type: int;
				while (bytes.bytesAvailable)
				{
					length = bytes.readInt();
					type = bytes.readByte();
					switch(type)
					{
						case SocketContextConfig.TYPE_STRING:
							if (authKey == null)
							{
								authKey = bytes.readUTFBytes(length);
							}
							else if (serverIP == null)
							{
								serverIP = bytes.readUTFBytes(length);
							}
							break;
						case SocketContextConfig.TYPE_INT:
							if (userId == int.MIN_VALUE)
							{
								userId = bytes.readInt();
							}
							else if (serverPort == int.MIN_VALUE)
							{
								serverPort = bytes.readInt();
							}
							break;
					}
				}
			}
		}
	}

}