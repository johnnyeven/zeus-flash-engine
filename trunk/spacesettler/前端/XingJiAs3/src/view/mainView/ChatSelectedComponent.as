package view.mainView
{
	import com.zn.utils.ClassUtil;
	
	import enum.chat.ChannelEnum;
	
	import events.talk.TalkEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import mediator.mainView.MainViewMediator;
	
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.core.Component;
	
	public class ChatSelectedComponent extends Component
	{
		public var checkBtn:Button;
		
		public var chatBtn:Button;
		
		private var _data:String;
		
		//选择私聊频道的特殊处理
		private var _selectedChannel:int;
		
		private var userInforProxy:UserInfoProxy;
		private var mainMeditor:MainViewMediator;
		public function ChatSelectedComponent()
		{
			super(ClassUtil.getObject("mainView.chat.selectedComponent"));
			mainMeditor = ApplicationFacade.getInstance().getMediator(MainViewMediator);
			userInforProxy = ApplicationFacade.getProxy(UserInfoProxy);
			
			checkBtn = createUI(Button,"checkBtn");
			chatBtn = createUI(Button,"chatBtn");
			
			sortChildIndex();
			
			checkBtn.addEventListener(MouseEvent.CLICK,checkBtn_clickHandler);
			chatBtn.addEventListener(MouseEvent.CLICK,chatBtn_clickHandler);
		}
		
		
		public function get data():String
		{
			return _data;
		}

		public function set data(value:String):void
		{
			var obj:Object = {};
			obj=JSON.parse(value);
			_data = value;
			if(obj.playerID == userInforProxy.userInfoVO.player_id)//obj.playerID  构造的obj对象统一用playerID
			{
				chatBtn.visible = false;
			}
			else
			{
				chatBtn.visible = true;
			}
		}
		
		private function checkBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new TalkEvent(TalkEvent.CHECK_ID_CARD_EVENT,data,"0",true,true));
			mainMeditor.comp.removeChild(this);
		}
		
		private function chatBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new TalkEvent(TalkEvent.PRIVATE_TALK_EVENT,data,ChannelEnum.CHANNEL_PRIVATE,true,true));
			mainMeditor.comp.removeChild(this);
		}

		public function get selectedChannel():int
		{
			return _selectedChannel;
		}

		public function set selectedChannel(value:int):void
		{
			_selectedChannel = value;
		}


	}
}