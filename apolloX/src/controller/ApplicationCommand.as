package controller
{
	import mediator.PromptMediator;
	import mediator.StageMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import controller.init.*;
	import controller.login.CreateStartMediatorCommand;
	import proxy.ServerListProxy;
	import view.PromptComponent;
	
	public class ApplicationCommand extends SimpleCommand
	{
		public function ApplicationCommand()
		{
			super();
		}
		
		override public function execute(notification: INotification): void
		{
			facade.registerCommand(LoadResourcesCommand.LOAD_RESOURCES_NOTE, LoadResourcesCommand);
			facade.registerCommand(CreateStartMediatorCommand.CREATE_LOGIN_VIEW_NOTE, CreateStartMediatorCommand);
			facade.registerCommand(LoadServerListCommand.LOAD_SERVERLIST_NOTE, LoadServerListCommand);
			
			var _main: Main = notification.getBody() as Main;
			
			facade.registerMediator(new StageMediator(_main));
			facade.registerMediator(new PromptMediator());
			
			facade.registerProxy(new ServerListProxy());
			
			CONFIG::DebugMode
			{
				trace("Main Loaded");
			}
			sendNotification(LoadResourcesCommand.LOAD_RESOURCES_NOTE);
		}
	}
}