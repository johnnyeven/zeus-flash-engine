package events.battle.fight.fightMorePlayer
{
	import flash.events.Event;
	
	import vo.battle.fight.fightMorePlayer.FightZhanCheMaoYanVO;
	
	/**
	 * 战车冒烟特效
	 * @author lw
	 * 
	 */	
	public class FightZhanCheMaoYanEvent extends Event
	{
		public static const MAO_YAN_EVENT:String = "maoYanEvent";
		
		public var fightZhanCheMaoYanVO:FightZhanCheMaoYanVO;
		public function FightZhanCheMaoYanEvent(type:String,fightZhanCheMaoYanVO:FightZhanCheMaoYanVO)
		{
			super(type, false, false);
			this.fightZhanCheMaoYanVO = fightZhanCheMaoYanVO;
		}
		
		public override function clone():Event
		{
			return new FightZhanCheMaoYanEvent(type, fightZhanCheMaoYanVO);
		}
		
		public override function toString():String
		{
			return formatToString("FightZhanCheMaoYanEvent", "fightZhanCheMaoYanVO");
		}
	}
}