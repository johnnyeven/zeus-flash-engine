package net.gameServer
{
    import com.zn.net.socket.SocketPackageOut;
    
    import flash.utils.ByteArray;

    public class GamerServerSocketOut extends SocketPackageOut
    {
        private static const HEAD_LENGTH:int = 8;

        public function GamerServerSocketOut(command:*, body:ByteArray,shaLen:int=0)
        {
            super();
			this.command=command;
			
            var len:int = HEAD_LENGTH + body.length+shaLen;
            writeUnsignedInt(len);
            writeShort(command);
            writeShort(0);
            writeBytes(body);
        }
    }
}
