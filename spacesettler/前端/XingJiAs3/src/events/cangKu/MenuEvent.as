package events.cangKu
{
	import flash.events.Event;
	
	public class MenuEvent extends Event
	{
		public static const ADDMENU_EVENT:String="addMenuEvent";
		
		public function MenuEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}