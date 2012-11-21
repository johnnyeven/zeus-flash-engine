package view.friendList
{
	import com.zn.utils.ClassUtil;
	
	import events.friendList.FriendListEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.core.Component;
	
	import vo.allView.FriendInfoVo;
	
	public class FriendXiaComponent extends Component
	{
		public var deletBtnDown:Button;
		public var checkBtnDown:Button;
		public var chatBtnDown:Button;
		
		private var _data:FriendInfoVo;
		public function FriendXiaComponent()
		{
			super(ClassUtil.getObject("xiaComponentSkin"));
			deletBtnDown = createUI(Button,"deletBtnDown");
			checkBtnDown = createUI(Button,"checkBtnDown");
			chatBtnDown =  createUI(Button,"chatBtnDown");
			sortChildIndex();
			
			deletBtnDown.addEventListener(MouseEvent.CLICK,deleteBtn_clickHandler);
			checkBtnDown.addEventListener(MouseEvent.CLICK,checkBtn_clickHandler); 
			chatBtnDown.addEventListener(MouseEvent.CLICK,chatBtn_clickHandler); 
		}
		
		public function get data():FriendInfoVo
		{
			return _data;
		}
		
		public function set data(value:FriendInfoVo):void
		{
			_data = value;
			_data.componentInforType = "xiaComponentSkin";
		}
		
		private function checkBtn_clickHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			dispatchEvent(new FriendListEvent(FriendListEvent.CHECK_PLAYER_ID_CARD_EVENT,data,true));
		}
		
		private function deleteBtn_clickHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			dispatchEvent(new FriendListEvent(FriendListEvent.DELETED_FRIEND_INFOR_EVENT,data,true));
		}
		
		private function chatBtn_clickHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			dispatchEvent(new FriendListEvent(FriendListEvent.CHAT_WITH_FRIEND_EVENT,data,true));
		}
	}
}