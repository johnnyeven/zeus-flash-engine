package events.allView
{
	import flash.events.Event;
	
	public class ShopEvent extends Event
	{
		/**
		 *购买资源 
		 */		
		public static const BUY_RESOURCE:String="buy_resource";
		
		/**
		 *购买暗晶 
		 */		
		public static const BUY_DARK_CRYSTAL:String="buy_dark_crystal";
		
		/**
		 *购买道具 
		 */		
		public static const BUY_ITEM:String="buy_item";
		
		private var _num:int;		
		private var _resourceName:String;
		public function ShopEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false,num:int=0,name:String=null)
		{
			super(type, bubbles, cancelable);
			_num=num;
			_resourceName=name;
		}

		public function get num():int
		{
			return _num;
		}

		public function set num(value:int):void
		{
			_num = value;
		}

		public function get resourceName():String
		{
			return _resourceName;
		}

		public function set resourceName(value:String):void
		{
			_resourceName = value;
		}


	}
}