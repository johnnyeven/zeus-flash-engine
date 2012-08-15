package apollo.objects.effects 
{
	import apollo.events.SkillEvent;
	import apollo.objects.CActionObject;
	import apollo.objects.CGameObject;
	import apollo.controller.CBaseController;
	import apollo.scene.CBaseScene;
	import apollo.objects.CDirection;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Point;
	import apollo.configuration.*;
	
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author john
	 */
	public class CRangeAttackEffect extends CEffectObject 
	{
		private var keyCode: int;
		
		public function CRangeAttackEffect(scene:CBaseScene, keyCode: int) 
		{
			super(scene, null, 0);
			this.keyCode = keyCode;
			setPos(scene.map.getMapPosition(new Point(scene.stage.mouseX, scene.stage.mouseY)));
			setupLisener();
		}
		
		protected function setupLisener(): void
		{
			scene.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected function onMouseMove(event: MouseEvent): void
		{
			setPos(scene.map.getMapPosition(new Point(event.stageX, event.stageY)));
		}
		
		protected function onClick(event: MouseEvent): void
		{
			event.stopImmediatePropagation();
			scene.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			removeEventListener(MouseEvent.CLICK, onClick);
			
			var evt: SkillEvent = new SkillEvent(SkillEvent.RANGE_SELECTED);
			evt.data = new Object();
			evt.data.keyCode = keyCode;
			evt.data.point = new Point(event.stageX, event.stageY);
			dispatchEvent(evt);
			destroy();
		}
		
		override protected function enterFrame(): Boolean
		{
			if (_graphic == null || _graphic.fps == 0)
			{
				return false;
			}
			else
			{
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
			/*
			if (isPlayEnd)
			{
				var event: SkillEvent = new SkillEvent(SkillEvent.SING_COMPLETED);
				event.data = new Object();
				dispatchEvent(event);
				_scene.removeObject(this);
			}
			*/
		}
	}

}