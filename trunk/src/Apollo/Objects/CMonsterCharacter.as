package Apollo.Objects 
{
	import Apollo.Controller.CBaseController;
	import Apollo.Controller.Action;
	
	/**
	 * ...
	 * @author john
	 */
	public class CMonsterCharacter extends CCharacterObject 
	{
		/**
		 * 是否是主动攻击怪
		 */
		protected var _passitiveMonster: Boolean;
		
		public function CMonsterCharacter(npcId: String, _ctrl: CBaseController = null, _direction: uint = CDirection.DOWN) 
		{
			super(_ctrl, _direction);
			objectId = npcId;
			_attackRange = 100;
			_attackSpeed = 0.7;
			
			//初始化脚本解释器
			//_script = new CScript(npcId, this, _ctrl.perception.scene);
		}
		
		public function set passitiveMonster(value: Boolean): void
		{
			_passitiveMonster = value;
		}
		
		public function get passitiveMonster(): Boolean
		{
			return _passitiveMonster;
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