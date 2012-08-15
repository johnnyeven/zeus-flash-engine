package apollo.display 
{
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import apollo.objects.CActionObject;
	import apollo.scene.CBaseScene;
	import apollo.utils.CXYArray;
	import apollo.controller.CCameraController;
	/**
	 * ...
	 * @author john
	 */
	public class CCamera 
	{
		/**
		 * 摄像机捕捉区域
		 */
		public static var cameraView: Rectangle;
		/**
		 * 是否需要更新
		 */
		public static var needRefresh: Boolean;
		/**
		 * 游戏主场景
		 */
		protected var _scene: CBaseScene;
		protected var _timer: Timer;
		protected var _moveSpeed: uint;
		
		private var _moveStart: Point;
		private var _moveEnd: Point;
		private var _moveAngle: Number;
		private var _moveCallback: Function;
		private var _controller: CCameraController;
		
		public function CCamera(scene: CBaseScene) 
		{
			_scene = scene;
			_moveSpeed = 100;
			_controller = new CCameraController(this);
			_controller.setupListener();
		}
		
		public function focus(target: CActionObject): void
		{
			if (target == null)
			{
				if (_scene.player == null)
				{
					return;
				}
				else
				{
					_scene.map.follow(_scene.player);
				}
			}
			else
			{
				_scene.map.follow(target);
			}
			_scene.refresh();
		}
		
		public function follower(): CActionObject
		{
			return _scene.map.follower;
		}
		
		public function get center(): CXYArray
		{
			return _scene.map.center;
		}
		
		public function set center(_center: CXYArray): void
		{
			_scene.map.center = _center;
			_scene.refresh();
		}
		
		public function get controller(): CCameraController
		{
			return _controller;
		}
		
		public function setCenterPos(x: uint, y: uint): void
		{
			var center: CXYArray = new CXYArray(x, y);
			_scene.map.center = center;
			_scene.refresh();
		}
		
		public function set moveSpeed(value: uint): void
		{
			_moveSpeed = value;
		}
		
		public function moveTo(x: uint, y: uint, callback: Function): void
		{
			if (_timer != null)
			{
				trace("Camera is now moving, you cant move again");
				return;
			}
			
			_moveCallback = callback;
			_moveStart = new Point(_scene.map.center.x, _scene.map.center.y);
			var p: CXYArray = _scene.map.pointToCenter(new CXYArray(x, y));
			_moveEnd = new Point(p.x, p.y);
			
			_timer = new Timer(10);
			_timer.addEventListener(TimerEvent.TIMER, moveCamera);
			_timer.start();
		}
		
		protected function moveCamera(event: TimerEvent): void
		{
			_moveStart.x += int((_moveEnd.x - _moveStart.x) / _moveSpeed);
			_moveStart.y += int((_moveEnd.y - _moveStart.y) / _moveSpeed);
			_scene.map.center = new CXYArray(_moveStart.x, _moveStart.y);
			_scene.refresh();
			trace(_moveSpeed);
			if (Point.distance(_moveStart, _moveEnd) < _moveSpeed * 2)
			{
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER, moveCamera);
				_timer = null;
				
				_scene.map.center = new CXYArray(_moveEnd.x, _moveEnd.y);
				
				_moveStart = null;
				_moveEnd = null;
				if (_moveCallback != null)
				{
					_moveCallback();
				}
			}
		}
	}

}