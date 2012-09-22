package mediator.login
{
	
	
	import events.login.PkEvent;
	
	import mediator.BaseMediator;
	import mediator.prompt.PromptMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.login.LoginProxy;
	
	import view.login.PkComponent;

	/**
	 * 阵营
	 * @author lw
	 *
	 */
	public class PkComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="PkComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function PkComponentMediator()
		{
			super(NAME, new PkComponent());
			
			comp.addEventListener(PkEvent.BACK_EVENT,backHandler);
			comp.addEventListener(PkEvent.START_EVENT,startHandler);
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
					sendNotification(PromptMediator.HIDE_LOGIN_INFO_NOTE);
					break;
				}
			}
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		protected function get comp():PkComponent
		{
			return viewComponent as PkComponent;
		}
		
		private function backHandler(event:PkEvent):void
		{
			destoryCallback = function():void
			{
			   sendNotification(NameInforComponentMediator.SHOW_NOTE);
			};
			sendNotification(DESTROY_NOTE);
		}

		private function startHandler(event:PkEvent):void
		{
			var loginProxy:LoginProxy = getProxy(LoginProxy);
			loginProxy.camp=comp.campID;
				
			   loginProxy.regist(function():void
			   {
				   sendNotification(DESTROY_NOTE);
			   });			
		}
	}
}