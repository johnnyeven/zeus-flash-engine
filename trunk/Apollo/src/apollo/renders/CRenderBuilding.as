package apollo.renders 
{
	import apollo.controller.Action;
	import apollo.objects.CBuildingObject;
	import apollo.objects.CGameObject;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class CRenderBuilding extends CRender 
	{
		
		public function CRenderBuilding() 
		{
			super();
		}
		
		override public function render(o: CGameObject, force: Boolean = false): void
		{
			var c: CBuildingObject = o as CBuildingObject;
			var target: Point = c.controller.perception.scene.map.getScreenPosition(new Point(c.pos.x, c.pos.y));
			
			c.x = target.x;
			c.y = target.y;
			
			if (!force && c.staticUpdate)
			{
				return;
			}
			c.staticUpdate = true;
			
			super.render(c);
			draw(c, c.renderLine, c.renderFrame);
		}
	}

}