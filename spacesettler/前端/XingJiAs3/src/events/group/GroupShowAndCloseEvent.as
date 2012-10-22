package events.group
{
	import flash.events.Event;
	
	public class GroupShowAndCloseEvent extends Event
	{
		public static const CLOSE:String="close";
		
		public static const SHOW_LOOKMEMBER:String="show_lookmember";
		
		public static const SHOW_GROUPMANAGE:String="show_groupmanage";
		
		public static const SHOW_MEMBERMANAGE:String="show_membermanage";
		
		public static const SHOW_SHENHE_EVENT:String="show_shenhe_event";
		
		public function GroupShowAndCloseEvent(type:String)
		{
			super(type, false, false);
		}
	}
}