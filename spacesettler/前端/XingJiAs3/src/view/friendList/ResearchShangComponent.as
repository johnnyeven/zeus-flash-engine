package view.friendList
{
	import com.zn.utils.ClassUtil;
	
	import events.friendList.FriendListEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.core.Component;
	
	import vo.allView.FriendInfoVo;
	
	public class ResearchShangComponent extends Component
	{
		public var buttonSprite:Component;
		public var noCheckBtn:Button;
		public var addFriendBtn:Button;
		
		public var hasCheckBtn:Button;
		
		private var _data:FriendInfoVo;
		public function ResearchShangComponent()
		{
			super(ClassUtil.getObject("researchShangComponentSkin"));
			buttonSprite = createUI(Component,"buttonSprite");
			noCheckBtn = buttonSprite.createUI(Button,"noCheckBtn");
			addFriendBtn =  buttonSprite.createUI(Button,"addFriendBtn");
			buttonSprite.sortChildIndex();
			hasCheckBtn = createUI(Button,"hasCheckBtn");
			sortChildIndex();
			
			
			noCheckBtn.addEventListener(MouseEvent.CLICK,checkBtn_clickHandler);
			hasCheckBtn.addEventListener(MouseEvent.CLICK,checkBtn_clickHandler); 
			addFriendBtn.addEventListener(MouseEvent.CLICK,addFriendBtn_clickHandler); 
		}
		
		public function get data():FriendInfoVo
		{
			return _data;
		}
		
		public function set data(value:FriendInfoVo):void
		{
			_data = value;
			_data.componentInforType = "researchShangComponentSkin";
			if(data.isMyFriend == true)
			{
				buttonSprite.visible = false;
				hasCheckBtn.visible = true;
			}
			else
			{
				buttonSprite.visible = true;
				hasCheckBtn.visible = false;
			}
		}
		
		private function checkBtn_clickHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			dispatchEvent(new FriendListEvent(FriendListEvent.SEARCH_CHECK_PLAYER_ID_CARD_EVENT,data,true));
		}
		
		private function addFriendBtn_clickHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			dispatchEvent(new FriendListEvent(FriendListEvent.SEARCH_ADD_FRIEND_EVENT,data,true));
		}
	}
}