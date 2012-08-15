package apollo.graphics 
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author john
	 */
	public interface IGetGraphics
	{
		function getResourceFromPool(resourceId:String, frameLine: uint = 1, frameTotal: uint = 1, fps: Number = 0): void;
	}
	
}