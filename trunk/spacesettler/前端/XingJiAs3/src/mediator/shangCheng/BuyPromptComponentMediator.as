package mediator.shangCheng
{
	import events.allView.ShopEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import proxy.shangCheng.ShopProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.managers.PopUpManager;
	
	import view.shangCheng.shangChengView.BuyPromptComponent;

	/**
	 *模板 
	 * @author zn
	 * 
	 */
	public class BuyPromptComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="BuyPromptComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public var okCallBack:Function;
		
		public var evt:ShopEvent;
		private var _data:Object;
		
		private var shopProxy:ShopProxy;
		private var userProxy:UserInfoProxy;
		
		public function BuyPromptComponentMediator()
		{
			super(NAME, new BuyPromptComponent());
			_popUp = true;
			mode = true;
			popUpEffect=CENTER;
			
			comp.med=this;
			level=2;
			
			shopProxy=getProxy(ShopProxy);
			userProxy=getProxy(UserInfoProxy);
			
			comp.addEventListener(BuyPromptComponent.NO_EVENT,noHandler);
			comp.addEventListener(BuyPromptComponent.OK_EVENT,okHandler);
		}
		
		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [ DESTROY_NOTE];//
		}

		/**
		 *消息处理
		 * @param note
		 *
		 */
		override public function handleNotification(note:INotification):void
		{
			evt= note.getBody() as ShopEvent;
			switch (note.getName())
			{
				/*case SHOW_NOTE:
				{
					comp.infoLabel.text ="你确定要兑换" + evt.resourceName +"吗？";
					okCallBack = evt.okCallBack;
					
					show();
					break;
				}*/
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
		public function get comp():BuyPromptComponent
		{
			return viewComponent as BuyPromptComponent;
		}
		
		public override function destroy():void
		{
			PopUpManager.removePopUp(uiComp);
		}
		
		protected function okHandler(event:Event):void
		{
			/*if (okCallBack != null)
				okCallBack();
			okCallBack = null;*/
			shopProxy.buyItem(userProxy.userInfoVO.player_id,_data.key,_data.resourceName);
			
			sendNotification(DESTROY_NOTE);
		}
		
		protected function noHandler(event:Event):void
		{
			
			sendNotification(DESTROY_NOTE);
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		public function set data(value:Object):void
		{
			_data=value;
		}
	}
}