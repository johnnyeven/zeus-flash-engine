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
		 * 摄影机控制器
		 */
		protected var _camera_controller: CCameraController;
		/**
		 * 玩家控制器
		 */
		protected var _role_controller: Dictionary;
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
			setupNetworkProcessor();
			_preCameraViewTimer = GlobalContextConfig.Timer;
		}
		
		protected function setupNetworkProcessor(): void
		{
			CProcessorRouter.getInstance().add(new CSceneProcessor());
		}
		
		public function requestRefreshCamaraView(): void
		{
			//if (GlobalContextConfig.Timer - _preCameraViewTimer > GlobalContextConfig.cameraview_trigger)
			//{
				var map: CWorldMap = CApolloScene.getInstance().map;
				//trace("当前坐标：" + _player_controller.controlObject.pos.x + ", " + _player_controller.controlObject.pos.y + "请求：" + map.cameraCutView.x + "," + map.cameraCutView.y + "," + map.cameraCutView.width + "," + map.cameraCutView.height);
				var protocol: Send_Info_CameraView = new Send_Info_CameraView();
				protocol.guid = CharacterData.Guid;
				protocol.x = map.cameraCutView.x;
				protocol.y = map.cameraCutView.y;
				protocol.width = map.cameraCutView.width;
				protocol.height = map.cameraCutView.height;
				//CCommandCenter.getInstance().send(protocol);
				//_preCameraViewTimer = GlobalContextConfig.Timer;
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
		 * 通用移除控制器
		 */
		public function removeController(ctrl: CBaseController): void
		{
			if (ctrl is CCharacterController)
			{
				removeRoleController(ctrl as CCharacterController);
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