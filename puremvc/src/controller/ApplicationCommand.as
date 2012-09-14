package controller
{
	import mediator.BtnMediator;
	import mediator.TextMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ApplicationCommand extends SimpleCommand
	{
		public function ApplicationCommand()
		{
			super();
		}
		
		override public function execute(notification: INotification): void
		{
			var _main: Main = notification.getBody() as Main;
			facade.registerMediator(new TextMediator(_main.txtReceiver));
			facade.registerMediator(new BtnMediator(_main.btnSender));
		}
	}
}