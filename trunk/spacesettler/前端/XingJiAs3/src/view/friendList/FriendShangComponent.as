package view.friendList
{
	import com.zn.utils.ClassUtil;
	
	import events.friendList.FriendListEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.core.Component;
	
	import vo.allView.FriendInfoVo;
	
	public class FriendShangComponent extends Component
	{
		public var deletBtnUP:Button;
		public var checkBtnUP:Button;
		public var chatBtnUP:Button;
		
		private var _data:FriendInfoVo;
		public function FriendShangComponent()
		{
			super(ClassUtil.getObject("shangComponentSkin"));
			deletBtnUP = createUI(Button,"deletBtnUP");
			checkBtnUP = createUI(Button,"checkBtnUP");
			chatBtnUP =  createUI(Button,"chatBtnUP");
			
			sortChildIndex();
			deletBtnUP.addEventListener(MouseEvent.CLICK,deleteBtn_clickHandler);
			checkBtnUP.addEventListener(MouseEvent.CLICK,checkBtn_clickHandler); 
			chatBtnUP.addEventListener(MouseEvent.CLICK,chatBtn_clickHandler); 
		}
		
		public function get data():FriendInfoVo
		{
			return _data;
		}
		
		public function set data(value:FriendInfoVo):void
		{
			_data = value;
			_data.componentInforType = "shangComponentSkin";
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