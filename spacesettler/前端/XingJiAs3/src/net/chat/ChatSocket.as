package net.chat
{
    import com.zn.log.Log;
    import com.zn.net.Protocol;
    import com.zn.net.socket.ClientSocket;
    import com.zn.net.socket.SocketPackageIn;
    
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
		
		protected override function handlePackage(pkg:SocketPackageIn):void
		{
			try
			{
				Log.debug(ChatSocket,"handlePackage","接收到聊天命令:"+pkg.command);
				
				//执行协议方法
				var callFunctionList:Vector.<Function> = ChatProtocol.getProtocolFunctionList(pkg.command);
				
				for each (var callFun:Function in callFunctionList)
				{
					//克隆流
					pkg.position = 0;
					//调用方法
					callFun(pkg);
				}
			}
			catch (err:Error)
			{
				trace("handlePackage:", err.getStackTrace());
				//trace(ByteUtils.ToHexDump("Bytes Left:",_readBuffer,_readOffset,_readBuffer.bytesAvailable));
			}
		}
    }
}
