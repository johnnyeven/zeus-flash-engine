package vo.battle.fight
{
	import com.zn.net.socket.ClientSocket;
	
	import enum.battle.FightCustomMessageTypeEnum;
	
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
		
		/**
		 *原来被锁定的对象，用于取消锁定 
		 */		
		public var oldLocked:String="";
		
		public function toBy():ByteArray
		{
			var body:ByteArray = ClientSocket.getBy();
			body.writeUnsignedInt(FightCustomMessageTypeEnum.LOCK);
			SocketUtil.writeIdType(lockID, body);
			SocketUtil.writeIdType(lockedID, body);
			SocketUtil.writeIdType(oldLocked, body);
			
			return body;
		}
		
		public function toObj(by:ByteArray):void
		{
			lockID = SocketUtil.readIdType(by);
			lockedID = SocketUtil.readIdType(by);
			oldLocked = SocketUtil.readIdType(by);
		}
	}
}