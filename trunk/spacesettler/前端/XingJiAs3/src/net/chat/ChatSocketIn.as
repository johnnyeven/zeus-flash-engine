package net.chat
{
    import com.adobe.crypto.SHA1;
    import com.zn.net.Protocol;
    import com.zn.net.socket.ClientSocket;
    import com.zn.net.socket.SocketPackageIn;
    
    import flash.net.registerClassAlias;
    import flash.utils.ByteArray;

    public class ChatSocketIn extends SocketPackageIn
    {
        public var result:int;

        public function ChatSocketIn()
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
