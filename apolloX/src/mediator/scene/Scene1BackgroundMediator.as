package mediator.scene
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.scene.Scene1BackgroundComponent;
	
	import mediator.StageMediator;
	
	public class Scene1BackgroundMediator extends Mediator implements IMediator
	{
		public static const NAME: String = "Scene1BackgroundMediator";
		
		public function Scene1BackgroundMediator(viewComponent:Object=null)
		{
			super(NAME, new Scene1BackgroundComponent());
		}
		
		private function get stage(): StageMediator
		{
			return facade.retrieveMediator(StageMediator.NAME) as StageMediator;
		}
		
		private function get component(): Scene1BackgroundComponent
		{
			return viewComponent as Scene1BackgroundComponent;
		}
		
		public function show(): void
		{
			stage.addChild(component);
		}
	}
}