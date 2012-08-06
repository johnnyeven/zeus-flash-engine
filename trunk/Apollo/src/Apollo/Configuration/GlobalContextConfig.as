package Apollo.Configuration 
{
	import Apollo.Graphics.CGraphicPool;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	
	import flash.errors.IllegalOperationError;
	
	/**
	 * ...
	 * @author john
	 */
	public final class GlobalContextConfig 
	{
		public static var container: DisplayObjectContainer;
		public static var stage: Stage;
		/**
		 * 移动同步间隔（毫秒）
		 */
		public static var sync_trigger: uint = 1000;
		/**
		 * 场景刷新间隔（毫秒）
		 */
		public static var cameraview_trigger: uint = 1000;
		/**
		 * 舞台宽
		 */
		public static var Width: uint = 960;
		/**
		 * 舞台高
		 */
		public static var Height: uint = 640;
		/**
		 * 游戏计时器
		 */
		public static var Timer: uint;
		public static var ResourcePool: CGraphicPool;
		/**
		 * 死亡后尸体保留时间
		 */
		public static var deadRetainTime: uint = 10000;
		
		/**
		 * 配置文件目录
		 */
		public static const CONFIG_PATH: String = 'config/';
		/**
		 * 脚本目录
		 */
		public static const SCRIPT_PATH: String = 'scripts/';
		/**
		 * 资源目录
		 */
		public static const RESOURCE_PATH: String = 'resources/';
		/**
		 * 地图资源目录
		 */
		public static const MAP_RES_PATH: String = 'resources/maps/';
		/**
		 * 角色资源目录
		 */
		public static const CHAR_RES_PATH: String = 'resources/characters/';
		/**
		 * 工作平台
		 */
		public static const platform: String = WoohaPlatform.PLATFORM_IOS;
		
		public function GlobalContextConfig() 
		{
			throw new IllegalOperationError("Config类不允许实例化");
		}
	}

}