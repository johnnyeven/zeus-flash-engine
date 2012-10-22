package vo.battle.fight
{
	import com.zn.net.socket.ClientSocket;
	
	import flash.utils.ByteArray;
	
	import ui.vo.ValueObject;
	
	import utils.battle.SocketUtil;
	
	public class FightLockVO extends ValueObject
	{
		/**
		 *发起或解除锁定的ID 
		 */		
		public var lockID:String;
		
		/**
		 *被锁定的ID 
		 */		
		public var lockedID:String="";
		
		public function toBy():ByteArray
		{
			var body:ByteArray = ClientSocket.getBy();
			SocketUtil.writeIdType(lockID, body);
			SocketUtil.writeIdType(lockedID, body);
			
			return body;
		}
		
		public function toObj(by:ByteArray):void
		{
			lockID = SocketUtil.readIdType(by);
			lockedID = SocketUtil.readIdType(by);
		}
	}
}