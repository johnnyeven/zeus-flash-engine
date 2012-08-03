package Apollo.Network.Command.receiving 
{
	import Apollo.Configuration.SocketContextConfig;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author john
	 */
	public class Receive_NPC_Move_Move extends CNetPackageReceiving 
	{
		public var guid: String;
		public var posX: int = int.MIN_VALUE;
		public var posY: int = int.MIN_VALUE;
		
		public function Receive_NPC_Move_Move() 
		{
			super(SocketContextConfig.NPC_CONTROLLER_MOVE, SocketContextConfig.ACTION_MOVE);
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
							guid = bytes.readUTFBytes(length);
							break;
						case SocketContextConfig.TYPE_INT:
							if (posX == int.MIN_VALUE)
							{
								posX = bytes.readInt();
							}
							else if (posY == int.MIN_VALUE)
							{
								posY = bytes.readInt();
							}
							break;
					}
				}
			}
		}
	}

}