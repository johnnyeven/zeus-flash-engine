package apollo.objects.effects 
{
	import apollo.scene.CBaseScene;
	import apollo.Config;
	
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author john
	 */
	public class CMapEntrance extends CEffectObject 
	{
		/**
		 * 跳转的地图ID
		 */
		public var targetMapId: String;
		/**
		 * 目标X
		 */
		public var targetX: uint = 0;
		/**
		 * 目标Y
		 */
		public var targetY: uint = 0;
		
		private var checkFPS: uint = int(1000 / 3);
		private var lastCheck: uint = 0;
		private var lock: Boolean = false;
		
		public function CMapEntrance(scene:CBaseScene) 
		{
			super(scene);
			objectName = 'ROAD_POINT';
		}
		
		override protected function run(): void
		{
			super.run();
			if (!lock && Config.Timer - lastCheck > checkFPS && _scene.player != null)
			{
				lastCheck = Config.Timer;
				if (Point.distance(_scene.player.pos, pos) < 20)
				{
					//更换地图
					lock = true;
					trace("change map");
				}
			}
		}
		
		override protected function rebuild(): void
		{
			super.rebuild();
			_renderBuffer.x = -int(graphic.frameWidth / 2);
			_renderBuffer.y = -int(graphic.frameHeight / 2);
		}
		
		override public function RenderObject(): void
		{
			enterFrame();
			super.RenderObject();
		}
	}

}