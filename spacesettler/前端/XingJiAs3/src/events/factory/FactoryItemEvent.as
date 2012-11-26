package events.factory
{
	import flash.events.Event;
	
	import view.factory.FactoryItem_1Component;
	
	import vo.factory.DrawListVo;
	
	public class FactoryItemEvent extends Event
	{
		
		public static const ZHIZAO_COMPLETE_EVENT:String="zhizao_complete_event";
		
		public var drawListVo:DrawListVo;
		
		public function FactoryItemEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false,drawVo:DrawListVo=null)
		{
			super(type, bubbles, cancelable);
			drawListVo=drawVo;
		}
	}
}