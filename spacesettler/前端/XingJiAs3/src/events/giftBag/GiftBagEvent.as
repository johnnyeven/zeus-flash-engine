package events.giftBag
{
	import flash.events.Event;
	
	public class GiftBagEvent extends Event
	{
		public static const CLOSEVIEW_EVENT:String="closeView_event";
		
		public static const GIFTITEM_EVENT:String="giftItem_event";
		
		public static const GETGIFT_EVENT:String="getGift_event";
		
		private var _itemType:int;
		public function GiftBagEvent(type:String, num:int=0, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			_itemType=num;
		}

		public function get itemType():int
		{
			return _itemType;
		}

		public function set itemType(value:int):void
		{
			_itemType = value;
		}

	}
}