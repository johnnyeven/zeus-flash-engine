package utils.loader
{
	import flash.display.BitmapData;
	import flash.display.Loader;

	public class ImageLoader extends ItemLoader
	{
		private var _loader: Loader;
		private var _bitmapData: BitmapData;
		public var disposeAfterLoaded: Boolean = false;
		
		public function ImageLoader(url: String="", name: String="", loaderConfig: XML=null, disposeAfterLoaded: Boolean = false)
		{
			super(url, name, loaderConfig);
			this.disposeAfterLoaded = disposeAfterLoaded;
		}
	}
}