package apollo.objects.effects 
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import apollo.controller.CBaseController;
	import apollo.objects.CDirection;
	import apollo.objects.CMovieObject;
	import apollo.objects.IRender;
	import apollo.scene.CBaseScene;
	
	/**
	 * ...
	 * @author john
	 */
	public class CEffectObject extends CMovieObject implements IRender 
	{
		protected var _scene: CBaseScene;
		protected var _colorPan: ColorTransform;
		protected var _buffer: BitmapData;
		protected var _alpha: Number = 1;
		/**
		 * 保留时间
		 */
		protected var _containTime: uint = 20;
		
		public function CEffectObject(scene: CBaseScene, _ctrl:CBaseController = null, _direction: uint = CDirection.DOWN) 
		{
			_scene = scene;
			_colorPan = new ColorTransform();
			canBeAttack = false;
			super(_ctrl , _direction);
		}
		
		/**
		 * 计算
		 */
		protected function run(): void
		{
			
		}
		
		override public function RenderObject(): void
		{
			run();
			super.RenderObject();
		}
		
		/* INTERFACE wooha.Objects.IRender */
		
		public function get scene():CBaseScene 
		{
			return _scene;
		}
		
		public function get rendPos():Point 
		{
			return new Point();
		}
		
		public function get colorPan():ColorTransform 
		{
			return _colorPan;
		}
		
		public function get shadow():CShadow 
		{
			return null;
		}
		
		public function get isOver():Boolean 
		{
			return false;
		}
		
		override public function destroy(event: Event = null): void
		{
			super.destroy(event);
			if (!inUse)
			{
				_scene.removeObject(this);
			}
			else
			{
				isMovingOut(this.destroy);
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
				_renderBuffer.y = -_graphic.frameHeight + 20;
			}
		}
	}

}