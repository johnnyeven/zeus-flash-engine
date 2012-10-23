package utils.events
{
	import flash.events.Event;
	
	import utils.loader.ItemLoader;
	
	public class LoaderEvent extends Event
	{
		private var _loader: ItemLoader;
		private var _bytesLoaded: uint;
		private var _bytesTotal: uint;
		
		public static const PROGRESS: String = "loaderEvent.Progress";
		public static const IO_ERROR: String = "loaderEvent.IOError";
		public static const COMPLETE: String = "loaderEvent.Complete";
		public static const DISPOSE: String = "loaderEvent.Dispose";
		
		public function LoaderEvent(_type: String, _loader: ItemLoader = null, _bytesLoaded: uint = 0, _bytesTotal: uint = 0)
		{
			super(_type, false, false);
			this._loader = _loader;
			this._bytesLoaded = _bytesLoaded;
			this._bytesTotal = _bytesTotal;
		}
		
		public function get loader(): ItemLoader
		{
			return _loader;
		}
		
		public function get bytesLoaded(): uint
		{
			return _bytesLoaded;
		}
		
		public function get bytesTotal(): uint
		{
			return _bytesTotal;
		}
		
		override public function clone(): Event
		{
			return new LoaderEvent(type, loader, bytesLoaded, bytesTotal);
		}
	}
}