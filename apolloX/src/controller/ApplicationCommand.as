package controller
{
	import mediator.PromptMediator;
	import mediator.StageMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
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
			var _main: Main = notification.getBody() as Main;
			
			facade.registerMediator(new StageMediator(_main));
			facade.registerMediator(new PromptMediator());
			
			facade.registerProxy(new ServerListProxy());
			
			var _proxy: ServerListProxy = facade.retrieveProxy(ServerListProxy.NAME) as ServerListProxy;
			_proxy.getServerList();
			
			sendNotification(PromptMediator.PROMPT_SHOW_NOTE, "Main Loaded");
		}
	}
}