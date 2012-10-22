package events.battle.fight
{
    import flash.events.Event;
    
    import vo.battle.fight.FightLockVO;

    /**
     *锁定
     * @author zn
     *
     */
    public class FightLockEvent extends Event
    {
        public static const LOCK_EVENT:String = "lockEvent";

		public var fightLockVO:FightLockVO;
        public function FightLockEvent(type:String,fightLockVO:FightLockVO)
        {
            super(type, false, false);
			this.fightLockVO=fightLockVO;
        }

        public override function clone():Event
        {
            return new FightLockEvent(type, fightLockVO);
        }

        public override function toString():String
        {
            return formatToString("FightLockEvent", "fightLockVO");
        }
    }
}
