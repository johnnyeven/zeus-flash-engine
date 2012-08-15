package apollo.graphics 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import apollo.controller.Action;
	import apollo.configuration.*;
	/**
	 * ...
	 * @author john
	 */
	public class CGraphicResource
	{
		/**
		 * 原始位图
		 */
		protected var _bitmap: BitmapData;
		/**
		 * 分解后的位图
		 */
		protected var _bitmapArray: Vector.<Vector.<BitmapData>>;
		/**
		 * 当前的动作
		 */
		protected var _currentAction: int = Action.STOP;
		/**
		 * 素材的行数，对于角色就是方向数
		 */
		protected var _frameLine: uint = 1;
		/**
		 * 动作的帧数
		 */
		protected var _frameTotal: uint = 1;
		/**
		 * 动作的帧频
		 */
		protected var _fps: Number = 0;
		/**
		 * 绘制的矩形区域大小
		 */
		private var _rect: Rectangle;
		/**
		 * 单元宽高
		 */
		private var _frameWidth: uint = 0;
		private var _frameHeight: uint = 0;
		
		public function CGraphicResource() 
		{
		}
		
		public function get bitmapArray(): Vector.<Vector.<BitmapData>>
		{
			return _bitmapArray;
		}
		
		public function get frameWidth(): uint
		{
			return _frameWidth;
		}
		
		public function get frameHeight(): uint
		{
			return _frameHeight;
		}
		
		public function set fps(value: Number): void
		{
			_fps = value;
		}
		
		public function get fps(): Number
		{
			return _fps;
		}
		
		public function get rect(): Rectangle
		{
			return _rect;
		}
		
		public function get frameTotal(): uint
		{
			return _frameTotal;
		}
		
		public function getResource(data: BitmapData, frameLine: uint = 1, frameTotal: uint = 1, fps:Number = 0): void
		{
			_frameLine = frameLine;
			_frameTotal = frameTotal;
			_frameWidth = int(data.width / _frameTotal);
			_frameHeight = int(data.height / _frameLine);
			_fps = fps;
			_bitmap = data;
			
			_bitmapArray = prepareBitmapArray();
		}
		
		/**
		 * 将大块的图片切成小片
		 * @return
		 */
		private function prepareBitmapArray(): Vector.<Vector.<BitmapData>>
		{
			if (_bitmap != null)
			{
				var bmArray: Vector.<Vector.<BitmapData>> = new Vector.<Vector.<BitmapData>>();
				for (var y: uint = 0; y < _frameLine; y++)
				{
					var line: Vector.<BitmapData> = new Vector.<BitmapData>();
					for (var x: uint = 0; x < _frameTotal; x++)
					{
						var bm: BitmapData = new BitmapData(_frameWidth, _frameHeight, true, 0x00000000);
						var rect: Rectangle = new Rectangle(x * _frameWidth, y * _frameHeight, _frameWidth, _frameHeight);
						bm.copyPixels(_bitmap, rect, new Point(), null, null, true);
						line.push(bm);
					}
					bmArray.push(line);
				}
				return bmArray;
			}
			else
			{
				return null;
			}
		}
		
		public function Render(target: Bitmap, line: uint, frame: uint): void
		{
			if (_bitmapArray == null)
			{
				target.bitmapData = _bitmap;
			}
			else
			{
				target.bitmapData = _bitmapArray[line][frame];
				_bitmap = _bitmapArray[line][frame];
			}
		}
		
		public function clear(): void
		{
			_bitmap = null;
			if (_bitmapArray != null)
			{
				_bitmapArray = null;
			}
		}
	}

}