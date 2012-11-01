package utils
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;

	public class PopUpManager
	{
		public static var popUpIndex: Dictionary = new Dictionary();
		private static var _modeIndex: Dictionary = new Dictionary();
		private static var _modelNum: uint = 0;
		
		public function PopUpManager()
		{
		}
		
		public static function addPopUp(popUp: DisplayObject, mode: Boolean = false): void
		{
			if(popUpIndex[popUp])
			{
				return;
			}
			
			popUpIndex[popUp] = true;
			
			if(mode)
			{
				_modelNum += 1;
			}
			
			GameManager.instance.addPopUp(popUp);
		}
	}
}