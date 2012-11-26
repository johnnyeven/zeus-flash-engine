package events.battle.fight.fightMorePlayer
{
	import flash.events.Event;
	
	/**
	 * 战车复活
	 * @author rl
	 * 
	 */
	public class FightFuhuoEvent extends Event
	{
		public static const FU_HUO_EVENT:String = "fuHuoEvent";
		
		public function FightFuhuoEvent(type:String)
		{
			super(type, false,false);
		}
	}
}