package Apollo.Controller 
{
	import Apollo.CGame;
	import Apollo.Display.CCamera;
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class CCameraController 
	{
		protected var _camera: CCamera;
		
		public function CCameraController() 
		{
			_camera = CGame.getInstance().camera;
		}
		
		public function setupListener(): void
		{
			
		}
	}

}