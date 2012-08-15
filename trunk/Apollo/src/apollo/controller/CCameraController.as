package apollo.controller 
{
	import apollo.CGame;
	import apollo.display.CCamera;
	import apollo.scene.CApolloScene;
	import apollo.utils.CXYArray;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class CCameraController 
	{
		protected var _camera: CCamera;
		private var _isMoseDown: Boolean;
		private var _prevMouseX: int;
		private var _prevMouseY: int;
		
		public function CCameraController(camera: CCamera) 
		{
			_camera = camera;
			_isMoseDown = false;
		}
		
		public function setupListener(): void
		{
			CApolloScene.getInstance().stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
			CApolloScene.getInstance().stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove, false, 0, true);
			CApolloScene.getInstance().stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
		}
		
		private function onMouseDown(evt: MouseEvent): void
		{
			_isMoseDown = true;
			_prevMouseX = evt.stageX;
			_prevMouseY = evt.stageY;
		}
		
		private function onMouseMove(evt: MouseEvent): void
		{
			if (_isMoseDown)
			{
				var offsetMouseX: int = evt.stageX - _prevMouseX;
				var offsetMouseY: int = evt.stageY - _prevMouseY;
				var cameraCenter: CXYArray = _camera.center;
				cameraCenter.x -= offsetMouseX;
				cameraCenter.y -= offsetMouseY;
				_camera.center = cameraCenter;
				
				_prevMouseX = evt.stageX;
				_prevMouseY = evt.stageY;
			}
		}
		
		private function onMouseUp(evt: MouseEvent): void
		{
			_isMoseDown = false;
		}
	}

}