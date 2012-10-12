package net.roomServer
{
    import com.zn.net.socket.SocketPackageIn;
    
    import flash.utils.ByteArray;

    public class RoomSocketIn extends SocketPackageIn
    {
        public var result:int;

        public function RoomSocketIn()
        {
            super();
        }

        public override function load(readBuff:ByteArray):Boolean
        {
			if(readBuff.bytesAvailable==0)
				return false;
			
            var len:int = readBuff.readUnsignedInt();

            if (readBuff.bytesAvailable >= len-4)
            {
				readBuff.position-=4;
                readBuff.readBytes(this, 0, len);

                //读头
                len = readUnsignedInt();
                command = readUnsignedShort();
                result = readUnsignedShort();

                //计算各个数据位置
                bodyPosition = position;
				bodyLen=len-bodyPosition;
					
                //读取包体
                position = bodyPosition;
                readBytes(body, 0, bodyLen);

                return true;
            }

            return false;
        }
    }
}
