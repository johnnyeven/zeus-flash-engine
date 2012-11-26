package events.groupFight
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import vo.groupFight.GroupFightVo;
	
	public class GroupFightEvent extends Event
	{
		public static const CLOSE_EVENT:String="close_event";
		
		public static const SURE_EVENT:String="sure_event";
		
		public static const JIDI_EVENT:String="jidi_event";
		
		public static const CHAKAN_EVENT:String="chakan_event";
		
		public static const SHUAXIN_EVENT:String="shuaxin_event";
		
		public static const GONGJI_EVENT:String="gongji_event";
		
		public static const PAIQIAN_EVENT:String="paiqian_event";
		
		public static const BACK_EVENT:String="back_event";
		
		public static const SENCE_EVENT:String="sence_event";
		
		public static const SENCECHANGE_EVENT:String="senceChange_event";
		
		public static const PLAY_COMPLETE_EVENT:String="play_complete_event";
		
		private var _warship_count:int;
		
		private var _point:Point;
		private var _point2:Point;
		private var _starVO:GroupFightVo;
		public function GroupFightEvent(type:String,warship_count:int=0,p:Point=null,p2:Point=null,info:GroupFightVo=null)
		{
			super(type, true, true);
			_warship_count=warship_count;
			
			_point=p;
			_point2=p2;
			_starVO=info;
		}

		public function get starVO():GroupFightVo
		{
			return _starVO;
		}

		public function set starVO(value:GroupFightVo):void
		{
			_starVO = value;
		}

		public function get point2():Point
		{
			return _point2;
		}

		public function set point2(value:Point):void
		{
			_point2 = value;
		}

		public function get point():Point
		{
			return _point;
		}

		public function set point(value:Point):void
		{
			_point = value;
		}

		public function get warship_count():int
		{
			return _warship_count;
		}

		public function set warship_count(value:int):void
		{
			_warship_count = value;
		}

	}
}