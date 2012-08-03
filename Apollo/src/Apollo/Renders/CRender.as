package Apollo.Renders 
{
	import Apollo.Objects.CGameObject;
	import Apollo.Objects.IFrameRender;
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class CRender 
	{
		private var _target: IFrameRender;
		
		public function CRender() 
		{
			
		}
		
		public function render(o: CGameObject, force: Boolean = false): void
		{
			return;
		}
		
		protected function draw(o: CGameObject, line: uint, frame: uint): void
		{
			try
			{
				_target = o as IFrameRender;
				if (_target != null)
				{
					o.graphic.Render(o.renderBuffer, line, frame);
					if (_target.needChangeFrame)
					{
						_target.needChangeFrame = false;
					}
				}
			}
			catch (err: Error)
			{
				
			}
		}
	}

}