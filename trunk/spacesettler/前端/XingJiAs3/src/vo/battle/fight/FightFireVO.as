package vo.battle.fight
{
    import com.zn.net.socket.ClientSocket;

    import flash.utils.ByteArray;

    import ui.vo.ValueObject;

    import utils.battle.SocketUtil;

    /**
     *开火
     * @author zn
     *
     */
    public class FightFireVO extends ValueObject
    {
        public static const PAO_TA:int = 1;

        public static const GUA_JIA:int = 2;

        /**
         *正在射击的chariot对象id
         */
        public var id:String;

        public var startX:Number = 0;

        public var startY:Number = 0;

        public var endX:Number = 0;

        public var endY:Number = 0;

        /**
         *攻击者类型
            1=炮塔
            2=挂件
         */
        public var attackType:int = PAO_TA;

        /**
         *挂件或炮台ID
         */
        public var attackID:String;

        public function toBy():ByteArray
        {
            var body:ByteArray = ClientSocket.getBy();
            SocketUtil.writeIdType(id, body);
            body.writeFloat(startX);
            body.writeFloat(startY);
            body.writeFloat(endX);
            body.writeFloat(endY);
            body.writeUnsignedInt(attackType);
            SocketUtil.writeIdType(attackID, body);

            return body;
        }

        public function toObj(by:ByteArray):void
        {
            id = SocketUtil.readIdType(by);
            startX = by.readFloat();
            startY = by.readFloat();
            endX = by.readFloat();
            endY = by.readFloat();
            attackType = by.readUnsignedInt();
            attackID = SocketUtil.readIdType(by);
        }
    }
}
