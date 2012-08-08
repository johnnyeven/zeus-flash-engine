package Apollo.Center 
{
	import Apollo.Network.Command.interfaces.*;
	import Apollo.Network.CNetSocket;
	import Apollo.Network.Command.CCommandList;
	import Apollo.Network.Command.sending.*;
	import Apollo.Objects.CGameObject;
	
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author john
	 */
	public class CCommandCenter extends CBaseCenter 
	{
		private var socket: CNetSocket;
		private var command: CCommandList;
		private static var instance: CCommandCenter;
		private static var allowInstance: Boolean = false;
		
		public function CCommandCenter() 
		{
			super();
			if (!allowInstance)
			{
				throw new IllegalOperationError("CCommandCenter不允许实例化");
			}
			command = CCommandList.getInstance();
			socket = CNetSocket.getInstance();
			socket.addCallback(process);
		}
		
		private function process(flag: int, data: ByteArray): void
		{
			var protocol: INetPackageReceiving = command.getCommand(flag);
			if (protocol != null)
			{
				protocol.fill(data);
				triggerCallback(flag, protocol);
			}
		}
		
		public function add(flag: int, processor: Function): void
		{
			addCallback(flag, processor);
		}
		
		public function remove(flag: int, processor: Function): void
		{
			removeCallback(flag, processor);
		}
		
		public function send(protocol: INetPackageSending): void
		{
			protocol.fill();
			socket.send(protocol.byteArray);
		}
		
		public static function getInstance(): CCommandCenter
		{
			if (instance == null)
			{
				allowInstance = true;
				instance = new CCommandCenter();
				allowInstance = false;
			}
			return instance;
		}
		
		public static function commandChangeAction(action: int): void
		{
			var protocol: Send_Info_ChangeAction = new Send_Info_ChangeAction();
			protocol.Action = action;
			getInstance().send(protocol);
		}
		
		public static function commandChangeDirection(direction: int): void
		{
			var protocol: Send_Info_ChangeDirection = new Send_Info_ChangeDirection();
			protocol.Direction = direction;
			getInstance().send(protocol);
		}
		
		public static function commandMoveSync(startX: int, startY: int): void
		{
			var protocol: Send_Move_Move = new Send_Move_Move();
			protocol.TargetX = startX;
			protocol.TargetY = startY;
			getInstance().send(protocol);
		}
		
		public static function commandMoveTo(startX: int, startY: int): void
		{
			var protocol: Send_Move_MoveTo = new Send_Move_MoveTo();
			protocol.TargetX = startX;
			protocol.TargetY = startY;
			getInstance().send(protocol);
		}
		
		public static function commandBattleSing(skillId: String, skillLevel: int, direction: int, target: *): void
		{
			var protocol: Send_Battle_Sing = new Send_Battle_Sing();
			protocol.SkillId = skillId;
			protocol.SkillLevel = skillLevel;
			protocol.Direction = direction;
			protocol.Target = target;
			getInstance().send(protocol);
		}
		
		public static function commandAttack(target: *, skillId: String): void
		{
			var protocol: Send_Battle_Attack = new Send_Battle_Attack();
			protocol.SkillId = skillId;
			if (target is Point)
			{
				protocol.TargetX = (target as Point).x;
				protocol.TargetY = (target as Point).y;
			}
			else if (target is CGameObject)
			{
				protocol.TargetId = (target as CGameObject).objectId;
			}
			getInstance().send(protocol);
		}
	}

}