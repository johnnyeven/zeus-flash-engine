package apollo.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author john
	 */
	public class MapEvent extends Event 
	{
		public static const MAP_DATA_LOADED: String = 'map_data_loaded';
		public static const MAP_LOADED: String = 'map_loaded';
		public static const MAP_CHANGE: String = 'map_change';
		public var mapId: String;
		public var startX: uint;
		public var startY: uint;
		public function MapEvent(type:String, mapId: String = null, startX: uint = 0, startY: uint = 0, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			this.mapId = mapId;
			this.startX = startX;
			this.startY = startY;
			super(type, bubbles, cancelable);
		}
		
	}

}