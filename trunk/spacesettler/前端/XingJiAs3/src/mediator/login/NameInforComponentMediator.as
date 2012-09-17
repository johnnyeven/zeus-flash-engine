package mediator.login
{
	
	import events.login.NameInforEvent;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.login.LoginProxy;
	
	import view.login.NameInforComponent;
	
	/**
	 * 昵称
	 * @author lw
	 *
	 */
	public class NameInforComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="NameInforComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function NameInforComponentMediator()
		{
			super(NAME, new NameInforComponent());
			
			comp.addEventListener(NameInforEvent.BACK_EVENT,backHandler);
			comp.addEventListener(NameInforEvent.NEXT_EVENT,nextHandler);
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
		protected function get comp():NameInforComponent
		{
			return viewComponent as NameInforComponent;
		}

		private function backHandler(event:NameInforEvent):void
		{
			sendNotification(RegistComponentMediator.SHOW_NOTE);
		}
		
		private function nextHandler(event:NameInforEvent):void
		{
			var loginProxy:LoginProxy = getProxy(LoginProxy);
			loginProxy.regist(event.name,event.email);
			
			sendNotification(PkComponentMediator.SHOW_NOTE);
		}
	}
}