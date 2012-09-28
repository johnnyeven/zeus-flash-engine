package events.plantioid
{
    import flash.events.Event;
    import flash.geom.Point;

    /**
     *小行星带
     * @author zn
     *
     */
    public class PlantioidEvent extends Event
    {
        public static const MANAGER_EVENT:String = "managerEvent";

        public static const ATTACK_EVENT:String = "attackEvent";

        public static const FORCE_ATTACK_EVENT:String = "forceAttackEvent";

		public static const JUMP_EVENT:String="JUMP_EVENT";
		public static const MY_PLANT_EVENT:String="MY_PLANT_EVENT";
		
        private var _plantioidID:String;
        private var _jumpPoint:Point;
      

        public function PlantioidEvent(type:String, plantioidID:String = "",jumpPoint:Point=null)
        {
            super(type, true, true);

            this._plantioidID = plantioidID;
			this._jumpPoint=jumpPoint;
        }

        public function get plantioidID():String
        {
            return _plantioidID;
        }

        public override function clone():Event
        {
            return new PlantioidEvent(type, plantioidID,jumpPoint);
        }

        public override function toString():String
        {
            return formatToString("PlantioidEvent", "plantioidID","jumpPoint");
        }

		public function get jumpPoint():Point
		{
			return _jumpPoint;
		}

    }
}
