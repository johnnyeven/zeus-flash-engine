package mediator
{
	import flash.text.TextField;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class TextMediator extends Mediator implements IMediator
	{
		public static const NAME: String = "TextMediator";
		
		public function TextMediator(viewComponent:TextField)
		{
			super(NAME, viewComponent);
		}
		/*
		override public function listNotificationInterests():Array
		{
			return [ApplicationFacade.CHANGE_TEXT];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.CHANGE_TEXT:
					controlObject.text = notification.getBody() as String;
					break;
			}
		}
		*/
		public function get controlObject(): TextField
		{
			return viewComponent as TextField;
		}
	}
}