package Apollo.Objects.Effects 
{
	import Apollo.Objects.CGameObject;
	import Apollo.Scene.CBaseScene;
	import Apollo.Controller.CBaseController;
	import Apollo.Events.SkillEvent;
	import Apollo.Objects.CDirection;
	import Apollo.Display.CCamera;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author john
	 */
	public class CSkillEffect extends CEffectObject 
	{
		/**
		 * 是否已到达目标点
		 */
		protected var _isReachTarget: Boolean;
		/**
		 * 作用的目标
		 */
		protected var _target: *;
		/**
		 * 使用者
		 */
		protected var _master: CGameObject;
		/**
		 * 飞行角度
		 */
		protected var _angle: Number;
		/**
		 * 出发点
		 */
		protected var _startPos: Point;
		/**
		 * 落地点
		 */
		protected var _targetPos: Point;
		protected var _skillId: String;
		
		public function CSkillEffect(scene: CBaseScene, _skillId: String, _master: CGameObject, _target: * = null, _ctrl:CBaseController = null, _direction: uint = CDirection.DOWN) 
		{
			super(scene, _ctrl, _direction);
			if (_target == null)
			{
				throw new Error("target or targetPosition must be defined!");
			}
			if (_target is Point)
			{
				this._target = new Point((_target as Point).x, (_target as Point).y);
				this._targetPos = this._target as Point;
			}
			if (_target is CGameObject)
			{
				this._target = _target;
				this._targetPos = new Point((this._target as CGameObject).pos.x, (this._target as CGameObject).pos.y);
			}
			this._skillId = _skillId;
			this._master = _master;
			_isReachTarget = false;
			_startPos = new Point(_master.pos.x, _master.pos.y);
			_angle = CDirection.getRadians(_targetPos.x - _startPos.x, _targetPos.y - _startPos.y);
			setPos(_startPos);
			
			loop = false;
		}
		
		public function set targetPoint(point: Point): void
		{
			_targetPos = point;
			_angle = CDirection.getRadians(_targetPos.x - _startPos.x, _targetPos.y - _startPos.y);
		}
		
		override protected function run(): void
		{
			if (_isReachTarget && isPlayEnd)
			{
				_scene.removeObject(this);
				return;
			}
			else if (_isReachTarget)
			{
				return;
			}
			
			_pos.x += _speed * Math.cos(_angle);
			_pos.y += _speed * Math.sin(_angle);
			
			if (Point.distance(_pos, _targetPos) < _speed)
			{
				setPos(_targetPos);
				//hide
				hide();
				_speed = 0;
				//_master.controller.skillController.showExplode();
				_isReachTarget = true;
				var event: SkillEvent = new SkillEvent(SkillEvent.FIRE_COMPLETED);
				event.data = new Object();
				event.data.skillId = _skillId;
				event.data.target = _target;
				dispatchEvent(event);
				return;
			}
		}
		
		protected function hide(): void
		{
			visible = false;
		}
		
		protected function show(): void
		{
			visible = true;
		}
	}

}