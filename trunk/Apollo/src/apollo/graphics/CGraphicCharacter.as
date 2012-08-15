package apollo.graphics 
{
	import flash.display.BitmapData;
	
	import apollo.configuration.*;
	/**
	 * ...
	 * @author john
	 */
	public class CGraphicCharacter extends CGraphicResource implements IGetGraphics 
	{
		
		public function CGraphicCharacter() 
		{
			super();
			if (GlobalContextConfig.ResourcePool != null)
			{
				_bitmap = GlobalContextConfig.ResourcePool.getResource("character", "Default");
			}
		}
		
		/* INTERFACE com.Graphics.IGetGraphics */
		
		public function getResourceFromPool(resourceId:String, frameLine: uint = 1, frameTotal: uint = 1, fps: Number = 0): void 
		{
			if (GlobalContextConfig.ResourcePool != null)
			{
				getResource(GlobalContextConfig.ResourcePool.getResource("character", resourceId), frameLine, frameTotal, fps);
			}
		}
		
	}

}