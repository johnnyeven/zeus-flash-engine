package vo.battle.fight
{
    import com.zn.net.socket.ClientSocket;
    import com.zn.utils.RotationUtil;

    import flash.geom.Point;
    import flash.utils.ByteArray;

    import ui.vo.ValueObject;

    import utils.battle.SocketUtil;

    /**
     * 战车移动
     * @author zn
     *
     */
    public class FightMoveVO extends ValueObject
    {
        /**
         * 对象ID，当前应该为chariot编号
         */
        public var zhanCheID:String;

        /**
         * 出发点坐标
         */
        public var startPoint:Point = new Point();

        /**
         * 角度
         */
        public var angle:Number = 0;

        /**
         * 速度
         */
        public var speed:Number = 0;

        /**
         * 目标点坐标
         */
        public var endPoint:Point = new Point();

        /**
         * 客户端发送移动可以不填写，服务器返回的结构此处表示距离此次移动已过去的时间ms
         */
        public var durationTime:int;

        public function toBy():ByteArray
        {
            var body:ByteArray = ClientSocket.getBy();
            SocketUtil.writeIdType(zhanCheID, body); //攻击者id
            body.writeFloat(startPoint.x); //出发点坐标
            body.writeFloat(startPoint.y); //出发点坐标
            body.writeFloat(angle); //角度
            body.writeFloat(speed); //速度
            body.writeFloat(endPoint.x); //目标点坐标
            body.writeFloat(endPoint.y);

            body.writeInt(0); //客户端发送移动可以不填写，服务器返回的结构此处表示距离此次移动已过去的时间ms
            return body;
        }

        public function toObj(by:ByteArray):void
        {
            zhanCheID = SocketUtil.readIdType(by);
            startPoint.x = by.readFloat();
            startPoint.y = by.readFloat();
            angle = by.readFloat();
            speed = by.readFloat();
            endPoint.x = by.readFloat();
            endPoint.y = by.readFloat();
            durationTime = by.readUnsignedInt();

			//计算开始位置
            if (durationTime != 0)
            {
                var len:Number = Point.distance(startPoint, endPoint);
                var time:Number = len / speed;
                var nx:Number = endPoint.x - startPoint.x;
                var ny:Number = endPoint.y - startPoint.y;

                if (nx > 0)
                    startPoint.x = Math.max(startPoint.x + nx * (durationTime / 1000) / time, endPoint.x);
                else
					startPoint.x = Math.min(startPoint.x + nx * (durationTime / 1000) / time, endPoint.x);

                if (ny > 0)
					startPoint.y = Math.max(startPoint.y + ny * (durationTime / 1000) / time, endPoint.y);
                else
					startPoint.y = Math.min(startPoint.y + ny * (durationTime / 1000) / time, endPoint.y);
            }
        }
    }
}
