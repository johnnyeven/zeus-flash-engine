package enum.battle
{
	/**
	 * 战斗结束 投票类型
	 * @author lw
	 * 
	 */	
	public class BattleVoteTypeEnum
	{
	  /**
	   * 购买
	   */		
	  public static const VOTE_TYPE_BUY:int = 2;
	  /**
	   * 需要（0暗物质购买视为需要）
	   */
	  public static const VOTE_TYPE_NEED:int = 1;
	  /**
	   * 放弃
	   */
	  public static const VOTE_TYPE_GIVEUP:int = 0;
	}
}