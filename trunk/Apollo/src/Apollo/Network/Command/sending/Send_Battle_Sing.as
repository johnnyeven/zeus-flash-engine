package Apollo.Network.Command.sending 
{
	import Apollo.Configuration.*;
	import Apollo.Objects.CGameObject;
	import flash.geom.Point;
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class Send_Battle_Sing extends CNetPackageSending 
	{
		public var PlayerId: String;
		public var SkillId: String;
		public var SkillLevel: int;
		public var Direction: int;
		public var Target: *;
		
		public function Send_Battle_Sing() 
		{
			super(SocketContextConfig.CONTROLLER_BATTLE, SocketContextConfig.ACTION_SING);
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_byteArray.writeInt(CharacterData.Guid.length);
			_byteArray.writeByte(SocketContextConfig.TYPE_STRING);
			_byteArray.writeUTFBytes(CharacterData.Guid);
			
			_byteArray.writeInt(SkillId.length);
			_byteArray.writeByte(SocketContextConfig.TYPE_STRING);
			_byteArray.writeUTFBytes(SkillId);
			
			_byteArray.writeInt(4);
			_byteArray.writeByte(SocketContextConfig.TYPE_INT);
			_byteArray.writeInt(SkillLevel);
			
			_byteArray.writeInt(4);
			_byteArray.writeByte(SocketContextConfig.TYPE_INT);
			_byteArray.writeInt(Direction);
			
			if (Target is CGameObject)
			{
				var o: CGameObject = Target as CGameObject;
				_byteArray.writeInt(o.objectId.length);
				_byteArray.writeByte(SocketContextConfig.TYPE_STRING);
				_byteArray.writeUTFBytes(o.objectId);
			
				_byteArray.writeInt(4);
				_byteArray.writeByte(SocketContextConfig.TYPE_INT);
				_byteArray.writeInt(o.pos.x);
			
				_byteArray.writeInt(4);
				_byteArray.writeByte(SocketContextConfig.TYPE_INT);
				_byteArray.writeInt(o.pos.y);
			}
			else if (Target is Point)
			{
				var p: Point = Target as Point;
				
				_byteArray.writeInt(0);
				_byteArray.writeByte(SocketContextConfig.TYPE_STRING);
				_byteArray.writeUTFBytes("");
			
				_byteArray.writeInt(4);
				_byteArray.writeByte(SocketContextConfig.TYPE_INT);
				_byteArray.writeInt(p.x);
			
				_byteArray.writeInt(4);
				_byteArray.writeByte(SocketContextConfig.TYPE_INT);
				_byteArray.writeInt(p.y);
			}
		}
	}

}