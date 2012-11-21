package view.friendList
{
	import com.zn.utils.ClassUtil;
	
	import events.friendList.FriendListEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.core.Component;
	
	import vo.allView.FriendInfoVo;
	
	public class EnemyShangComponent extends Component
	{
//		public var deletBtnUP:Button;
		public var checkBtnUP:Button;
		public var attackBtnUP:Button;
		private var _data:FriendInfoVo;
		public function EnemyShangComponent()
		{
			super(ClassUtil.getObject("enemyShangComponentSkin"));
//			deletBtnUP = createUI(Button,"deletBtnUP");
			checkBtnUP = createUI(Button,"checkBtnUP");
			attackBtnUP = createUI(Button,"attackBtnUP");
			sortChildIndex();
			
//			deletBtnUP.addEventListener(MouseEvent.CLICK,deleteBtn_clickHandler);
			checkBtnUP.addEventListener(MouseEvent.CLICK,checkBtn_clickHandler); 
			attackBtnUP.addEventListener(MouseEvent.CLICK,attackBtn_clickHandler); 
		}
		
		public function get data():FriendInfoVo
		{
			return _data;
		}
		
		public function set data(value:FriendInfoVo):void
		{
			_data = value;
			_data.componentInforType = "enemyShangComponentSkin";
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