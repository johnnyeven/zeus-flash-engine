package net.gameServer
{
    import com.zn.log.Log;
    import com.zn.net.Protocol;
    import com.zn.net.socket.ClientSocket;
    import com.zn.net.socket.SocketPackageIn;
    
    import flash.net.registerClassAlias;
    import flash.utils.ByteArray;
    import flash.utils.Endian;

    public class GamerServerSocket extends ClientSocket
    {
        private static var _instance:GamerServerSocket;

        public function GamerServerSocket()
        {
            super();
			registerClassAlias("net.gameServer.GamerServerSocketIn",GamerServerSocketIn);
			registerClassAlias("net.gameServer.GamerServerSocketOut",GamerServerSocketOut);
        }

        public static function get instance():GamerServerSocket
        {
            if (!_instance)
                _instance = new GamerServerSocket();

            return _instance;
        }

        public override function readPackage():Boolean
        {
            var chatIn:GamerServerSocketIn = new GamerServerSocketIn();
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
				Log.debug(GamerServerSocket,"handlePackage","接收到gameServer命令:"+pkg.command);
				
				//执行协议方法
				var callFunctionList:Vector.<Function> = GamerServerProtocol.getProtocolFunctionList(pkg.command);
				
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
