package Apollo.Network.Command.receiving 
{
	import Apollo.Configuration.SocketContextConfig;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author john
	 */
	public class Receive_NPC_Move_MoveTo extends CNetPackageReceiving 
	{
		public var guid: String;
		public var targetX: int = int.MIN_VALUE;
		public var targetY: int = int.MIN_VALUE;
		
		public function Receive_NPC_Move_MoveTo() 
		{
			super(SocketContextConfig.NPC_CONTROLLER_MOVE, SocketContextConfig.ACTION_MOVETO);
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
							if (targetX == int.MIN_VALUE)
							{
								targetX = bytes.readInt();
							}
							else if (targetY == int.MIN_VALUE)
							{
								targetY = bytes.readInt();
							}
							break;
					}
				}
			}
		}
	}

}