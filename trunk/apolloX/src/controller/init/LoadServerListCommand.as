package controller.init
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import proxy.ServerListProxy;
	
	public class LoadServerListCommand extends SimpleCommand
	{
		public static const LOAD_SERVERLIST_NOTE: String = "LoadServerListCommand.loadServerListNote";
		
		public function LoadServerListCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var _proxy: ServerListProxy = facade.retrieveProxy(ServerListProxy.NAME) as ServerListProxy;
			_proxy.getServerList();
		}
	}
}