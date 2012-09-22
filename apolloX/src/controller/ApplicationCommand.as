package controller
{
	import mediator.PromptMediator;
	import mediator.StageMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import controller.init.LoadResourcesCommand;
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
			
			var _main: Main = notification.getBody() as Main;
			
			facade.registerMediator(new StageMediator(_main));
			facade.registerMediator(new PromptMediator());
			
			facade.registerProxy(new ServerListProxy());
			
			CONFIG::DebugMode
			{
				sendNotification(PromptMediator.PROMPT_SHOW_NOTE, "Main Loaded");
			}
			sendNotification(LoadResourcesCommand.LOAD_RESOURCES_NOTE);
			
			var _proxy: ServerListProxy = facade.retrieveProxy(ServerListProxy.NAME) as ServerListProxy;
			_proxy.getServerList();
		}
	}
}