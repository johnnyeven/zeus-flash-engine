package apollo.objects.effects 
{
	import apollo.events.SkillEvent;
	import apollo.objects.*;
	import apollo.controller.CBaseController;
	import apollo.scene.CBaseScene;
	import apollo.configuration.*;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author john
	 */
	public class CSingEffect extends CEffectObject 
	{
		/**
		 * 使用者
		 */
		protected var _master: CGameObject;
		protected var _skillId: String;
		protected var _target: * ;
		protected var _singTime: int;
		protected var _singBar: CSingBar;
		
		public function CSingEffect(_master: CGameObject, scene:CBaseScene, _skillId: String, _target: * = null, _ctrl:CBaseController=null, _direction:uint = CDirection.DOWN) 
		{
			super(scene, _ctrl, _direction);
			this._master = _master;
			this._skillId = _skillId;
			this._target = _target;
			setPos(new Point(_master.pos.x, _master.pos.y));
		}
		
		public function set singTime(value: int): void
		{
			var totalTime: Number = (_graphic.frameTotal / _graphic.fps) * 1000;
			_graphic.fps = _graphic.frameTotal / (value / 1000);
			
			if (value < totalTime)
			{
				_graphic.fps = _graphic.frameTotal / (value / 1000);
				updateFPS();
			}
			_singTime = GlobalContextConfig.Timer + value;
			
			_singBar = new CSingBar(_master as CActionObject, value);
		}
		
		public function get singTime(): int
		{
			return _singTime;
		}
		
		override protected function enterFrame(): Boolean
		{
			if (_graphic == null || _graphic.fps == 0)
			{
				return false;
			}
			else
			{
				if (GlobalContextConfig.Timer >= _singTime)
				{
					isPlayEnd = true;
				}
				if (GlobalContextConfig.Timer - _lastFrameTime > _playTime && !isPlayEnd)
				{
					_lastFrameTime = GlobalContextConfig.Timer;
					_prevFrame = _currentFrame;
					
					if (_currentFrame >= _totalFrame - 1)
					{
						_currentFrame = 0;
					}
					else
					{
						_currentFrame++;
					}
					_needChangeFrame = true;
				}
				return true;
			}
		}
		
		override public function setBufferPos(x: Number = NaN, y: Number = NaN): void
		{
			if (!isNaN(x) && !isNaN(y))
			{
				_renderBuffer.x = -x;
				_renderBuffer.y = -y;
			}
			else if (_graphic != null)
			{
				_renderBuffer.x = -_graphic.frameWidth / 2;
				_renderBuffer.y = -_graphic.frameHeight / 2;
			}
		}
		
		override protected function run(): void
		{
			_singBar.currentValue = _singTime - GlobalContextConfig.Timer;
			if (isPlayEnd)
			{
				_singBar.destroy();
				var event: SkillEvent = new SkillEvent(SkillEvent.SING_COMPLETED);
				event.data = new Object();
				event.data.target = _target;
				event.data.skillId = _skillId;
				dispatchEvent(event);
				_scene.removeObject(this);
			}
		}
	}

}