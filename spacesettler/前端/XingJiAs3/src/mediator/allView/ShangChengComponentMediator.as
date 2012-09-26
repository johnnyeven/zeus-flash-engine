package mediator.allView
{
	
	import events.allView.AllViewEvent;
	import events.allView.FriendGiveEvent;
	import events.allView.ShopEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.allView.shangChengView.FriendGiveComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.allView.ShopProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import view.allView.ShangChengComponent;

	public class ShangChengComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="ShangChengComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		private var shopProxy:ShopProxy;
		private var userProxy:UserInfoProxy;
		public function ShangChengComponentMediator()
		{
			super(NAME, new ShangChengComponent());
			shopProxy=getProxy(ShopProxy);
			userProxy=getProxy(UserInfoProxy);
			
			comp.addEventListener(FriendGiveEvent.SHOW_FRIENDGIVE,showFriendCompHandler);
			comp.addEventListener(ShopEvent.BUY_ITEM,buyItemHandler);
			comp.addEventListener(ShopEvent.BUY_DARK_CRYSTAL,buyDarkCrystalHandler);
			comp.addEventListener(ShopEvent.BUY_RESOURCE,buyResourceHandler);
			comp.addEventListener(AllViewEvent.CLOSED_EVENT,close_Handler);
		}
		
		protected function showFriendCompHandler(event:FriendGiveEvent):void
		{
			
			var data:Object={arr:event.arr,text:event.text,num:event.num,titleText:event.titleText}
			sendNotification(FriendGiveComponentMediator.SHOW_NOTE,data);
		}
		
		protected function buyItemHandler(event:ShopEvent):void
		{
			shopProxy.buyItem(userProxy.userInfoVO.player_id,event.num,event.resourceName);
		}
		
		protected function buyDarkCrystalHandler(event:ShopEvent):void
		{
			shopProxy.buyCrystal(userProxy.userInfoVO.player_id,event.resourceName);
		}
		
		protected function close_Handler(event:AllViewEvent):void
		{
			sendNotification(DESTROY_NOTE);
		}
		
		protected function buyResourceHandler(event:ShopEvent):void
		{
			shopProxy.buyResource(event.resourceName,event.num,userProxy.userInfoVO.player_id);
			
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
		protected function get comp():view.allView.ShangChengComponent
		{
			return viewComponent as ShangChengComponent;
		}

	}
}