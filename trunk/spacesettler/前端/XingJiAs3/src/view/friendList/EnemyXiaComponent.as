package view.friendList
{
	import com.zn.utils.ClassUtil;
	
	import events.friendList.FriendListEvent;
	
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.core.Component;
	
	import vo.allView.FriendInfoVo;

	public class EnemyXiaComponent extends Component
	{
//		public var deletBtnDown:Button;
		public var checkBtnDown:Button;
		public var attackBtnDown:Button;
		
		private var _data:FriendInfoVo;
		public function EnemyXiaComponent()
		{
			super(ClassUtil.getObject("enemyXiaComponentSkin"));
//			deletBtnDown = createUI(Button,"deletBtnDown");
			checkBtnDown = createUI(Button,"checkBtnDown");
			attackBtnDown = createUI(Button,"attackBtnDown");
			sortChildIndex();
			
//			deletBtnDown.addEventListener(MouseEvent.CLICK,deleteBtn_clickHandler);
			checkBtnDown.addEventListener(MouseEvent.CLICK,checkBtn_clickHandler); 
			attackBtnDown.addEventListener(MouseEvent.CLICK,attackBtn_clickHandler);
		}
		
		public function get data():FriendInfoVo
		{
			return _data;
		}
		
		public function set data(value:FriendInfoVo):void
		{
			_data = value;
			_data.componentInforType = "enemyXiaComponentSkin";
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
		
		private function attackBtn_clickHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			dispatchEvent(new FriendListEvent(FriendListEvent.ATTACK_ENEMY_EVENT,data,true));
		}
	}
}