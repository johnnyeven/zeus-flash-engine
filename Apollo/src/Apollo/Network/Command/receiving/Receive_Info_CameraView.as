package Apollo.Network.Command.receiving 
{
	import Apollo.Configuration.ConnectorContextConfig;
	
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
			super(ConnectorContextConfig.CONTROLLER_INFO, ConnectorContextConfig.ACTION_INIT_CHARACTER);
		}
		
		override public function fill(data: Object): void 
		{
			super.fill(data);
			
			if (message == ConnectorContextConfig.ACK_CONFIRM)
			{
				
			}
		}
	}

}