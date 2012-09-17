package mediator.login
{
	
	import events.login.StartLoginEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.login.StartComponent;

	/**
	 *开始
	 * @author lw
	 *
	 */
	public class StartComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="StartComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function StartComponentMediator()
		{
			super(NAME, new StartComponent());
			
			comp.addEventListener(StartLoginEvent.START_LIGIN_EVENT,startLoginHandler);
			comp.addEventListener(StartLoginEvent.ACCOUNT_EVENT,accountHandler);
			comp.addEventListener(StartLoginEvent.REGIST_EVENT,registHandler);
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
		protected function get comp():StartComponent
		{
			return viewComponent as StartComponent;
		}

		private function startLoginHandler(event:StartLoginEvent):void
		{
			
		}
		
		private function accountHandler(event:StartLoginEvent):void
		{
			sendNotification(LoginMediator.SHOW_NOTE);
		}
		
		private function registHandler(event:StartLoginEvent):void
		{
			sendNotification(RegistComponentMediator.SHOW_NOTE);
		}
	}
}