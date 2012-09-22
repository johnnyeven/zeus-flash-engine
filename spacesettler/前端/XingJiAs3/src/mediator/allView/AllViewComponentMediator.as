package mediator.allView
{
	
	import events.allView.AllViewEvent;
	
	import flash.sensors.Accelerometer;
	
	import mediator.BaseMediator;
	import mediator.WindowMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.allView.AllViewProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import view.allView.AllViewComponent;

	/**
	 * 总览
	 * @author lw
	 * 
	 */	
	public class AllViewComponentMediator extends WindowMediator implements IMediator
	{
		public static const NAME:String="AllViewComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		private var allViewProxy:AllViewProxy;
		private var userInforProxy:UserInfoProxy;
		
		public function AllViewComponentMediator()
		{
			super(NAME, new AllViewComponent());
			
			allViewProxy = getProxy(AllViewProxy);
			userInforProxy = getProxy(UserInfoProxy);
			comp.addEventListener(AllViewEvent.VIEW_START_EVENT,allViewHandler);
			comp.addEventListener(AllViewEvent.VIEW_RONGYU_EVENT,viewRongYuHandler);
			comp.addEventListener(AllViewEvent.CLOSED_EVENT,closeHandler);
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
		protected function get comp():AllViewComponent
		{
			return viewComponent as AllViewComponent;
		}

		private function allViewHandler(event:AllViewEvent):void
		{
			
		}
		
		private function viewRongYuHandler(event:AllViewEvent):void
		{
			var id:String = userInforProxy.userInfoVO.id;
			allViewProxy.allView(id);
			sendNotification(RongYuComponentMediator.SHOW_NOTE);
		}
	}
}