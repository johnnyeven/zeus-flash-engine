package events.battle.fight
{
    import flash.events.Event;
    
    import vo.battle.fight.FightMoveVO;

    /**
     *战场移动
     * @author zn
     *
     */
    public class FightZhanCheMoveEvent extends Event
    {
        public static const ZHAN_CHE_MOVE_EVENT:String = "zhanCheMoveEvent";
		
		public var fightMoveVO:FightMoveVO;

        public function FightZhanCheMoveEvent(type:String, fightMoveVO:FightMoveVO)
        {
            super(type, true, true);

            this.fightMoveVO = fightMoveVO;
        }


		public override function clone():Event
		{
			return new FightZhanCheMoveEvent(type,fightMoveVO);
		}

		public override function toString():String
		{
			return formatToString("BattleFightZhanCheMoveEvent","fightMoveVO");
		}
    }
}
