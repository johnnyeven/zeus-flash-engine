package controller
{
	import mediator.StageMediator;
	import mediator.PromptMediator;
	
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
			
			facade.registerMediator(new StageMediator(_main));
			facade.registerMediator(new PromptMediator());
			
			sendNotification(PromptMediator.PROMPT_SHOW_NOTE, "Main Loaded");
			sendNotification(PromptMediator.LOADING_SHOW_NOTE);
			
			//facade.registerCommand(ApplicationFacade.CHANGE_TEXT, ChangeTextCommand);
		}
	}
}