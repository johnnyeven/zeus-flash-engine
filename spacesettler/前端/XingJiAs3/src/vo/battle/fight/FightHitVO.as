package vo.battle.fight
{
	import com.zn.net.socket.ClientSocket;

	import flash.utils.ByteArray;

	import utils.battle.SocketUtil;

	/**
	 *伤害
	 * @author zn
	 *
	 */
	public class FightHitVO
	{
		/**
		 *HBC_TYPE_CHARIOT=0 chariot     HBC_TYPE_FORTBUILDING=1 building
		 */
		public var type:int;

		public var id:String;

		/**
		 * 当前耐久值
		 */		
		public var current_endurance:Number=0;

		/**
		 * 当前护盾值
		 */
		public var current_shield:Number=0;

		public function toBy():ByteArray
		{
			var body:ByteArray=ClientSocket.getBy();
			body.writeUnsignedInt(type);
			SocketUtil.writeIdType(id, body);
			body.writeFloat(current_endurance);
			body.writeFloat(current_shield);

			return body;
		}

		public function toObj(by:ByteArray):void
		{
			type=by.readUnsignedInt();
			id=SocketUtil.readIdType(by);
			current_endurance=by.readFloat();
			current_shield=by.readFloat();
		}
	}
}
