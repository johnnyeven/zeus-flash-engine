package apollo.center 
{
	import apollo.objects.CBuildingObject;
	import apollo.objects.CGameObject;
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Johnny.EVE
	 */
	public class CUICenter 
	{
		private var _menuList: Dictionary;
		private static var instance: CUICenter;
		private static var allowInstance: Boolean = false;
		
		public function CUICenter() 
		{
			if (!allowInstance)
			{
				throw new IllegalOperationError("CUICenter不允许实例化");
			}
			_menuList = new Dictionary();
		}
		
		public function init(): void
		{
			
		}
		
		public function getMenu(target: CGameObject): void
		{
			if (target is CBuildingObject)
			{
				var o: CBuildingObject = target as CBuildingObject;
			}
		}
		
		public static function getInstance(): CUICenter
		{
			if (instance == null)
			{
				allowInstance = true;
				instance = new CUICenter();
				allowInstance = false;
			}
			return instance;
		}
		
	}

}