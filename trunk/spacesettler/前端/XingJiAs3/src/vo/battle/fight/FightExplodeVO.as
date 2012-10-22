package vo.battle.fight
{
    import com.zn.net.socket.ClientSocket;
    
    import flash.utils.ByteArray;
    
    import ui.vo.ValueObject;
    
    import utils.battle.SocketUtil;

    /**
     *爆炸
     * @author zn
     *
     */
    public class FightExplodeVO extends ValueObject
    {
		/**
		 * 爆炸点
		 */
        public var x:Number = 0;

		/**
		 * 爆炸点
		 */
        public var y:Number = 0;

		/**
		 * 攻击者ID
		 */
        public var attacker_uid:String;

		/**
		 * 攻击者gid
		 */
        public var attacker_gid:int;

		/**
		 * 当前最小基础攻击
		 */
        public var current_min_attack:Number = 0;

		/**
		 * 当前最小基础攻击
		 */
        public var current_max_attack:Number = 0;

		/**
		 * 当前爆炸范围
		 */
        public var current_attack_area:Number = 0;

		/**
		 * 此次爆炸受影响的对象个数
		 */
        public var count:int;

		/**
		 * 详细列举具体对象信息
		 */		
		public var attack:Array=[];
		
		public function toBy():ByteArray
		{
			var body:ByteArray = ClientSocket.getBy();
			body.writeFloat(x);
			body.writeFloat(y);
			body.writeFloat(y);
//			SocketUtil.writeIdType(id, body);
//			body.writeUnsignedInt(attackType);
			
			return body;
		}
		
		public function toObj(by:ByteArray):void
		{
//			id = SocketUtil.readIdType(by);
//			startX = by.readFloat();
//			startY = by.readFloat();
//			endX = by.readFloat();
//			endY = by.readFloat();
//			attackType = by.readUnsignedInt();
//			attackID = SocketUtil.readIdType(by);
		}
    }
}
