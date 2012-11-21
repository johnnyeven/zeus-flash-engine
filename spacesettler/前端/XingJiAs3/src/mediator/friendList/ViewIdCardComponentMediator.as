package mediator.friendList
{
	import events.friendList.FriendListEvent;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import mediator.BaseMediator;
	import mediator.WindowMediator;
	import mediator.allView.XingXingComponentMediator;
	import mediator.email.SendEmailComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.friendList.FriendProxy;
	
	import view.friendList.ViewIdCardComponent;

	/**
	 *查看军官证
	 * @author lw
	 *
	 */
	public class ViewIdCardComponentMediator extends WindowMediator implements IMediator
	{
		public static const NAME:String="ViewIdCardComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		private var friendProxy:FriendProxy;
		private var obj:Object;
		public function ViewIdCardComponentMediator()
		{
			super(NAME, new ViewIdCardComponent());
			comp.med=this;
			level=3;
			
			friendProxy = getProxy(FriendProxy);
			comp.addEventListener("closeIDCardComponent",closeHandler);
			comp.addEventListener(FriendListEvent.CHECK_FORT_BY_ID_CARD_EVENT,checkFortHandler);
			comp.addEventListener(FriendListEvent.ADD_FRIEND_BY_ID_CARD_EVENT,addFriendHandler);
			comp.addEventListener(FriendListEvent.SEND_EMAIL_BY_ID_CARD_EVENT,sendEmailHandler);
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
		protected function get comp():ViewIdCardComponent
		{
			return viewComponent as ViewIdCardComponent;
		}
		
		private function checkFortHandler(event:FriendListEvent):void
		{
			sendNotification(XingXingComponentMediator.SHOW_NOTE,event.obj);
		}

		private function addFriendHandler(event:FriendListEvent):void
		{
			friendProxy.addFriend(event.obj as String);
		}

		private function sendEmailHandler(event:FriendListEvent):void
		{
			obj=event.obj;
			//显示界面
			sendNotification(SendEmailComponentMediator.SHOW_NOTE);
			setTimeout(sendMes,500);
		}
		
		protected function sendMes():void
		{
			sendNotification(SendEmailComponentMediator.SEND_EMAIL_DATA_BY_ID_CARD,obj);
		}
	}
}