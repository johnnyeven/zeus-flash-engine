package Apollo.Network.Processor 
{
	import Apollo.Events.LoginEvent;
	import Apollo.Events.NetworkEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import Apollo.Configuration.*;
	import Apollo.CWoohaGame;
	import Apollo.Configuration.CharacterData;
	import Apollo.Configuration.SocketContextConfig;
	import Apollo.Network.Command.CCommandList;
	import Apollo.Network.Command.receiving.*;
	
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
			commandList.bind(0x0400, Receive_Info_RequestCharacter);
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
			if (protocol.success == SocketContextConfig.ACK_CONFIRM)
			{
				SocketContextConfig.server_ip = protocol.serverIP;
				SocketContextConfig.server_port = protocol.serverPort;
				SocketContextConfig.auth_key = protocol.authKey;
				CharacterData.AccountId = protocol.userId;
				
				commandCenter.dispatchEvent(new NetworkEvent(NetworkEvent.LOGIN_SUCCESS));
			}
			else
			{
				commandCenter.dispatchEvent(new NetworkEvent(NetworkEvent.LOGIN_FAIL));
			}
		}
		
		private function onCharacterData(protocol: Receive_Info_RequestCharacter): void
		{
			if (protocol.success == SocketContextConfig.ACK_CONFIRM)
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
			if (protocol.success == SocketContextConfig.ACK_CONFIRM)
			{
				CharacterData.UserName		=	protocol.characterName;
				CharacterData.Level			=	protocol.characterLevel;
				CharacterData.ResourceId	=	protocol.resourceId;
				CharacterData.Direction		=	protocol.direction;
				CharacterData.PosX			=	protocol.posX;
				CharacterData.PosY			=	protocol.posY;
				CharacterData.Speed			=	protocol.speed;
				CharacterData.HealthMax		=	protocol.healthMax;
				CharacterData.Health		=	protocol.health;
				CharacterData.ManaMax		=	protocol.manaMax;
				CharacterData.Mana			=	protocol.mana;
				CharacterData.EnergyMax		=	protocol.energyMax;
				CharacterData.Energy		=	protocol.energy;
				CharacterData.AttackRange	=	protocol.attackRange;
				CharacterData.AttackSpeed	=	protocol.attackSpeed;
				
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