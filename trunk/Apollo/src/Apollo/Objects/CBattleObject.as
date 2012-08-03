package Apollo.Objects
{
	import Apollo.Controller.*;
	import Apollo.Objects.*;
	import Apollo.Objects.Effects.CBloodEffect;
	import Apollo.Configuration.*;
	import Apollo.Events.ControllerEvent;
	import Apollo.Scene.CApolloScene;
	
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author john
	 */
	public class CBattleObject extends CActionObject implements IAttackable 
	{
		protected var _attacker: *;
		protected var _health: Number;
		protected var _healthMax: Number;
		protected var _mana: Number;
		protected var _manaMax: Number;
		protected var _energy: Number;
		protected var _energyMax: Number;
		protected var _attackSpeed: Number;
		protected var _attackRange: Number;
		
		protected var _lastAttackTime: int;
		
		public function CBattleObject(_ctrl:CBaseController=null, _direction:uint=CDirection.DOWN) 
		{
			super(_ctrl, _direction);
		}

		/**
		 * 
		 * @param energy
		 */
		public function set energy(energy:Number): void
		{
			_energy = energy > _energyMax ? _energyMax : energy;
		}

		public function get energy(): Number
		{
			return _energy;
		}
		
		public function get attackCoolDown(): Number
		{
			return (1 / _attackSpeed) * 1000;
		}

		/**
		 * 
		 * @param energyMax
		 */
		public function set energyMax(energyMax:Number): void
		{
			_energyMax = energyMax > 0 ? energyMax : 0;
		}

		public function get energyMax(): Number
		{
			return _energyMax;
		}

		/**
		 * 
		 * @param health
		 */
		public function set health(health:Number): void
		{
			_health = health > _healthMax ? _healthMax : health;
		}

		public function get health(): Number
		{
			return _health;
		}

		/**
		 * 
		 * @param healthMax
		 */
		public function set healthMax(healthMax:Number): void
		{
			_healthMax = healthMax > 0 ? healthMax : 0;
		}

		public function get healthMax(): Number
		{
			return _healthMax;
		}

		/**
		 * 
		 * @param mana
		 */
		public function set mana(mana:Number): void
		{
			_mana = mana > _manaMax ? _manaMax : mana;
		}

		public function get mana(): Number
		{
			return _mana;
		}

		/**
		 * 
		 * @param manaMax
		 */
		public function set manaMax(manaMax:Number): void
		{
			_manaMax = manaMax > 0 ? manaMax : 0;
		}

		public function get manaMax(): Number
		{
			return _manaMax;
		}
		
		public function set attackSpeed(value: Number): void
		{
			_attackSpeed = value;
		}
		
		public function get attackSpeed(): Number
		{
			return _attackSpeed;
		}
		
		public function set attackRange(value: Number): void
		{
			_attackRange = value;
		}
		
		public function get attackRange(): Number
		{
			return _attackRange;
		}
		
		public function get attacker(): *
		{
			return _attacker;
		}
		
		public function set attacker(value: *): void
		{
			_attacker = value;
		}
		
		override protected function enterFrame(): Boolean
		{
			if (super.enterFrame())
			{
				if (_action == Action.ATTACK)
				{
					if ((GlobalContextConfig.Timer - _lastFrameTime > _playTime) && !isPlayEnd)
					{
						_lastFrameTime = GlobalContextConfig.Timer;
						_prevFrame = _currentFrame;
						
						var total: uint = _totalFrame > 10 ? 9 : _totalFrame - 1;
						if (_currentFrame >= total)
						{
							if (GlobalContextConfig.Timer - _lastAttackTime > attackCoolDown)
							{
								isLoopPlay ? _currentFrame = 0 : isPlayEnd = true;
								_lastAttackTime = GlobalContextConfig.Timer;
							}
							else
							{
								_currentFrame = total;
							}
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
			return false;
		}
		
		public function get attackerPosition(): Point
		{
			if (_attacker != null)
			{
				if (_attacker is CGameObject)
				{
					return (_attacker as CGameObject).pos;
				}
				else if (_attacker is Point)
				{
					return _attacker as Point;
				}
				else
				{
					trace(_attacker.toString());
				}
			}
			return null;
		}
		
		/* INTERFACE wooha.Objects.IAttackable */
		
		public function attack(): void
		{
			if (_attacker is CGameObject)
			{
				var c: CBattleObject = _attacker as CBattleObject;
				if (c == null || !c.canBeAttack)
				{
					return;
				}
			}
			action = Action.ATTACK;
			var speed: Number = 1000 / (_attackSpeed * 4);
			_playTime = _playTime > speed ? speed : _playTime;
			_lastAttackTime = GlobalContextConfig.Timer;
			if (_controller is CCharacterController)
			{
				(_controller as CCharacterController).lastAttackTime = GlobalContextConfig.Timer - attackCoolDown;
			}
		}
		
		public function underAttack(damage: Number): void
		{
			if (damage >= _health)
			{
				_health = 0;
				action = Action.DIE;
				_controller.clear();
			}
			else
			{
				_health -= damage;
			}
			var effect: CBloodEffect = new CBloodEffect(this, damage);
		}
		
		public function prepareAttack(o: *): void
		{
			if (o is CGameObject)
			{
				var c: CGameObject = o as CGameObject;
				if (c != null && c.canBeAttack)
				{
					_attacker = c;
				}
				else
				{
					return;
				}
			}
			else if (o is Point)
			{
				_attacker = o as Point;
			}
			var position: Point = attackerPosition;
			followDistance = _attackRange;
			if (Point.distance(position, _pos) <= _attackRange + 10)
			{
				attack();
			}
			else
			{
				_controller.addEventListener(ControllerEvent.MOVE_INTO_POSITION, moveIntoPosition);
				(_controller as IControllerMovable).moveKeepDistance(position.x, position.y, followDistance);
			}
		}
		
		protected function moveIntoPosition(event: ControllerEvent): void
		{
			_controller.removeEventListener(ControllerEvent.MOVE_INTO_POSITION, moveIntoPosition);
			if (_attacker != null)
			{
				attack();
			}
		}
		
		public function get isDead(): Boolean
		{
			return _action == Action.DIE;
		}
		
		public function get isInBattle(): Boolean
		{
			return (_attacker != null && _action == Action.ATTACK);
		}
		
	}

}