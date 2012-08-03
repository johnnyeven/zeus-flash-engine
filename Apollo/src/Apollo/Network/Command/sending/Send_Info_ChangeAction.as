package Apollo.Network.Command.sending 
{
	import Apollo.Configuration.*;
	
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class Send_Info_ChangeAction extends CNetPackageSending 
	{
		public var Action: int;
		
		public function Send_Info_ChangeAction() 
		{
			super(SocketContextConfig.CONTROLLER_INFO, SocketContextConfig.ACTION_CHANGE_ACTION);
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_byteArray.writeInt(CharacterData.Guid.length);
			_byteArray.writeByte(SocketContextConfig.TYPE_STRING);
			_byteArray.writeUTFBytes(CharacterData.Guid);
			
			_byteArray.writeInt(4);
			_byteArray.writeByte(SocketContextConfig.TYPE_INT);
			_byteArray.writeInt(Action);
		}
	}

}