package Apollo.Network.Command.sending 
{
	import Apollo.Configuration.*;
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class Send_Battle_Attack extends CNetPackageSending 
	{
		public var TargetId: String;
		public var TargetX: int;
		public var TargetY: int;
		public var SkillId: String;
		
		public function Send_Battle_Attack() 
		{
			super(SocketContextConfig.CONTROLLER_BATTLE, SocketContextConfig.ACTION_ATTACK);
			TargetId = "";
			SkillId = "";
			TargetX = -1;
			TargetY = -1;
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_byteArray.writeInt(CharacterData.Guid.length);
			_byteArray.writeByte(SocketContextConfig.TYPE_STRING);
			_byteArray.writeUTFBytes(CharacterData.Guid);
			
			_byteArray.writeInt(TargetId.length);
			_byteArray.writeByte(SocketContextConfig.TYPE_STRING);
			_byteArray.writeUTFBytes(TargetId);
			
			_byteArray.writeInt(4);
			_byteArray.writeByte(SocketContextConfig.TYPE_INT);
			_byteArray.writeInt(TargetX);
			
			_byteArray.writeInt(4);
			_byteArray.writeByte(SocketContextConfig.TYPE_INT);
			_byteArray.writeInt(TargetY);
			
			_byteArray.writeInt(SkillId.length);
			_byteArray.writeByte(SocketContextConfig.TYPE_STRING);
			_byteArray.writeUTFBytes(SkillId);
		}
	}

}