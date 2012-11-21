package vo.battle.fight
{
	import com.zn.net.socket.ClientSocket;
	
	import enum.battle.FightCustomMessageTypeEnum;
	
	import flash.utils.ByteArray;
	
	import ui.vo.ValueObject;
	
	import utils.battle.SocketUtil;
	
	public class FightResurgenceVo extends ValueObject
	{	
		/**
		 *战车ID
		 */		
		public var idType:String="";
		
		public function toBy():ByteArray
		{
			var body:ByteArray = ClientSocket.getBy();
			body.writeUnsignedInt(FightCustomMessageTypeEnum.TYPE);
			SocketUtil.writeIdType(idType, body);
			body.writeUnsignedInt(FightCustomMessageTypeEnum.TIMEOUT);
			
			return body;
		}
		
		public function toObj(by:ByteArray):void
		{
			by.readUnsignedInt();
			idType = SocketUtil.readIdType(by);			
		}
	}
}