package mediator.mainView
{
	import events.allView.AllViewEvent;
	import events.buildingView.ZhuJiDiEvent;
	import events.talk.TalkEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.allView.AllViewComponentMediator;
	import mediator.allView.RongYuComponentMediator;
	import mediator.allView.ShangChengComponentMediator;
	import mediator.cangKu.CangkuPackageViewComponentMediator;
	
	import mx.core.UIComponent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import proxy.allView.AllViewProxy;
	import proxy.allView.ShopProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import view.mainView.ControlViewComponent;
	
	public class ControlViewMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="ControlViewMediator";
		
		public static const SHOW_NOTE:String="show" + NAME + "Note";
		
		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		private var allViewProxy:AllViewProxy;
		private var userInforProxy:UserInfoProxy;
		private var id:String;
		
		public function ControlViewMediator()
		{
			super(NAME,new ControlViewComponent());
			
			allViewProxy = getProxy(AllViewProxy);
			userInforProxy = getProxy(UserInfoProxy);
			
			id = userInforProxy.userInfoVO.id;
			comp.addEventListener(ZhuJiDiEvent.RONGYU_EVENT,rongYuHandler);
			comp.addEventListener(ZhuJiDiEvent.ALLVIEW_EVENT,zhongLanHandler);
			comp.addEventListener(ZhuJiDiEvent.CANGKU_EVENT,cangKuHandler);
			comp.addEventListener(ZhuJiDiEvent.SHOP_EVENT,shopHandler);
		}
				
		
		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [SHOW_NOTE, DESTROY_NOTE];
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
				case SHOW_NOTE:
				{
					show();
					break;
				}
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
		protected function get comp():ControlViewComponent
		{
			return viewComponent as ControlViewComponent;
		}
		
		private function shopHandler(event:ZhuJiDiEvent):void
		{
			
			sendNotification(ShangChengComponentMediator.SHOW_NOTE);
		}
		
		private function rongYuHandler(event:ZhuJiDiEvent):void
		{
			allViewProxy.allView(id);
			sendNotification(RongYuComponentMediator.SHOW_NOTE);
		}
		
		private function zhongLanHandler(event:ZhuJiDiEvent):void
		{
			allViewProxy.allView(id);
			sendNotification(AllViewComponentMediator.SHOW_NOTE);
		}
		
		private function cangKuHandler(event:ZhuJiDiEvent):void
		{
			sendNotification(CangkuPackageViewComponentMediator.SHOW_NOTE);
		}
	}
}