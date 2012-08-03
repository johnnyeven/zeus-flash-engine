package Apollo.Network.Command.receiving 
{
	import Apollo.Scene.CWoohaScene;
	import Apollo.Configuration.SocketContextConfig;
	
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author john
	 */
	public class Receive_Battle_Attack extends CNetPackageReceiving 
	{
		public var skillId: String;
		public var target: *;
		public var AttackInfo: Array;
		private var targetId: String;
		private var targetX: int = int.MIN_VALUE;
		private var targetY: int = int.MIN_VALUE;
		
		public function Receive_Battle_Attack() 
		{
			super(SocketContextConfig.CONTROLLER_BATTLE, SocketContextConfig.ACTION_ATTACK);
		}
		
		override public function fill(bytes:ByteArray):void 
		{
			super.fill(bytes);
			
			if (success == SocketContextConfig.ACK_CONFIRM)
			{
				var length: int;
				var type: int;
				var info: Object;
				AttackInfo = new Array();
				while (bytes.bytesAvailable)
				{
					if (info == null || (info.TargetId != undefined && info.AttackPower != undefined))
					{
						info = new Object();
					}
					length = bytes.readInt();
					type = bytes.readByte();
					switch(type)
					{
						case SocketContextConfig.TYPE_STRING:
							if (skillId == null)
							{
								skillId = bytes.readUTFBytes(length);
								continue;
							}
							else if (targetId == null)
							{
								targetId = bytes.readUTFBytes(length);
								continue;
							}
							info.TargetId = bytes.readUTFBytes(length);
							break;
						case SocketContextConfig.TYPE_INT:
							if (targetX == int.MIN_VALUE)
							{
								targetX = bytes.readInt();
								continue;
							}
							else if (targetY == int.MIN_VALUE)
							{
								targetY = bytes.readInt();
								continue;
							}
							info.AttackPower = bytes.readInt();
							break;
					}
					if (info != null && info.TargetId != undefined && info.AttackPower != undefined)
					{
						AttackInfo.push(info);
					}
				}
				
				if (targetId == "")
				{
					target = new Point(targetX, targetY);
				}
				else
				{
					target = CWoohaScene.getInstance().getObjectById(targetId);
				}
			}
		}
	}

}