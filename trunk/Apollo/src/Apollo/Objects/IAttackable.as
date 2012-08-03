package Apollo.Objects 
{
	
	/**
	 * ...
	 * @author john
	 */
	public interface IAttackable 
	{
		function attack(): void;
		function underAttack(damage: Number): void
		/**
		 * 检查距离是否在有效攻击范围内，如果不在范围内需要走过去
		 * @param	o
		 */
		function prepareAttack(o: *): void;
		function get isDead(): Boolean;
		function get isInBattle(): Boolean;
	}
	
}