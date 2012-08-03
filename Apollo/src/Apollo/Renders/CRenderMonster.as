package Apollo.Renders 
{
	import Apollo.Controller.Action;
	import Apollo.Objects.CMonsterCharacter;
	import Apollo.Objects.CGameObject;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class CRenderMonster extends CRender 
	{
		
		public function CRenderMonster() 
		{
			super();
		}
		
		override public function render(o: CGameObject, force: Boolean = false): void
		{
			var c: CMonsterCharacter = o as CMonsterCharacter;
			var target: Point = c.controller.perception.scene.map.getScreenPosition(new Point(c.pos.x, c.pos.y));
			
			c.x = target.x;
			c.y = target.y;
			
			if (!force && c.staticUpdate && (c.action == Action.STOP || c.action == Action.SIT))
			{
				return;
			}
			c.staticUpdate = true;
			
			super.render(c);
			draw(c, c.renderLine, c.renderFrame);
		}
	}

}