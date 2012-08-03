package Apollo.Network 
{
	import Apollo.Controller.CControllerCenter
	
	/**
	 * ...
	 * @author john
	 */
	public class CControlConnection extends CNetConnection 
	{
		
		public function CControlConnection(_ctrlCenter: CControllerCenter) 
		{
			super(_ctrlCenter);
			connect();
		}
		
		public function action(objectId: String, actionId: int): void
		{
			var netPackage: CNetPackage = new CNetPackage();
			netPackage.controller = CONTROLLER_INFO;
			netPackage.action = ACTION_CHANGE_ACTION;
			
			netPackage.param.push([objectId.length, objectId]);
			netPackage.param.push([4, actionId]);
			
			sendPackage(netPackage);
		}
		
		public function requestRefreshCameraView(startX: uint, startY: uint, width: uint, height: uint): void
		{
			var netPackage: CNetPackage = new CNetPackage();
			netPackage.controller = CONTROLLER_INFO;
			netPackage.action = ACTION_CAMERAVIEW_OBJECT_LIST;
			
			var objectId: String = _ctrlCenter.playerController.perception.scene.player.objectId;
			netPackage.param.push([objectId.length, objectId]);
			netPackage.param.push([4, startX]);
			netPackage.param.push([4, startY]);
			netPackage.param.push([4, width]);
			netPackage.param.push([4, height]);
			
			sendPackage(netPackage);
		}
		
		public function moveTo(objectId: String, targetX: uint, targetY: uint): void
		{
			var netPackage: CNetPackage = new CNetPackage();
			netPackage.controller = CONTROLLER_MOVE;
			netPackage.action = ACTION_MOVETO;
			netPackage.param.push([objectId.length, objectId]);
			netPackage.param.push([4, targetX]);
			netPackage.param.push([4, targetY]);
			sendPackage(netPackage);
		}
		
		public function moveSync(playerId: String, targetX: uint, targetY: uint): void
		{
			var netPackage: CNetPackage = new CNetPackage();
			netPackage.controller = CONTROLLER_MOVE;
			netPackage.action = ACTION_MOVE;
			netPackage.param.push([playerId.length, playerId]);
			netPackage.param.push([4, targetX]);
			netPackage.param.push([4, targetY]);
			sendPackage(netPackage);
		}
		
		public function attack(playerId: String, targetId: String, skillId: String): void
		{
			var netPackage: CNetPackage = new CNetPackage();
			netPackage.controller = CONTROLLER_BATTLE;
			netPackage.action = ACTION_ATTACK;
			netPackage.param.push([playerId.length, playerId]);
			netPackage.param.push([targetId.length, targetId]);
			netPackage.param.push([skillId.length, skillId]);
			sendPackage(netPackage);
		}
		/**
		 * Monster攻击请求
		 */
		public function attackRequest(targetId: String, playerId: String, skillId: uint): void
		{
			var netPackage: CNetPackage = new CNetPackage();
			netPackage.controller = NPC_CONTROLLER_BATTLE;
			netPackage.action = ACTION_ATTACK;
			netPackage.param.push([targetId.length, targetId]);
			netPackage.param.push([playerId.length, playerId]);
			netPackage.param.push([4, skillId]);
			sendPackage(netPackage);
		}
	}

}