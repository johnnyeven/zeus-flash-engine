package Apollo.Objects 
{
	import Apollo.Controller.CBaseController;
	import Apollo.Controller.Action;
	
	/**
	 * ...
	 * @author john
	 */
	public class COtherPlayerCharacter extends CCharacterObject
 
	{
		public function COtherPlayerCharacter(_ctrl: CBaseController = null, _direction: uint = CDirection.DOWN) 
		{
			super(_ctrl, _direction);
		}
		
		override protected function enterFrame(): Boolean
		{
			if (follow == null && _attacker != null)
			{
				follow = _attacker as CActionObject;
			}
			return super.enterFrame();
		}
	}

}