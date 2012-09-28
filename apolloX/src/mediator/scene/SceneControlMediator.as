package mediator.scene
{
	import mediator.StageMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.scene.SceneControlComponent;
	
	public class SceneControlMediator extends Mediator implements IMediator
	{
		public static const NAME: String = "SceneControlMediator";
		
		public function SceneControlMediator(viewComponent:Object=null)
		{
			super(NAME, new SceneControlComponent());
		}
		
		public function show(): void
		{
			stage.addChild(component);
		}
		
		private function get stage(): StageMediator
		{
			return facade.retrieveMediator(StageMediator.NAME) as StageMediator;
		}
		
		private function get component(): SceneControlComponent
		{
			return viewComponent as SceneControlComponent;
		}
	}
}