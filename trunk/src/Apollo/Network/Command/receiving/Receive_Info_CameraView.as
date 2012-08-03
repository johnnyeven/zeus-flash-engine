package Apollo.Network.Command.receiving 
{
	import Apollo.Configuration.SocketContextConfig;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author john
	 */
	public class Receive_Info_CameraView extends CNetPackageReceiving 
	{
		public var guid: String;
		public var characterLevel: int = int.MIN_VALUE;
		public var characterName: String;
		public var resourceId: String;
		public var direction: int = int.MIN_VALUE;
		public var posX: int = int.MIN_VALUE;
		public var posY: int = int.MIN_VALUE;
		public var speed: int = int.MIN_VALUE;
		public var healthMax: int = int.MIN_VALUE;
		public var health: int = int.MIN_VALUE;
		public var manaMax: int = int.MIN_VALUE;
		public var mana: int = int.MIN_VALUE;
		public var energyMax: int = int.MIN_VALUE;
		public var energy: int = int.MIN_VALUE;
		public var attackRange: int = int.MIN_VALUE;
		public var attackSpeed: Number = Number.NaN;
		public var passitiveMonster: Boolean = false;
		
		public var characterAction: int = int.MIN_VALUE;
		public var targetX: int = int.MIN_VALUE;
		public var targetY: int = int.MIN_VALUE;
		
		public function Receive_Info_CameraView() 
		{
			super(SocketContextConfig.CONTROLLER_INFO, SocketContextConfig.ACTION_INIT_CHARACTER);
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
							}
							else if (characterName == null)
							{
								characterName = bytes.readUTFBytes(length);
							}
							else if (resourceId == null)
							{
								resourceId = bytes.readUTFBytes(length);
							}
							break;
						case SocketContextConfig.TYPE_INT:
							if (characterLevel == int.MIN_VALUE)
							{
								characterLevel = bytes.readInt();
							}
							else if (direction == int.MIN_VALUE)
							{
								direction = bytes.readInt();
							}
							else if (posX == int.MIN_VALUE)
							{
								posX = bytes.readInt();
							}
							else if (posY == int.MIN_VALUE)
							{
								posY = bytes.readInt();
							}
							else if (speed == int.MIN_VALUE)
							{
								speed = bytes.readInt();
							}
							else if (healthMax == int.MIN_VALUE)
							{
								healthMax = bytes.readInt();
							}
							else if (health == int.MIN_VALUE)
							{
								health = bytes.readInt();
							}
							else if (manaMax == int.MIN_VALUE)
							{
								manaMax = bytes.readInt();
							}
							else if (mana == int.MIN_VALUE)
							{
								mana = bytes.readInt();
							}
							else if (energyMax == int.MIN_VALUE)
							{
								energyMax = bytes.readInt();
							}
							else if (energy == int.MIN_VALUE)
							{
								energy = bytes.readInt();
							}
							else if (attackRange == int.MIN_VALUE)
							{
								attackRange = bytes.readInt();
							}
							else if (characterAction == int.MIN_VALUE)
							{
								characterAction = bytes.readInt();
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
						case SocketContextConfig.TYPE_FLOAT:
							attackSpeed = bytes.readFloat();
							break;
						case SocketContextConfig.TYPE_BOOL:
							passitiveMonster = bytes.readBoolean();
							break;
					}
				}
			}
		}
	}

}