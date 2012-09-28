package net.chat
{
    import com.adobe.crypto.SHA1;
    import com.zn.net.Protocol;
    import com.zn.net.socket.ClientSocket;
    import com.zn.net.socket.SocketPackageOut;
    
    import flash.net.registerClassAlias;
    import flash.utils.ByteArray;

    public class ChatSocketOut extends SocketPackageOut
    {
        private static const HEAD_LENGTH:int = 8;

        public function ChatSocketOut(command:*, body:ByteArray,shaLen:int=0)
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
