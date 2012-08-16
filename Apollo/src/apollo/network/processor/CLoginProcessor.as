package apollo.network.processor 
{
	import apollo.events.LoginEvent;
	import apollo.events.NetworkEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import apollo.configuration.*;
	import apollo.network.command.CCommandList;
	import apollo.network.command.receiving.*;
	
	/**
	 * ...
	 * @author john
	 */
	public class CLoginProcessor extends CBaseProcessor 
	{
		
		public function CLoginProcessor() 
		{
			super("Processor.LoginProcessor");
			var commandList: CCommandList = CCommandList.getInstance();
			commandList.bind(0x0100, Receive_Info_Login);
			commandList.bind(0x0400, Receive_Info_RequestAccountId);
			commandList.bind(0x0600, Receive_Info_InitCharacter);
		}
		
		override public function hook():void 
		{
			commandCenter.add(0x0100, onLogin);
			commandCenter.add(0x0400, onCharacterData);
			commandCenter.add(0x0600, onCharacterInit);
		}
		
		override public function unhook():void 
		{
			commandCenter.remove(0x0100, onLogin);
			commandCenter.remove(0x0400, onCharacterData);
			commandCenter.remove(0x0600, onCharacterInit);
		}
		
		private function onLogin(protocol: Receive_Info_Login): void
		{
			if (protocol.message == ConnectorContextConfig.ACK_CONFIRM)
			{
				CharacterData.Guid = protocol.GUID;
				commandCenter.dispatchEvent(new NetworkEvent(NetworkEvent.LOGIN_SUCCESS));
			}
			else
			{
				commandCenter.dispatchEvent(new NetworkEvent(NetworkEvent.LOGIN_FAIL));
			}
		}
		
		private function onCharacterData(protocol: Receive_Info_RequestAccountId): void
		{
			if (protocol.message == ConnectorContextConfig.ACK_CONFIRM)
			{
				var event: NetworkEvent = new NetworkEvent(NetworkEvent.REQUEST_CHARACTER);
				event.data = protocol;
				commandCenter.dispatchEvent(event);
			}
			else
			{
				
			}
		}
		
		private function onCharacterInit(protocol: Receive_Info_InitCharacter): void
		{
			if (protocol.message == ConnectorContextConfig.ACK_CONFIRM)
			{
				
				
				if (CharacterData.isCharacterAvailable())
				{
					commandCenter.dispatchEvent(new LoginEvent(LoginEvent.CHARACTER_INIT));
				}
			}
			else
			{
				
			}
		}
	}

}