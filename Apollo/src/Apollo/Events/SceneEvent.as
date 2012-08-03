package Apollo.Events 
{
	/**
	 * ...
	 * @author john
	 */
	public class SceneEvent extends TransferEvent 
	{
		public static const SCENE_READY: String = 'scene_ready';
		public static const CAMERAVIEW_REFRESH: String = 'cameraview_refresh';
		public function SceneEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
	}

}