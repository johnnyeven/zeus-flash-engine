package events.scienceResearch
{
	import flash.events.Event;
	
	/**
	 *科研 弹出框
	 * @author lw
	 * 
	 */	
	public class SciencePopuEvent extends Event
	{
		public static const POPU_DATA_EVENT:String = "popuDataEvent";
		
		private var _data:Object;
		
		public function SciencePopuEvent(type:String, data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			_data = data;
		}

		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
		}

	}
}