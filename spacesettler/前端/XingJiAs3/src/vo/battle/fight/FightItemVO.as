package vo.battle.fight
{
	import com.zn.net.Protocol;
	import com.zn.net.socket.ClientSocket;
	
	import flash.utils.ByteArray;
	
	import ui.vo.ValueObject;
	
	import utils.battle.SocketUtil;

	/**
	 *物品
	 * @author zn
	 *
	 */
	public class FightItemVO extends ValueObject
	{
		public var index:int;
		
		/**
		 *捡到物品的对象 
		 */		
		public var pickID:String;
		
		/**
		 *物品 唯一id
		 */
		public var uid:String;

		public function toBy():ByteArray
		{
			var body:ByteArray=ClientSocket.getBy();
			body.writeUnsignedInt(index);
			SocketUtil.writeIdType(pickID, body);
			Protocol.writeByStr(uid,body);

			return body;
		}

		public function toObj(by:ByteArray):void
		{
			index=by.readUnsignedInt();
			pickID=SocketUtil.readIdType(by);
			uid=Protocol.readByStr(by);
		}
	}
}
