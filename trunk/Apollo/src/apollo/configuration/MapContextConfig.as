package apollo.configuration 
{
	import apollo.utils.CXYArray;
	
	import flash.errors.IllegalOperationError;
	
	/**
	 * ...
	 * @author john
	 */
	public final class MapContextConfig 
	{
		/**
		 * 地图大小
		 */
		public static var MapSize: CXYArray = new CXYArray();
		/**
		 * 地图碎片大小
		 */
		public static var TileSize: CXYArray = new CXYArray();
		/**
		 * 地图碎片数量
		 */
		public static var TileNum: CXYArray = new CXYArray();
		/**
		 * 寻路格子大小
		 */
		public static var BlockSize: CXYArray = new CXYArray();
		/**
		 * 寻路格子数量
		 */
		public static var BlockNum: CXYArray = new CXYArray();
		/**
		 * 角色在进行斜方向移动时，在X轴上的速度修正量
		 */
		public static var xFixNum: Number;
		/**
		 * 角色在进行斜方向移动时，在Y轴上的速度修正量
		 */
		public static var yFixNum: Number;
		
		public function MapContextConfig() 
		{
			throw new IllegalOperationError("Config类不允许实例化");
		}
		
	}

}