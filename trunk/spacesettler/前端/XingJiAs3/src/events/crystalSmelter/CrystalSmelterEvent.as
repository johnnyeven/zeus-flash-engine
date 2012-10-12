package events.crystalSmelter
{
	import flash.events.Event;
	
	/**
	 * 熔炼（晶体冶炼厂）
	 * @author lw
	 *
	 */
	public class CrystalSmelterEvent extends Event
	{
		public static const CLOSE_EVENT:String = "closeEvent";
		
		public static const INFOR_EVENT:String = "inforEvent";
		
		public static const SMELTER_EVENT:String = "smelteEvent";
		
		public function CrystalSmelterEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}