package net.roomServer
{
    import com.zn.log.Log;
    import com.zn.net.Protocol;
    import com.zn.net.socket.ClientSocket;
    import com.zn.net.socket.SocketPackageIn;
    
    import enum.battle.GameServerErrorEnum;
    
    import flash.net.registerClassAlias;
    import flash.utils.ByteArray;
    import flash.utils.Endian;

    public class RoomSocket extends ClientSocket
    {
        private static var _instance:RoomSocket;

        public function RoomSocket()
        {
            super();
			registerClassAlias("net.roomServer.RoomSocketIn",RoomSocketIn);
			registerClassAlias("net.roomServer.RoomSocketOut",RoomSocketOut);
        }

        public static function get instance():RoomSocket
        {
            if (!_instance)
                _instance = new RoomSocket();

            return _instance;
        }

        public override function readPackage():Boolean
        {
            var chatIn:RoomSocketIn = new RoomSocketIn();
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
				Log.debug(RoomSocket,"handlePackage","接收到gameServer命令:"+pkg.command);
				
				//执行协议方法
				var callFunctionList:Vector.<Function> = RoomProtocol.getProtocolFunctionList(pkg.command);
				
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
