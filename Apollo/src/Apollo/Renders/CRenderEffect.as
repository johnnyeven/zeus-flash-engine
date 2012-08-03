package Apollo.Renders 
{
	import Apollo.Objects.CGameObject;
	import Apollo.Objects.Effects.CEffectObject;
	
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author john
	 */
	public class CRenderEffect extends CRender 
	{
		
		public function CRenderEffect() 
		{
			super();
		}
		
		override public function render(o: CGameObject, force: Boolean = false): void
		{
			var effect: CEffectObject = o as CEffectObject;
			if (effect.graphic.frameWidth == 0)
			{
				return;
			}
			
			var target: Point = effect.scene.map.getScreenPosition(o.pos);
			
			if (effect.colorPan != null)
			{
				//effect.graphic.bitmap.colorTransform(effect.graphic.bitmap.rect, effect.colorPan);
			}
			effect.x = target.x;
			effect.y = target.y;

			super.render(o);
			draw(o, o.renderLine, o.renderFrame);
		}
	}

}