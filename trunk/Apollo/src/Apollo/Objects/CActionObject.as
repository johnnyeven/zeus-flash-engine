package Apollo.Objects 
{
	import Apollo.Display.CCamera;
	import Apollo.Controller.CBaseController;
	import Apollo.Controller.Action;
	import Apollo.Center.CCommandCenter;
	import Apollo.Configuration.*;
	
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author john
	 */
	public class CActionObject extends CMovieObject 
	{
		protected var _action: uint;
		
		/**
		 * 跟随的对象
		 */
		private var _followObject: CActionObject;
		/**
		 * 跟随的距离
		 */
		private var _followDistance: Number;
		/**
		 * 跟随的方向
		 */
		private var _followDirection: uint;
		
		protected var _additionalDisplay: Array;
		
		protected var _deadDisappearTime: uint = 0;
		
		public function CActionObject(_ctrl:CBaseController = null, _direction:uint = CDirection.DOWN) 
		{
			super(_ctrl, _direction);
			_action = Action.STOP;
		}
		
		public function addAdditionalDisplay(o: DisplayObject): void
		{
			if (_additionalDisplay == null)
			{
				_additionalDisplay = new Array();
			}
			else
			{
				if (_additionalDisplay.indexOf(o) != -1)
				{
					return;
				}
			}
			_additionalDisplay.push(o);
			addChild(o);
		}
		
		public function removeAdditionalDisplay(o: DisplayObject): void
		{
			if (o == null)
			{
				for each (var i: int in _additionalDisplay)
				{
					if (_additionalDisplay[i] == o)
					{
						_additionalDisplay[i].clear();
						_additionalDisplay.splice(i, 1);
						removeChild(_additionalDisplay[i]);
						break;
					}
				}
			}
		}
		
		public function removeAdditionalDisplayById(id: int = -1): void
		{
			if (id == -1)
			{
				while (_additionalDisplay.length)
				{
					_additionalDisplay[0].clear();
					_additionalDisplay.splice(0, 1);
					removeChild(_additionalDisplay[0]);
				}
			}
			else
			{
				if (id > _additionalDisplay.length || _additionalDisplay[id] == null)
				{
					return;
				}
				else
				{
					_additionalDisplay[id].clear();
					_additionalDisplay.splice(id, 1);
					removeChild(_additionalDisplay[id]);
				}
			}
		}
		
		public function get additionalDisplay(): Array
		{
			return _additionalDisplay;
		}
		
		override protected function enterFrame(): Boolean
		{
			if (_graphic == null || _graphic.fps == 0)
			{
				return false;
			}
			else
			{
				if (_action == Action.STOP)
				{
					_currentFrame = Action.STOP;
					isPlayEnd = true;
					return false;
				}
				else if (_action == Action.SIT)
				{
					_currentFrame = Action.SIT;
					isPlayEnd = true;
					return false;
				}
				else if (_action == Action.DIE)
				{
					if (GlobalContextConfig.Timer - _lastFrameTime > _playTime && !isPlayEnd)
					{
						_lastFrameTime = GlobalContextConfig.Timer;
						_prevFrame = _currentFrame;
						
						var totalFrame: uint = _totalFrame > 14 ? 13 : _totalFrame - 1;
						if (_currentFrame >= totalFrame)
						{
							isPlayEnd = true;
						}
						else
						{
							_currentFrame++;
						}
					}
					return true;
				}
				else if (_action == Action.MOVE)
				{
					CCamera.needRefresh = true;
					if ((GlobalContextConfig.Timer - _lastFrameTime > _playTime) && !isPlayEnd)
					{
						_lastFrameTime = GlobalContextConfig.Timer;
						_prevFrame = _currentFrame;
						
						var total: uint = _totalFrame > 6 ? 5 : _totalFrame - 1;
						if (_currentFrame >= total)
						{
							isLoopPlay ? _currentFrame = 0 : isPlayEnd = true;
						}
						else
						{
							_currentFrame++;
						}
					}
					return true;
				}
				return true;
			}
		}
		
		override public function RenderObject(): void
		{
			if (_action == Action.DIE && isPlayEnd)
			{
				if (_deadDisappearTime > 0 && GlobalContextConfig.Timer > _deadDisappearTime)
				{
					if (alpha <= 0)
					{
						_controller.perception.scene.removeObject(this);
					}
					else
					{
						alpha -= .07;
					}
				}
			}
			super.RenderObject();
			if (_action == Action.DIE && _deadDisappearTime == 0 && GlobalContextConfig.deadRetainTime > 0)
			{
				_deadDisappearTime = GlobalContextConfig.Timer + GlobalContextConfig.deadRetainTime;
			}
		}
		
		public function set action(act: uint): void
		{
			if (_action == act)
			{
				return;
			}
			if (_action == Action.DIE && act != Action.RELIVE)
			{
				return;
			}
			if (act == Action.DIE)
			{
				canBeAttack = false;
			}
			else
			{
				//canBeAttack = true;
			}
			if (_action != act && act <= _graphic.frameTotal)
			{
				_currentFrame = act;
				needChangeFrame = true;
			}
			_action = act;
			if (_controller.perception.scene.player == this)
			{
				CCommandCenter.commandChangeAction(_action);
			}
			staticUpdate = false;
			
			setLoopPlay();
			updateFPS();
		}
		
		public function get action(): uint
		{
			return _action;
		}
		
		protected function setLoopPlay(): void
		{
			switch(_action)
			{
				case Action.DIE:
				case Action.RELIVE:
				case Action.SIT:
				case Action.STOP:
					loop = false;
					break;
				default:
					loop = true;
					break;
			}
		}
		
		override public function get currentFrame(): uint
		{
			switch(_action)
			{
				case Action.STOP:
					return 0;
					break;
				case Action.SIT:
					return 1;
					break;
				case Action.DIE:
				case Action.MOVE:
				case Action.RELIVE:
					return _currentFrame;
					break;
				default:
					return _currentFrame;
			}
		}
		
		/**
		 * 跟随某对象
		 */
		public function set follow(target: CActionObject): void
		{
			if (target != null)
			{
				_followObject = target;
				_followDistance = 40;
				_followDirection = target.direction;
				direction = target.direction;
			}
			else
			{
				_followObject = null;
			}
		}
		
		public function get follow(): CActionObject
		{
			return _followObject;
		}
		
		/**
		 * 跟随的方向
		 */
		public function get followDirection(): uint
		{
			return _followDirection;
		}
		
		public function set followDirection(value: uint): void
		{
			_followDirection = value;
		}
		
		/**
		 * 是否在跟随
		 */
		public function get isFollow(): Boolean
		{
			return (_followObject != null);
		}
		
		/**
		 * 跟随距离
		 */
		public function set followDistance(value: Number): void
		{
			_followDistance = value;
		}
		
		public function get followDistance(): Number
		{
			return _followDistance;
		}
	}

}