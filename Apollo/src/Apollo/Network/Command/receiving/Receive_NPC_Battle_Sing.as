package Apollo.Network.Command.receiving 
{
	import Apollo.Configuration.SocketContextConfig;
	import Apollo.Scene.CApolloScene;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author john
	 */
	public class Receive_NPC_Battle_Sing extends CNetPackageReceiving 
	{
		public var guid: String;
		public var skillId: String;
		public var skillLevel: int = int.MIN_VALUE;
		public var direction: int = int.MIN_VALUE;
		public var targetId: String;
		public var targetX: int = int.MIN_VALUE;
		public var targetY: int = int.MIN_VALUE;
		public var target: *;
		
		public function Receive_NPC_Battle_Sing() 
		{
			super(SocketContextConfig.NPC_CONTROLLER_BATTLE, SocketContextConfig.ACTION_SING);
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
							if (guid == null)
							{
								guid = bytes.readUTFBytes(length);
								continue;
							}
							else if (skillId == null)
							{
								skillId = bytes.readUTFBytes(length);
								continue;
							}
							else if (targetId == null)
							{
								targetId = bytes.readUTFBytes(length);
								continue;
							}
							break;
						case SocketContextConfig.TYPE_INT:
							if (skillLevel == int.MIN_VALUE)
							{
								skillLevel = bytes.readInt();
							}
							else if (direction == int.MIN_VALUE)
							{
								direction = bytes.readInt();
							}
							else if (targetX == int.MIN_VALUE)
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
			if (targetId == "")
			{
				target = new Point(targetX, targetY);
			}
			else
			{
				target = CApolloScene.getInstance().getObjectById(targetId);
			}
		}
	}

}