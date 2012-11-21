package mediator.shangCheng
{
	import events.allView.FriendGiveEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.friendList.FriendProxy;
	import proxy.shangCheng.ShopProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import view.shangCheng.shangChengView.FriendGiveComponent;

	public class FriendGiveComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="FriendGiveComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		private var shopProxy:ShopProxy;
		private var userProxy:UserInfoProxy;
		private var friendProxy:FriendProxy;
		public function FriendGiveComponentMediator()
		{
			super(NAME, new FriendGiveComponent());
			
			shopProxy=getProxy(ShopProxy);
			userProxy=getProxy(UserInfoProxy);
			friendProxy=getProxy(FriendProxy);
			
			this.popUpEffect=CENTER;
			comp.med=this;
			level=3;
			
			comp.addEventListener(FriendGiveEvent.CLOSE_FRIENDGIVE,closeFriendGiveHandler);
			comp.addEventListener(FriendGiveEvent.SURE_BTN_CLICK,doGiveHandler);
		}
		
		protected function doGiveHandler(event:FriendGiveEvent):void
		{
			//TODO:GX 完善赠送
			shopProxy.buyItemFriend(userProxy.userInfoVO.player_id,event.num,event.text);
			sendNotification(DESTROY_NOTE);
		}
		
		public function setFriendConst(arr:Array,text:String,num:String,titleText:String,source:String):void
		{
			friendProxy.getFriendList(userProxy.userInfoVO.player_id,function():void
			{
				comp.setFriendConst(friendProxy.friendArr,text,num,titleText,source);
			});
			
		}
		
		protected function closeFriendGiveHandler(event:FriendGiveEvent):void
		{
			sendNotification(DESTROY_NOTE);
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
		protected function get comp():FriendGiveComponent
		{
			return viewComponent as FriendGiveComponent;
		}

	}
}