package controller
{
	import mediator.BtnMediator;
	import mediator.TextMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.PromptComponent;
	
	public class ApplicationCommand extends SimpleCommand
	{
		public function ApplicationCommand()
		{
			super();
		}
		
		override public function execute(notification: INotification): void
		{
			var _main: Main = notification.getBody() as Main;
			var prompt: PromptComponent = new PromptComponent();
			prompt.title = "Main Loaded";
			_main.addChild(prompt);
			//facade.registerMediator(new TextMediator(_main.txtReceiver));
			//facade.registerMediator(new BtnMediator(_main.btnSender));
			
			//facade.registerCommand(ApplicationFacade.CHANGE_TEXT, ChangeTextCommand);
		}
	}
}