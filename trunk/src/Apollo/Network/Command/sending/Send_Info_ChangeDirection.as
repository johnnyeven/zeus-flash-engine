package Apollo.Network.Command.sending 
{
	import Apollo.Configuration.*;
	
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class Send_Info_ChangeDirection extends CNetPackageSending 
	{
		public var Direction: int;
		
		public function Send_Info_ChangeDirection() 
		{
			super(SocketContextConfig.CONTROLLER_INFO, SocketContextConfig.ACTION_CHANGE_DIRECTION);
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_byteArray.writeInt(CharacterData.Guid.length);
			_byteArray.writeByte(SocketContextConfig.TYPE_STRING);
			_byteArray.writeUTFBytes(CharacterData.Guid);
			
			_byteArray.writeInt(4);
			_byteArray.writeByte(SocketContextConfig.TYPE_INT);
			_byteArray.writeInt(Direction);
		}
	}

}