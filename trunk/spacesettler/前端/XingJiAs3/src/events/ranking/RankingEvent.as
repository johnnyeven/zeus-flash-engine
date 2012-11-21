package events.ranking
{
	import flash.events.Event;
	
	public class RankingEvent extends Event
	{
		
		public static const CLOSE_ALL:String="close_btn";
		
		public static const CLOSE:String="close";
		
		public static const SHOW_PVE:String="show_pve";
		
		public static const SHOW_GEREN:String="show_geren";
		
		public static const SHOW_JUNTUAN:String="show_juntuan";
		
		public static const SHOW_YAOSAI:String="show_yaosai";
		
		public static const SHOW_CAIFU:String="show_caifu";
		
		public static const DAYLIST_REPUTATION:String="daylist_reputation";
		
		public static const DAYLIST_FORTERESS:String="daylist_forteress";
		
		public static const LIST_REPUTATION:String="list_reputation";
		
		public static const LIST_FORTERESS:String="list_forteress";
		
		public static const DAYLIST_MONEY:String="daylist_money";
		
		public static const LIST_MONEY:String="list_money";
		
		public static const DAYLIST_GROUP:String="daylist_group";
		
		public static const LIST_GROUP:String="list_group";
		
		public static const SHOW_JUNGUANZHENG_EVENT:String="show_junguanzheng_event"
		
		private var _type:String;
		
		public function RankingEvent(type:String,type1:String=null)
		{
			super(type, false, false);
			_type=type1;
		}

		override public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

	}
}