package mediator.mainView
{
	import events.buildingView.ZhuJiDiEvent;
	
	import mediator.BaseMediator;
	import mediator.MainMediator;
	import mediator.allView.AllViewComponentMediator;
	import mediator.allView.RongYuComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.facade.Facade;
	
	import proxy.allView.AllViewProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import view.mainView.MainViewComponent;

	/**
	 *游戏主界面
	 * @author zn
	 *
	 */
	public class MainViewMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="MainViewMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		private var allViewProxy:AllViewProxy;
		private var userInforProxy:UserInfoProxy;
		private var id:String;
		
		public function MainViewMediator()
		{
			super(NAME, new MainViewComponent());

			_popUp=false;
			

			allViewProxy = getProxy(AllViewProxy);
			userInforProxy = getProxy(UserInfoProxy);
			id = userInforProxy.userInfoVO.id;
			comp.addEventListener(ZhuJiDiEvent.RONGYU_EVENT,rongYuHandler);
			comp.addEventListener(ZhuJiDiEvent.ALLVIEW_EVENT,zhongLanHandler);
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
		protected function get comp():MainViewComponent
		{
			return viewComponent as MainViewComponent;
		}

		/**
		 *显示界面
		 *
		 */
		public override function show():void
		{
			MainMediator(getMediator(MainMediator)).component.addView(uiComp);
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
	}
}