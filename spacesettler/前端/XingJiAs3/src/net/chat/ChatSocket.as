package net.chat
{
    import com.zn.net.socket.ClientSocket;
    
    import flash.net.registerClassAlias;
    import flash.utils.ByteArray;
    import flash.utils.Endian;

    public class ChatSocket extends ClientSocket
    {
        private static var _instance:ChatSocket;

        public function ChatSocket()
        {
            super();
			registerClassAlias("net.chat.ChatSocketIn",ChatSocketIn);
			registerClassAlias("net.chat.ChatSocketOut",ChatSocketOut);
        }

        public static function get instance():ChatSocket
        {
            if (!_instance)
                _instance = new ChatSocket();

            return _instance;
        }

        public override function readPackage():Boolean
        {
            var chatIn:ChatSocketIn = new ChatSocketIn();
            if (chatIn.load(_readBuffer))
            {
                handlePackage(chatIn);
                return true;
            }

            return false;
        }

        public static function writeIdType(id:String, by:ByteArray):void
        {
            var str:String = Number(id).toString(16);
            var index:int = Math.max(0, str.length - 8);
            var l:int = int(str.substr(index, 8));
            var h:int = int(str.substr(0, index));

            if (by.endian == Endian.LITTLE_ENDIAN)
            {
                by.writeInt(l);
                by.writeInt(h);
            }
            else
            {
                by.writeInt(h);
                by.writeInt(l);
            }
        }

        /**
         *
         * @param by
         * @return
         */
        public static function readIdType(by:ByteArray):String
        {
            var h:int;
            var l:int;

            if (by.endian == Endian.LITTLE_ENDIAN)
            {
                l = by.readInt();
                h = by.readInt();
            }
            else
            {
                h = by.readInt();
                l = by.readInt();
            }

            var str:String = "0x" + h + l;
            return Number(str).toString();
        }
    }
}
