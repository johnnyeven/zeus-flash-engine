package view.mainView
{
	import com.zn.utils.ClassUtil;
	
	import enum.chat.ChannelEnum;
	
	import events.talk.ChatEvent;
	import events.talk.TalkEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.system.System;
	
	import mediator.mainView.MainViewMediator;
	
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.core.Component;
	
	import vo.chat.ChatItemVO;
	
	public class ChatSelectedComponent extends Component
	{
		public var otherSprite:Component;
		public var checkBtn:Button;
		public var chatBtn:Button;
		public var copyBtn:Button;
		
		public var ownSprite:Component;
		public var checkOwnBtn:Button;
		public var copyOwnBtn:Button;
		
		private var _data:ChatItemVO;
		
		//选择私聊频道的特殊处理
		private var _selectedChannel:String;
		
		private var userInforProxy:UserInfoProxy;
		private var mainMeditor:MainViewMediator;
		public function ChatSelectedComponent()
		{
			super(ClassUtil.getObject("mainView.chat.selectedComponent"));
			mainMeditor = ApplicationFacade.getInstance().getMediator(MainViewMediator);
			userInforProxy = ApplicationFacade.getProxy(UserInfoProxy);
			
			otherSprite = createUI(Component,"otherSprite");
			checkBtn = otherSprite.createUI(Button,"checkBtn");
			chatBtn = otherSprite.createUI(Button,"chatBtn");
			copyBtn = otherSprite.createUI(Button,"copyBtn");
			otherSprite.sortChildIndex();
			
			ownSprite = createUI(Component,"ownSprite");
			checkOwnBtn = ownSprite.createUI(Button,"checkOwnBtn");
			copyOwnBtn = ownSprite.createUI(Button,"copyOwnBtn");
			ownSprite.sortChildIndex();
			sortChildIndex();
			
			
			checkBtn.addEventListener(MouseEvent.CLICK,checkBtn_clickHandler);
			chatBtn.addEventListener(MouseEvent.CLICK,chatBtn_clickHandler);
			checkOwnBtn.addEventListener(MouseEvent.CLICK,checkBtn_clickHandler);
			copyBtn.addEventListener(MouseEvent.CLICK,copyBtn_clickHandler);
			copyOwnBtn.addEventListener(MouseEvent.CLICK,copyBtn_clickHandler);
		}
		
		
		public function get data():ChatItemVO
		{
			return _data;
		}

		public function set data(value:ChatItemVO):void
		{
//			var obj:Object = {};
//			obj=JSON.parse(value);
			_data = value;
			otherSprite.visible = false;
			ownSprite.visible = false;
			//私聊的特殊处理(私聊中的每一条数据都可以进行选中再次进行私聊）
			if(selectedChannel == ChannelEnum.CHANNEL_PRIVATE)
			{
				otherSprite.visible = true;
				ownSprite.visible = false;
			}
			else
			{
				if(_data.myID == userInforProxy.userInfoVO.player_id)//obj.playerID  构造的obj对象统一用playerID
				{
					otherSprite.visible = false;
					ownSprite.visible = true;
				}
				else
				{
					otherSprite.visible = true;
					ownSprite.visible = false;
				}
			}
			
		}
		
		private function checkBtn_clickHandler(event:MouseEvent):void
		{
			//私聊的特殊处理(私聊中的每一条数据都可以进行选中再次进行私聊）
			if(selectedChannel == ChannelEnum.CHANNEL_PRIVATE)
			{
				//私聊框中的查看 都查看私聊对象
				if(data.myID == userInforProxy.userInfoVO.player_id)
				{
					dispatchEvent(new TalkEvent(TalkEvent.CHECK_ID_CARD_EVENT,data.otherID,"0",true,true));
				}
				else if(data.otherID == userInforProxy.userInfoVO.player_id)
				{
					dispatchEvent(new TalkEvent(TalkEvent.CHECK_ID_CARD_EVENT,data.myID,"0",true,true));
				}
				
			}
			else
			{
				dispatchEvent(new TalkEvent(TalkEvent.CHECK_ID_CARD_EVENT,data.myID,"0",true,true));
			}
			
		}
		
		private function chatBtn_clickHandler(event:MouseEvent):void
		{
			 var privateObj:Object = {};
			if(selectedChannel == ChannelEnum.CHANNEL_PRIVATE)
			{
			   //私聊的特殊处理(私聊中的每一条数据都可以进行选中再次进行私聊）
			  
			   if(data.myID == userInforProxy.userInfoVO.player_id)
			   {
				   privateObj = {otherVIP:data.otherVIP,otherID:data.otherID,otherName:data.otherName};
			   }
			   else if(data.otherID == userInforProxy.userInfoVO.player_id)
			   {
				   //在其他玩家那边的处理
				   privateObj = {otherVIP:data.myVIP,otherID:data.myID,otherName:data.myName};
			   }
			}
			else
			{
			    privateObj = {otherVIP:data.myVIP,otherID:data.myID,otherName:data.myName};
			}
			dispatchEvent(new ChatEvent(ChatEvent.PRIVATE_CHAT_BY_CHAT_COMPONENT,privateObj,true,true));
		}

		public function get selectedChannel():String
		{
			return _selectedChannel;
		}

		public function set selectedChannel(value:String):void
		{
			_selectedChannel = value;
		}

		private function copyBtn_clickHandler(event:MouseEvent):void
		{
			//将聊天信息复制到剪切板
			dispatchEvent(new TalkEvent(TalkEvent.COPY_INFOR_EVENT,data.str,"0",true));
		}

	}
}