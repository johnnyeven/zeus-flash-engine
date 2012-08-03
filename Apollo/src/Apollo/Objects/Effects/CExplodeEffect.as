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
	public class CExplodeEffect extends CEffectObject 
	{
		/**
		 * 作用的目标
		 */
		protected var _target: CGameObject;
		/**
		 * 使用者
		 */
		protected var _master: CGameObject;
		/**
		 * 落地点
		 */
		protected var _targetPos: Point;
		
		public function CExplodeEffect(scene: CBaseScene, _master: CGameObject, _target: * = null, _ctrl:CBaseController = null, _direction: uint = CDirection.DOWN) 
		{
			super(scene, _ctrl, _direction);
			if (_target == null)
			{
				throw new Error("target or targetPos must be defined!");
			}
			if (_target is Point)
			{
				this._targetPos = new Point((_target as Point).x, (_target as Point).y);
			}
			if (_target is CGameObject)
			{
				this._target = _target as CGameObject;
				this._targetPos = new Point(this._target.pos.x, this._target.pos.y);
			}
			this._master = _master;
			setPos(_targetPos);
			
			loop = false;
		}
		
		public function set targetPoint(point: Point): void
		{
			_targetPos = point;
			setPos(_targetPos);
		}
		
		override protected function run(): void
		{
			if (isPlayEnd)
			{
				_scene.removeObject(this);
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