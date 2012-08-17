package apollo.graphics 
{
	import flash.display.BitmapData;
	
	import apollo.configuration.*;
	/**
	 * ...
	 * @author john
	 */
	public class CGraphicBuilding extends CGraphicResource implements IGetGraphics 
	{
		
		public function CGraphicBuilding() 
		{
			super();
			if (GlobalContextConfig.ResourcePool != null)
			{
				_bitmap = GlobalContextConfig.ResourcePool.getResource("building", "Default");
			}
		}
		
		/* INTERFACE com.Graphics.IGetGraphics */
		
		public function getResourceFromPool(resourceId:String, frameLine: uint = 1, frameTotal: uint = 1, fps: Number = 0): void 
		{
			if (GlobalContextConfig.ResourcePool != null)
			{
				getResource(GlobalContextConfig.ResourcePool.getResource("building", resourceId), frameLine, frameTotal, fps);
			}
		}
		
	}

}