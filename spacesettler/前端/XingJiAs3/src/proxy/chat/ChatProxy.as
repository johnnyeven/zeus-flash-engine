package proxy.chat
{
	import com.adobe.crypto.SHA1;
	import com.netease.protobuf.Int64;
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.net.Protocol;
	import com.zn.net.socket.ClientSocket;
	import com.zn.utils.DateFormatter;
	import com.zn.utils.StringUtil;
	
	import enum.chat.ChannelEnum;
	import enum.command.CommandEnum;
	
	import flash.events.Event;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;
	
	import mediator.mainView.ChatViewMediator;
	import mediator.prompt.PromptMediator;
	
	import net.chat.ChatProtocol;
	import net.chat.ChatSocket;
	import net.chat.ChatSocketIn;
	import net.chat.ChatSocketOut;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import proxy.login.LoginProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import utils.battle.SocketUtil;
	
	import vo.chat.ChatItemVO;
	import vo.chat.ChatVO;
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
		//		/**
		//		 * 聊天信息列表
		//		 */		
		//		[Bindable]
		//		public var chatVO:ChatVO;
		private var callBackFunction:Function;
		
		public function ChatProxy(data:Object = null)
		{
			super(NAME, data);
			//登陆返回
			ChatProtocol.registerProtocol(CommandEnum.chat_login_result,chatLoginResult);
			//聊天显示历史内容和
			ChatProtocol.registerProtocol(CommandEnum.chat_talking,getChatHistoryResult);
			//登出
			ChatProtocol.registerProtocol(CommandEnum.chat_logoff,logoffResult);
			//获取在线人数
			ChatProtocol.registerProtocol(CommandEnum.chat_get_online_player_number_result,getOnLinePlayerNumberResult);
			//系统广播
			ChatProtocol.registerProtocol(CommandEnum.chat_system_boardCast,systemBoardCastResult);
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
			var body:ByteArray =ClientSocket.getBy();
			SocketUtil.writeIdType(userInfoVO.player_id, body);
			SocketUtil.writeIdType(userInfoVO.legion_id, body);
			SocketUtil.writeIdType(new Date().time.toString(), body);
			body.writeInt(1);
			var out:ChatSocketOut=new ChatSocketOut(CommandEnum.chat_login,body,44);
			out.writeUnsignedInt(40);
			
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
			out.writeBytes(shaBy);
			//			out.writeBytes(by);
			
			ChatSocket.instance.sendMessage(out);
		}
		
		private function chatLoginResult(pg:ChatSocketIn):void
		{
			var result:int = pg.result;
			if(result != 0)
			{
				if(result == 1)
				{
					sendNotification(PromptMediator.SHOW_ALERT_NOTE,MultilanguageManager.getString("CC_ERROR_INVALID_CHECKSUM"));
				}
				else if(result == 2)
				{
					sendNotification(PromptMediator.SHOW_ALERT_NOTE,MultilanguageManager.getString("CC_ERROR_INVALID_DIGIEST"));
				}
				return;
			}
			getChatHistory();
			//			trace(pg.body);
			//			ChatSocket.readIdType(pg.body);
			//			ChatSocket.readIdType(pg.body);
			//			ChatSocket.readIdType(pg.body);
			
			//			var length:uint = pg.body.readUnsignedInt();
			//			pg.body.readInt();
			
			//			if (length != 0)
			//				pg.body.readMultiByte(length, Protocol.CHARSET);
			
		}
		
		/**
		 *获取聊天历史内容 
		 * 
		 */		
		public function getChatHistory():void
		{
			var body:ByteArray = ClientSocket.getBy();
			SocketUtil.writeIdType(userInfoVO.player_id, body);
			SocketUtil.writeIdType(String(ChannelEnum.CHANNEL_WORLD), body);
			SocketUtil.writeIdType(new Date().time.toString(), body);
			
			var out:ChatSocketOut=new ChatSocketOut(CommandEnum.chat_get_history,body);
			ChatSocket.instance.sendMessage(out);
		}
		
		private function getChatHistoryResult(pg:ChatSocketIn):void
		{
			var result:int = pg.result;
			if(result != 0)
			{
				if(result == 1)
				{
					sendNotification(PromptMediator.SHOW_ALERT_NOTE,MultilanguageManager.getString("CC_ERROR_INVALID_CHECKSUM"));
				}
				else if(result == 2)
				{
					sendNotification(PromptMediator.SHOW_ALERT_NOTE,MultilanguageManager.getString("CC_ERROR_INVALID_DIGIEST"));
				}
				return;
			}
			var chatVO:ChatVO = new ChatVO();
			var chatItemVO:ChatItemVO = new ChatItemVO();
			
			chatItemVO.myID = SocketUtil.readIdType(pg.body);
			chatItemVO.channel =  SocketUtil.readIdType(pg.body);
			var int64:Int64=SocketUtil.readIdTypeInt64(pg.body);
			chatItemVO.timeStamp = int64.high*1000;
			

			chatItemVO.strLength = pg.body.readUnsignedInt();
			
			chatItemVO.campID = pg.body.readInt();
			
			if (chatItemVO.strLength != 0)
				chatItemVO.str = pg.body.readMultiByte(chatItemVO.strLength, Protocol.CHARSET);
			
			
			//对阵营的特殊处理
			var strXml:String = StringUtil.formatString("<p><s>{0}</s></p>",chatItemVO.str);
			var xml:XML = new XML(strXml);
			var userData:String = xml.a.@value[0];
			//将特殊字符转换回来
			var t:String=String.fromCharCode(11);
			var re:RegExp=new RegExp(t,"g");
			 userData=userData.replace(re,'"');
			var dataObj:Object = JSON.parse(userData);
			//玩家自己的数据
			chatItemVO.myVIP = dataObj.myVIP;
			chatItemVO.myName = dataObj.myName;
			chatItemVO.myID = dataObj.myID;
			//别人的数据
			chatItemVO.otherID = dataObj.otherID;
			chatItemVO.otherName= dataObj.otherName;
			chatItemVO.otherVIP = dataObj.otherVIP;
			
			chatVO.channel = chatItemVO.channel;
			if(int(chatVO.channel) > 10)
			{
				chatVO.privateList.push(chatItemVO);
			}
			else
			{
				switch(chatVO.channel)
				{
					case ChannelEnum.CHANNEL_ARMY_GROUP:
					{
						chatVO.armyGroupList.push(chatItemVO);
						break;
					}
					case ChannelEnum.CHANNEL_WORLD:
					{
						//是否为阵营通道
						if(dataObj.campID)
						{
							if(dataObj.campID == userInfoVO.camp)
							{
								//是否为自己的阵营
								chatVO.campList.push(chatItemVO);
							}
							
						}
						else
						{
							chatVO.wordList.push(chatItemVO);
						}
						break;
					}
					case ChannelEnum.CHANNEL_NB:
					{
						chatVO.otherList.push(chatItemVO);
						break;
					}
				}
			}
			
			
			sendNotification(ChatViewMediator.INFOR_NOTE,chatVO);
		}
		
		/**
		 *获取聊天内容 
		 * 
		 */	
		public function talking(infor:String,channel:String):void
		{
			if(channel == ChannelEnum.CHANNEL_CAMP)
			{
				//阵营通道也用世界通道传值
				channel = ChannelEnum.CHANNEL_WORLD;
			}
			//获取本地时间
			var dateData:Date = new Date();
//			var date:Date = new Date(null,null,null,dateData.hours,dateData.minutes,dateData.seconds,dateData.milliseconds);
			var date:Date = new Date();
			var time:Number = date.time;
			
			var body:ByteArray = ClientSocket.getBy();
			SocketUtil.writeIdType(userInfoVO.player_id, body);
			SocketUtil.writeIdType(channel, body);
			SocketUtil.writeIdType(time.toString(), body);
			
			var byStr:ByteArray = ClientSocket.getBy();
			byStr.writeMultiByte(infor, Protocol.CHARSET);
			byStr.position = 0;
			body.writeInt(byStr.length);
			body.writeInt(userInfoVO.camp);
			body.writeBytes(byStr);
			
			var out:ChatSocketOut=new ChatSocketOut(CommandEnum.chat_talking,body);
			ChatSocket.instance.sendMessage(out);
		}
		
		/**
		 *登出
		 * 
		 */	
		public function logoff():void
		{
			var body:ByteArray = ClientSocket.getBy();
			SocketUtil.writeIdType(userInfoVO.player_id,body);
			
			var out:ChatSocketOut = new ChatSocketOut(CommandEnum.chat_logoff,body);
			ChatSocket.instance.sendMessage(out);
		}
		
		private function logoffResult(pg:ChatSocketIn):void
		{
			var result:int = pg.result;
			if(result != 0)
			{
				if(result == 1)
				{
					sendNotification(PromptMediator.SHOW_ALERT_NOTE,MultilanguageManager.getString("CC_ERROR_INVALID_CHECKSUM"));
				}
				else if(result == 2)
				{
					sendNotification(PromptMediator.SHOW_ALERT_NOTE,MultilanguageManager.getString("CC_ERROR_INVALID_DIGIEST"));
				}
				return;
			}
		}
		
		/**
		 *获取在线人数
		 */	
		public function getOnLinePlayerNumber():void
		{
			var body:ByteArray = ClientSocket.getBy();
			SocketUtil.writeIdType(userInfoVO.player_id,body);
			
			var out:ChatSocketOut = new ChatSocketOut(CommandEnum.chat_get_online_player_number,body);
			ChatSocket.instance.sendMessage(out);
		}
		
		private function getOnLinePlayerNumberResult(pg:ChatSocketIn):void
		{
			var chatItemVO:ChatItemVO = new ChatItemVO();
			
			chatItemVO.wordOnLineNumber = int(SocketUtil.readIdType(pg.body));
			chatItemVO.groupOnLineNumber = int(SocketUtil.readIdType(pg.body));
		}
		
		/**
		 *系统广播(数据)
		 */	
		private function systemBoardCastResult(pg:ChatSocketIn):void
		{
			var result:int = pg.result;
			if(result != 0)
			{
				if(result == 1)
				{
					sendNotification(PromptMediator.SHOW_ALERT_NOTE,MultilanguageManager.getString("CC_ERROR_INVALID_CHECKSUM"));
				}
				else if(result == 2)
				{
					sendNotification(PromptMediator.SHOW_ALERT_NOTE,MultilanguageManager.getString("CC_ERROR_INVALID_DIGIEST"));
				}
				return;
			}
			var chatVO:ChatVO = new ChatVO();
			var chatItemVO:ChatItemVO = new ChatItemVO();
			var str:String = "";
			chatItemVO.strLength = pg.body.readUnsignedInt();
			
			if (chatItemVO.strLength != 0)
				str = pg.body.readMultiByte(chatItemVO.strLength, Protocol.CHARSET);
			var obj:Object;
			if(str)
				obj = JSON.parse(str);
			
			chatItemVO.str = obj.content;
			chatItemVO.system = obj.from_who;
			chatItemVO.timeStamp = obj.time;
			chatItemVO.type = obj.type;
			
			chatVO.wordList.push(chatItemVO);
//			sendNotification(ChatViewMediator.INFOR_NOTE,chatVO);
		}
		
		/***********************************************************
		 *
		 * 功能方法
		 *
		 * ****************************************************/
		
	}
}
