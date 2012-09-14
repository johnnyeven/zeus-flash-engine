package mediator
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class BtnMediator extends Mediator implements IMediator
	{
		public static const NAME: String = "ButtonMediator";
		
		public function BtnMediator(viewComponent:Sprite)
		{
			super(NAME, viewComponent);
			controlObject.addEventListener(MouseEvent.CLICK, onButtonClick);
		}
		
		private function onButtonClick(evt: MouseEvent): void
		{
			sendNotification(ApplicationFacade.CHANGE_TEXT, "test");
		}
		
		private function get controlObject(): Sprite
		{
			return viewComponent as Sprite;
		}
	}
}