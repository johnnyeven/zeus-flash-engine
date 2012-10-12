package proxy.chat
{
    import com.adobe.crypto.SHA1;
    import com.zn.net.Protocol;
    import com.zn.net.socket.ClientSocket;
    
    import enum.command.CommandEnum;
    
    import flash.events.Event;
    import flash.utils.ByteArray;
    import flash.utils.setTimeout;
    
    import net.chat.ChatProtocol;
    import net.chat.ChatSocket;
    import net.chat.ChatSocketIn;
    import net.chat.ChatSocketOut;
    
    import org.puremvc.as3.interfaces.IProxy;
    import org.puremvc.as3.patterns.proxy.Proxy;
    
    import proxy.login.LoginProxy;
    import proxy.userInfo.UserInfoProxy;
    
    import utils.battle.SocketUtil;
    
    import vo.userInfo.UserInfoVO;

    /**
     *聊天
     * @author zn
     *
     */
    public class ChatProxy extends Proxy implements IProxy
    {
        public static const NAME:String = "ChatProxy";

		private var userInfoVO:UserInfoVO;
		
        public function ChatProxy(data:Object = null)
        {
            super(NAME, data);
			//登陆返回
			ChatProtocol.registerProtocol(CommandEnum.chat_login_result,chatLoginResult);
			//聊天显示
//			ChatProtocol.registerProtocol(
        }
		
        public function connect():void
        {
            ChatSocket.instance.addEventListener(Event.CONNECT, connectComplete);
            ChatSocket.instance.connectServer(LoginProxy.selectedServerVO.server_message_ip, LoginProxy.selectedServerVO.server_message_port);
//			ChatSocket.instance.connectServer("192.168.0.105", 8888);
        }

        protected function connectComplete(event:Event):void
        {
			loginChat();
        }

        public function loginChat():void
        {
			userInfoVO = UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO;
            var body:ByteArray = ClientSocket.getBy();
            SocketUtil.writeIdType(userInfoVO.player_id, body);
			SocketUtil.writeIdType(userInfoVO.legion_id, body);
			SocketUtil.writeIdType(new Date().time.toString(), body);
			body.writeInt(1);
			var out:ChatSocketOut=new ChatSocketOut(CommandEnum.chat_login,body,44);

			//sha
			var sha:String = SHA1.hashBytes(out);
			var shaBy:ByteArray=ClientSocket.getBy();
			var xorString:String="The quick brown fox jumps over the lazy dog";
			var len:int = sha.length <xorString.length ? sha.length : xorString.length;
			var by:ByteArray=ClientSocket.getBy();
			by.writeMultiByte(sha, "UTF-8");
			by.position=0;
			for (var i:int = 0; i < len; i++)
			{
				shaBy.writeByte(by.readByte() ^ xorString.charCodeAt(i));
			}
			
			shaBy.position=0;
			out.writeInt(shaBy.length);
			out.writeBytes(shaBy);
			
			ChatSocket.instance.sendMessage(out);
        }
		
		private function chatLoginResult(pg:ChatSocketIn):void
		{
			trace(pg.body);
			SocketUtil.readIdType(pg.body);
			SocketUtil.readIdType(pg.body);
			SocketUtil.readIdType(pg.body);
			
			var length:uint = pg.body.readUnsignedInt();
			pg.body.readInt();
			
			if (length != 0)
				pg.body.readMultiByte(length, Protocol.CHARSET);

		}
		
		public function getChatHistory():void
		{
			var body:ByteArray = ClientSocket.getBy();
			SocketUtil.writeIdType(userInfoVO.player_id, body);
			SocketUtil.writeIdType(userInfoVO.legion_id, body);
			SocketUtil.writeIdType(new Date().time.toString(), body);
			
			var out:ChatSocketOut=new ChatSocketOut(CommandEnum.chat_get_history,body);
			ChatSocket.instance.sendMessage(out);
		}
		
//		private function 

    /***********************************************************
     *
     * 功能方法
     *
     * ****************************************************/

    }
}
