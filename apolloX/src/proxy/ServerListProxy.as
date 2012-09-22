package proxy
{
	import mediator.PromptMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import utils.network.CCommandCenter;
	import utils.network.command.CCommandList;
	import utils.network.command.receiving.Receive_Server_ServerList;
	import utils.network.command.sending.Send_Server_ServerList;
	
	public class ServerListProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "ServerListProxy";
		
		public static const SERVER_LIST: int = 0x0001;
		
		public function ServerListProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		public function getServerList(): void
		{
			sendNotification(PromptMediator.LOADING_SHOW_NOTE);
			
			CCommandList.getInstance().bind(SERVER_LIST, Receive_Server_ServerList);
			CCommandCenter.getInstance().add(SERVER_LIST, onGetServerList);
			
			var protocol: Send_Server_ServerList = new Send_Server_ServerList();
			protocol.GameId = "B";
			
			CCommandCenter.getInstance().send(protocol);
		}
		
		private function onGetServerList(protocol: Receive_Server_ServerList): void
		{
			sendNotification(PromptMediator.LOADING_HIDE_NOTE);
			trace(protocol.ServerList);
		}
	}
}