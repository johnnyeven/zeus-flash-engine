package mediator.friendList
{
	import com.greensock.TweenLite;
	
	import events.friendList.FriendListEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.WindowMediator;
	import mediator.allView.XingXingComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.friendList.FriendProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import view.friendList.EnemyListComponent;
	
	import vo.allView.FriendInfoVo;

	/**
	 *显示敌人列表
	 * @param lw
	 *
	 */
	public class EnemyListComponentMediator extends WindowMediator implements IMediator
	{
		public static const NAME:String="EnemyListComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		private var friendProxy:FriendProxy;
		private var userInforProxy:UserInfoProxy;
		public function EnemyListComponentMediator()
		{
			super(NAME, new EnemyListComponent());
			comp.med=this;
			level = 1;
			friendProxy = getProxy(FriendProxy);
			userInforProxy = getProxy(UserInfoProxy);
			
			comp.addEventListener(FriendListEvent.CLOSE_ENEMY_LIST_EVENT,closeHandler);
			comp.addEventListener(FriendListEvent.SEARCH_PLATER_EVENT,searchPlayerHandler);
			comp.addEventListener(FriendListEvent.RENEW_FRIENF_LIST_EVENT,renewFriendListHandler);
			
			comp.addEventListener(FriendListEvent.CHECK_PLAYER_ID_CARD_EVENT,checkPlayerIdCardHandler);
			comp.addEventListener(FriendListEvent.DELETED_FRIEND_INFOR_EVENT,deletedFriendHandler);
			comp.addEventListener(FriendListEvent.ATTACK_ENEMY_EVENT,attackEnemyHandler);
		}
		
		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [DESTROY_NOTE];
		}

		/**
		 *消息处理
		 * @param note
		 *
		 */
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case DESTROY_NOTE:
				{
					//销毁对象
					destroy();
					break;
				}
			}
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		protected function get comp():EnemyListComponent
		{
			return viewComponent as EnemyListComponent;
		}
				
		private function searchPlayerHandler(event:FriendListEvent):void
		{
			sendNotification(SearchPlayerComponentMediator.SHOW_NOTE);
		}

		private function renewFriendListHandler(event:FriendListEvent):void
		{
			//刷新列表
			friendProxy.getFriendList(userInforProxy.userInfoVO.player_id);
		}
		
		private function checkPlayerIdCardHandler(event:FriendListEvent):void
		{
			if((event.obj as FriendInfoVo).componentInforType == "enemyShangComponentSkin")
			{
				comp.shangRemove_clickHandler(null);
			}
			else if((event.obj as FriendInfoVo).componentInforType == "enemyXiaComponentSkin")
			{
				comp.xiaRemove_clickHandler(null);
			}
			friendProxy.checkOtherPlayer((event.obj as FriendInfoVo).id,function():void
			{
				sendNotification(ViewIdCardComponentMediator.SHOW_NOTE);
			});
		}
		
		private function deletedFriendHandler(event:FriendListEvent):void
		{
			
			friendProxy.deletedFriend((event.obj as FriendInfoVo).id);
		}
		
		private function attackEnemyHandler(event:FriendListEvent):void
		{
			if((event.obj as FriendInfoVo).componentInforType == "enemyShangComponentSkin")
			{
				comp.shangRemove_clickHandler(null);
			}
			else if((event.obj as FriendInfoVo).componentInforType == "enemyXiaComponentSkin")
			{
				comp.xiaRemove_clickHandler(null);
			}
			//查看小行星(行星要塞）
			sendNotification(XingXingComponentMediator.SHOW_NOTE,(event.obj as FriendInfoVo).id);
		}
	}
}