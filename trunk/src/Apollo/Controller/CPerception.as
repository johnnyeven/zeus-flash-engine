package Apollo.Controller 
{
	import Apollo.Graphics.CGraphicCharacter;
	import Apollo.Objects.*;
	import Apollo.Objects.Effects.CEffectObject;
	import Apollo.Scene.CBaseScene;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author john
	 */
	public class CPerception 
	{
		/**
		 * 游戏主场景
		 */
		private var _scene: CBaseScene;
		/**
		 * 游戏对象宿主
		 */
		private var _currentObject: CGameObject;
		/**
		 * 被攻击的目标
		 */
		private var _attackTarget: CGameObject;
		
		public function CPerception(scene: CBaseScene) 
		{
			_scene = scene;
		}
		
		public function set currentObject(o: CGameObject): void
		{
			_currentObject = o;
		}
		
		public function get currentObject(): CGameObject
		{
			return _currentObject;
		}
		
		public function get scene(): CBaseScene
		{
			return _scene;
		}
		
		public function set attackTarget(o: CGameObject): void
		{
			_attackTarget = o;
		}
		
		public function get attackTarget(): CGameObject
		{
			return _attackTarget;
		}
		
		public function calcDistanceToTarget(target: CGameObject): Number
		{
			return Point.distance(_currentObject.pos, target.pos);
		}
		
		public function getNearestTarget(): CGameObject
		{
			return _scene.getCharacter(0);
		}
		
		/**
		 * 根据坐标距离返回碰撞目标
		 * @param	_targetPos
		 * @param	checkAttackable
		 * @param	checkDistance
		 * @return
		 */
		public function getTargetByPos(_targetPos: Point, checkAttackable:Boolean = false, checkDistance:uint = 15): CGameObject
		{
			var standbyArray: Array = _scene.renderList;
			var hitList: Array = new Array();
			for each(var o: CGameObject in standbyArray)
			{
				if (o == _scene.player || !o.inUse)
				{
					continue;
				}
				if (checkAttackable && !o.canBeAttack)
				{
					continue;
				}
				if (Point.distance(_targetPos, o.pos) < checkDistance)
				{
					hitList.push(o);
				}
			}
			if (hitList.length == 0)
			{
				return null;
			}
			hitList.sortOn("zIndex", Array.DESCENDING);
			return hitList[0];
		}
		
		/**
		 * 根据点击区域返回点击目标
		 * @param	_targetPos
		 * @param	checkAttackable
		 * @param	excludeCurrentObject
		 * @return
		 */
		public function getTargetByRect(_targetPos: Point, checkAttackable:Boolean = false, excludeCurrentObject: Boolean = true): CGameObject
		{
			var standbyArray: Array = _scene.renderList;
			var hitList: Array = new Array();
			for each(var o: CGameObject in standbyArray)
			{
				if (excludeCurrentObject && o == _scene.player)
				{
					continue;
				}
				if (!o.inUse)
				{
					continue;
				}
				if (checkAttackable && !o.canBeAttack)
				{
					continue;
				}
				if (o.hitTestPoint(_targetPos.x, _targetPos.y))
				{
					hitList.push(o);
				}
			}
			if (hitList.length == 0)
			{
				return null;
			}
			hitList.sortOn("zIndex", Array.DESCENDING);
			return hitList[0];
		}
		
		public function getTargetByGraphic(_targetPos: Point, checkAttackable:Boolean = false, excludeCurrentObject: Boolean = true): CGameObject
		{
			var standbyArray: Array = _scene.renderList;
			var hitList: Array = new Array();
			var x: Number, y:Number;
			var testInstance: BitmapData;
			
			for each(var o: CGameObject in standbyArray)
			{
				if (o is CEffectObject)
				{
					continue;
				}
				if (excludeCurrentObject && o == _scene.player)
				{
					continue;
				}
				if (!o.inUse)
				{
					continue;
				}
				if (checkAttackable && !o.canBeAttack)
				{
					continue;
				}
				if ((o as IAttackable).isDead)
				{
					continue;
				}
				x = int(_targetPos.x - (o.pos.x - (o.graphic.frameWidth / 2)));
				y = int(_targetPos.y - (o.pos.y - (o.graphic.frameHeight)));
				
				if (x > o.graphic.frameWidth || x < 0)
				{
					continue;
				}
				if (y > o.graphic.frameHeight || y < 0)
				{
					continue;
				}
				
				try
				{
					testInstance = o.graphic.bitmapArray[o.renderLine][o.renderFrame];
					if (testInstance.hitTest(new Point(), 0xFFFFFF, new Point(x, y)))
					{
						return o;
					}
				}
				catch (err: Error)
				{
					return null;
				}
			}
			return null;
		}
		
		/**
		 * 获取点击对象
		 * @param	x
		 * @param	y
		 * @return
		 */
		public function getClicker(x: Number, y: Number): CGameObject
		{
			var point: Point = _scene.map.getMapPosition(new Point(x, y));
			return getTargetByGraphic(point);
		}
	}

}