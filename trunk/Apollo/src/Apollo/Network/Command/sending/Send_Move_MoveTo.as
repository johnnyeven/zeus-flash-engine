package Apollo.Network.Command.sending 
{
	import Apollo.Configuration.*;
	import Apollo.Network.CNetConnection;
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class Send_Move_MoveTo extends CNetPackageSending 
	{
		public var TargetX: int;
		public var TargetY: int;
		
		public function Send_Move_MoveTo() 
		{
			super(CNetConnection.CONTROLLER_MOVE, CNetConnection.ACTION_MOVETO);
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_byteArray.writeInt(CharacterData.Guid.length);
			_byteArray.writeByte(CNetConnection.TYPE_STRING);
			_byteArray.writeUTFBytes(CharacterData.Guid);
			
			_byteArray.writeInt(4);
			_byteArray.writeByte(CNetConnection.TYPE_INT);
			_byteArray.writeInt(TargetX);
			
			_byteArray.writeInt(4);
			_byteArray.writeByte(CNetConnection.TYPE_INT);
			_byteArray.writeInt(TargetY);
		}
	}

}