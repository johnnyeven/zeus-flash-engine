package mediator.login
{
	
	import events.login.RegistEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.login.LoginProxy;
	
	import view.login.RegistComponent;

	/**
	 * 注册
	 * @author lw
	 *
	 */
	public class RegistComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="RegistComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function RegistComponentMediator()
		{
			super(NAME, new RegistComponent());
			
			comp.addEventListener(RegistEvent.BACK_EVENT,backHandler);
			comp.addEventListener(RegistEvent.NEXT_EVENT,nextHandler);
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
		protected function get comp():RegistComponent
		{
			return viewComponent as RegistComponent;
		}

		protected function backHandler(event:RegistEvent):void
		{
			sendNotification(StartComponentMediator.SHOW_NOTE);
		}
		
		private function nextHandler(event:RegistEvent):void
		{
			var loginProxy:LoginProxy = getProxy(LoginProxy);
			loginProxy.infor(event.severName,event.userName,event.passWord,event.passAgainWord);
			sendNotification(NameInforComponentMediator.SHOW_NOTE);
		}
	}
}