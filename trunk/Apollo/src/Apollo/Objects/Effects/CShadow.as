package Apollo.Objects.Effects 
{
	import Apollo.Objects.CGameObject;
	import Apollo.Maps.CWorldMap;
	import Apollo.utils.CXYArray;
	import Apollo.Configuration.*;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author john
	 */
	public class CShadow 
	{
		public var yOffset: Number = 0;
		protected var _alpha: Number = 0;
		protected var _resource: Bitmap;
		protected var _target: CGameObject;
		
		public function CShadow(target:CGameObject, yOffset: Number = 0, zoom: Number = .8, alpha: Number = .6)
		{
			this.yOffset = yOffset;
			_alpha = alpha;
			_target = target;
			
			build(target.graphic.frameWidth * zoom);
		}
		
		protected function build(widthZoom: Number): void
		{
			widthZoom = int(widthZoom);
			
			if (GlobalContextConfig.ResourcePool.getResource("utility", "shadow_" + widthZoom) == null)
			{
				var shape: Shape = new Shape();
				var matrix: Matrix = new Matrix();
				matrix.createGradientBox(widthZoom, widthZoom);
				shape.graphics.beginGradientFill(GradientType.RADIAL, [0, 0], [_alpha, 0], [127, 255], matrix);
				shape.graphics.drawRect(0, 0, widthZoom, widthZoom);
				shape.graphics.endFill();
				
				var buffer: BitmapData = new BitmapData(shape.width, shape.height, true, 0x00000000);
				buffer.draw(shape, new Matrix(1, 0, 0, .3));
				shape.graphics.clear();
				shape = null;
				
				GlobalContextConfig.ResourcePool.addResource("shadow_" + widthZoom, buffer);
			}
			
			_resource = new Bitmap(GlobalContextConfig.ResourcePool.getResource("utility", "shadow_" + widthZoom));
			_resource.x = -_resource.width * .5;
			_resource.y = yOffset;
			_target.addChild(_resource);
			_target.setChildIndex(_resource, 0);
		}
	}

}