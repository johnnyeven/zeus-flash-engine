package Apollo.Controller 
{
	import Apollo.Maps.CWorldMap;
	import Apollo.Network.*;
	import Apollo.Network.Command.receiving.Receive_Info_CameraView;
	import Apollo.Objects.*;
	import Apollo.Configuration.*;
	import Apollo.Events.*;
	import Apollo.Scene.*;
	import Apollo.Configuration.*;
	import Apollo.Center.CCommandCenter;
	import Apollo.Network.Command.sending.*;
	import Apollo.Network.Processor.*;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.EventDispatcher;
	import flash.errors.IllegalOperationError;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author john
	 */
	public class CControllerCenter implements IEventDispatcher
	{
		protected var eventDispatcher: EventDispatcher;
		/**
		 * 玩家控制器
		 */
		protected var _player_controller: CCharacterController;
		protected var _other_controller: Dictionary;
		protected var _npc_controller: Dictionary;
		protected var _monster_controller: Dictionary;
		private static var instance: CControllerCenter;
		private static var allowInstance: Boolean = false;
		
		protected var _preCameraViewTimer: uint;
		
		public function CControllerCenter() 
		{
			if (!allowInstance)
			{
				throw new IllegalOperationError("CControllerCenter不允许实例化");
			}
			eventDispatcher = new EventDispatcher(this);
			init();
		}
		
		public static function getInstance(): CControllerCenter
		{
			if (instance == null)
			{
				allowInstance = true;
				instance = new CControllerCenter();
				allowInstance = false;
			}
			return instance;
		}
		
		protected function init(): void
		{
			_other_controller = new Dictionary();
			_npc_controller = new Dictionary();
			_monster_controller = new Dictionary();
			setupNetworkProcessor();
			_preCameraViewTimer = GlobalContextConfig.Timer;
		}
		
		protected function setupNetworkProcessor(): void
		{
			CProcessorRouter.getInstance().add(new CSceneProcessor());
			CProcessorRouter.getInstance().add(new CBattleProcessor());
		}
		
		public function requestRefreshCamaraView(): void
		{
			//if (GlobalContextConfig.Timer - _preCameraViewTimer > GlobalContextConfig.cameraview_trigger)
			//{
				var map: CWorldMap = _player_controller.perception.scene.map;
				//trace("当前坐标：" + _player_controller.controlObject.pos.x + ", " + _player_controller.controlObject.pos.y + "请求：" + map.cameraCutView.x + "," + map.cameraCutView.y + "," + map.cameraCutView.width + "," + map.cameraCutView.height);
				var protocol: Send_Info_CameraView = new Send_Info_CameraView();
				protocol.guid = CharacterData.Guid;
				protocol.x = map.cameraCutView.x;
				protocol.y = map.cameraCutView.y;
				protocol.width = map.cameraCutView.width;
				protocol.height = map.cameraCutView.height;
				CCommandCenter.getInstance().send(protocol);
				//_preCameraViewTimer = GlobalContextConfig.Timer;
			//}
		}
		
		protected function npcAttackRequestHandler(event: NetworkEvent): void
		{
			var data: ByteArray = event.data as ByteArray;
			var length: int;
			var type: int;
			var me: int = int.MAX_VALUE;
			var targetId: String;
			var playerId: String;
			
			while (data.bytesAvailable)
			{
				length = data.readInt();
				type = data.readByte();
				switch(type)
				{
					case CNetConnection.TYPE_INT:
						me = data.readInt();
						break;
					case CNetConnection.TYPE_STRING:
						if (targetId == null)
						{
							targetId = data.readUTFBytes(length);
						}
						else if (playerId == null)
						{
							playerId = data.readUTFBytes(length);
						}
						break;
				}
			}
			
			if (me == 0)
			{
				if (_monster_controller[targetId] != null)
				{
					var target: CBattleObject = (_monster_controller[targetId] as CMonsterController).controlObject as CBattleObject;
					if (target.attacker == null)
					{
						target.prepareAttack(_player_controller.controlObject as CCharacterObject);
					}
				}
			}
			else
			{
				
			}
		}
		
		protected function npcAttackConfirmHandler(event: NetworkEvent): void
		{
			var data: ByteArray = event.data as ByteArray;
			var length: int;
			var type: int;
			var targetId: String;
			var playerId: String;
			var power: int;
			while (data.bytesAvailable)
			{
				length = data.readInt();
				type = data.readByte();
				switch(type)
				{
					case CNetConnection.TYPE_STRING:
						if (targetId == null)
						{
							targetId = data.readUTFBytes(length);
						}
						else if (playerId == null)
						{
							playerId = data.readUTFBytes(length);
						}
						break;
					case CNetConnection.TYPE_INT:
						power = data.readInt();
						break;
				}
			}
			if (_monster_controller[targetId] != null)
			{
				var target: CBattleObject = (_monster_controller[targetId] as CMonsterController).controlObject as CBattleObject;
				//target.prepareAttack(_player_controller.controlObject as CCharacterObject);
				trace("我被攻击" + power + "点");
			}
		}
		
		protected function attackConfirmHandler(event: NetworkEvent): void
		{
			var data: ByteArray = event.data as ByteArray;
			var length: int = data.readInt();
			var type: int = data.readByte();
			var power: int = data.readInt();
			
			(_player_controller.controlObject as CBattleObject).attacker.underAttack(power);
			trace("我攻击" + power + "点");
		}
		
		public function set playerController(ctrl: CCharacterController): void
		{
			if (_player_controller != null)
			{
				return;
			}
			else
			{
				_player_controller = ctrl;
			}
		}
		
		public function get playerController(): CCharacterController
		{
			return _player_controller;
		}
		
		/**
		 * 向其他玩家控制器容器中添加一个新控制器
		 * @param	ctrl
		 * @param	key
		 */
		public function addOtherController(ctrl: COtherPlayerController, key: * ): void
		{
			if (_other_controller[key] != null)
			{
				return;
			}
			else
			{
				_other_controller[key] = ctrl;
			}
		}
		
		public function removeOtherController(ctrl: COtherPlayerController): void
		{
			for (var id: * in _other_controller)
			{
				if (_other_controller[id] == ctrl)
				{
					delete _other_controller[id];
					return;
				}
			}
		}
		
		public function getOtherController(id: * ): COtherPlayerController
		{
			return _other_controller[id];
		}
		
		/**
		 * 向NPC控制器容器中添加一个新控制器
		 * @param	ctrl
		 * @param	key
		 */
		public function addNPCController(ctrl: CNPCController, key: * ): void
		{
			if (_npc_controller[key] != null)
			{
				return;
			}
			else
			{
				_npc_controller[key] = ctrl;
			}
		}
		
		public function removeNPCController(ctrl: CNPCController): void
		{
			for (var id: * in _npc_controller)
			{
				if (_npc_controller[id] == ctrl)
				{
					delete _npc_controller[id];
					return;
				}
			}
		}
		
		public function getNPCController(id: * ): CNPCController
		{
			return _npc_controller[id];
		}
		
		/**
		 * 向Monster控制器容器中添加一个新控制器
		 * @param	ctrl
		 * @param	key
		 */
		public function addMonsterController(ctrl: CMonsterController, key: * ): void
		{
			if (_monster_controller[key] != null)
			{
				return;
			}
			else
			{
				_monster_controller[key] = ctrl;
			}
		}
		
		public function removeMonsterController(ctrl: CMonsterController): void
		{
			for (var id: * in _monster_controller)
			{
				if (_monster_controller[id] == ctrl)
				{
					delete _monster_controller[id];
					return;
				}
			}
		}
		
		public function getMonsterController(id: * ): CMonsterController
		{
			return _monster_controller[id];
		}
		
		/**
		 * 通用移除控制器
		 */
		public function removeController(ctrl: CBaseController): void
		{
			if (ctrl is COtherPlayerController)
			{
				removeOtherController(ctrl as COtherPlayerController);
			}
			else if (ctrl is CNPCController)
			{
				removeNPCController(ctrl as CNPCController);
			}
			else if (ctrl is CMonsterController)
			{
				removeMonsterController(ctrl as CMonsterController);
			}
		}
		
		/**
		 * 
		 * @param type
		 * @param listener
		 * @param useCapture
		 * @param priority
		 * @param useWeakReference
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false): void
		{
			eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		/**
		 * 
		 * @param e
		 */
		public function dispatchEvent(e:Event): Boolean
		{
			return eventDispatcher.dispatchEvent(e);
		}

		/**
		 * 
		 * @param type
		 */
		public function hasEventListener(type:String): Boolean
		{
			return eventDispatcher.hasEventListener(type);
		}

		/**
		 * 
		 * @param type
		 * @param listener
		 * @param useCapture
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false): void
		{
			eventDispatcher.removeEventListener(type, listener, useCapture);
		}

		/**
		 * 
		 * @param type
		 */
		public function willTrigger(type:String): Boolean
		{
			return eventDispatcher.willTrigger(type);
		}
	}

}