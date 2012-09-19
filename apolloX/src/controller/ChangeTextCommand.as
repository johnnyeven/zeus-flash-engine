package controller
{
	import mediator.TextMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ChangeTextCommand extends SimpleCommand
	{
		public function ChangeTextCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var txtMediator: TextMediator = facade.retrieveMediator(TextMediator.NAME) as TextMediator;
			txtMediator.controlObject.text = notification.getBody() as String;
			//(facade.retrieveMediator(TextMediator.NAME) as TextMediator).controlObject.text = notification.getBody() as String;
		}
	}
}