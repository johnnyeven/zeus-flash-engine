package Apollo.Network.Command.sending 
{
	import Apollo.Configuration.SocketContextConfig;
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class Send_Info_InitCharacter extends CNetPackageSending 
	{
		public var Guid: String;
		public var AuthKey: String;
		
		public function Send_Info_InitCharacter() 
		{
			super(SocketContextConfig.CONTROLLER_INFO, SocketContextConfig.ACTION_INIT_CHARACTER);
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_byteArray.writeInt(Guid.length);
			_byteArray.writeByte(SocketContextConfig.TYPE_STRING);
			_byteArray.writeUTFBytes(Guid);
			
			_byteArray.writeInt(AuthKey.length);
			_byteArray.writeByte(SocketContextConfig.TYPE_STRING);
			_byteArray.writeUTFBytes(AuthKey);
		}
	}

}