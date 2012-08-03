package Apollo.Renders 
{
	import Apollo.Objects.CGameObject;
	import Apollo.Objects.CCharacterObject;
	import Apollo.Controller.Action;
	import Apollo.Configuration.*;
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class CRenderCharacter extends CRender 
	{
		
		public function CRenderCharacter() 
		{
			super();
		}
		
		override public function render(o: CGameObject, force: Boolean = false): void
		{
			var character: CCharacterObject = o as CCharacterObject;
			if (!force && character.staticUpdate && (character.action == Action.STOP || character.action == Action.SIT))
			{
				return;
			}
			
			var targetX: Number = 0;
			var targetY: Number = 0;
			
			var maxX: uint = MapContextConfig.MapSize.x;
			var maxY: uint = MapContextConfig.MapSize.y;
			
			if (character.beFocus)
			{
				targetX = character.pos.x < GlobalContextConfig.Width / 2 ? character.pos.x : GlobalContextConfig.Width / 2;
				targetY = character.pos.y < GlobalContextConfig.Height / 2 ? character.pos.y : GlobalContextConfig.Height / 2;
				
				targetX = character.pos.x > (maxX - GlobalContextConfig.Width / 2) ? character.pos.x - (maxX - GlobalContextConfig.Width) : targetX;
				targetY = character.pos.y > (maxY - GlobalContextConfig.Height / 2) ? character.pos.y - (maxY - GlobalContextConfig.Height) : targetY;
			}
			else
			{
				targetX = character.pos.x;
				targetY = character.pos.y;
			}
			
			character.x = targetX;
			character.y = targetY;
			
			character.staticUpdate = true;
			
			super.render(o);
			draw(o, o.renderLine, o.renderFrame);
		}
	}

}