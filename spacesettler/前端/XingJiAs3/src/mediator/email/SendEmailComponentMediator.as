package mediator.email
{
	import events.email.EmailEvent;
	
	import mediator.BaseMediator;
	import mediator.WindowMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.email.EmailProxy;
	
	import view.email.SendEmailComponent;
	
	import vo.email.EmailItemVO;

	/**
	 * 发送新邮件
	 * @author lw
	 *
	 */
	public class SendEmailComponentMediator extends WindowMediator implements IMediator
	{
		public static const NAME:String="SendEmailComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		/**
		 * 回复邮件数据
		 */		
		public static const CALL_BACK_EMAIL:String = "call" + NAME +"back_email";
		 
		private var emailProxy:EmailProxy;
		public function SendEmailComponentMediator()
		{
			super(NAME, new SendEmailComponent());
			
			emailProxy = getProxy(EmailProxy);
			comp.addEventListener(EmailEvent.CLOSE_SEND_EMAIL_EVENT,closeHandler);
			comp.addEventListener(EmailEvent.SEND_NEW_EMAIL_EVENT,sendNewEmailHandler);
		}
		
		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [DESTROY_NOTE,CALL_BACK_EMAIL];
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
				case CALL_BACK_EMAIL:
				{
					comp.setData(note.getBody() as EmailItemVO);
					break;
				}
			}
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		protected function get comp():SendEmailComponent
		{
			return viewComponent as SendEmailComponent;
		}
		
		private function sendNewEmailHandler(event:EmailEvent):void
		{
			emailProxy.sendEmail(event.obj);
		}

	}
}