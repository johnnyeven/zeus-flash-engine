package Apollo.Controller 
{
	import Apollo.Maps.CWorldMap;
	import Apollo.Network.*;
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
		 * 摄影机控制器
		 */
		protected var _camera_controller: CCameraController;
		/**
		 * 玩家控制器
		 */
		protected var _role_controller: Dictionary;
		protected var _npc_controller: Dictionary;
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
			_role_controller = new Dictionary();
			_npc_controller = new Dictionary();
			setupNetworkProcessor();
			_preCameraViewTimer = GlobalContextConfig.Timer;
		}
		
		protected function setupNetworkProcessor(): void
		{
			//CProcessorRouter.getInstance().add(new CSceneProcessor());
		}
		
		public function requestRefreshCamaraView(): void
		{
			//if (GlobalContextConfig.Timer - _preCameraViewTimer > GlobalContextConfig.cameraview_trigger)
			//{
				
			//}
		}
		
		/**
		 * 向其他玩家控制器容器中添加一个新控制器
		 * @param	ctrl
		 * @param	key
		 */
		public function addRoleController(ctrl: CCharacterController, key: * ): void
		{
			if (_role_controller[key] != null)
			{
				return;
			}
			else
			{
				_role_controller[key] = ctrl;
			}
		}
		
		public function removeRoleController(ctrl: CCharacterController): void
		{
			for (var id: * in _role_controller)
			{
				if (_role_controller[id] == ctrl)
				{
					delete _role_controller[id];
					return;
				}
			}
		}
		
		public function getRoleController(id: * ): CCharacterController
		{
			return _role_controller[id];
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
		 * 通用移除控制器
		 */
		public function removeController(ctrl: CBaseController): void
		{
			if (ctrl is CCharacterController)
			{
				removeRoleController(ctrl as CCharacterController);
			}
			else if (ctrl is CNPCController)
			{
				removeNPCController(ctrl as CNPCController);
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