package mediator.email
{
	import events.email.EmailEvent;
	
	import mediator.BaseMediator;
	import mediator.WindowMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.email.EmailProxy;
	
	import view.email.EmailComponent;
	
	import vo.email.EmailItemVO;

	/**
	 *邮件
	 * @author lw
	 *
	 */
	public class EmailComponentMediator extends WindowMediator implements IMediator
	{
		public static const NAME:String="EmailComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		private var emailProxy:EmailProxy;
		public function EmailComponentMediator()
		{
			super(NAME, new EmailComponent());
			comp.med=this;
			level=1;
			emailProxy = getProxy(EmailProxy);
			
			comp.addEventListener(EmailEvent.RECEIVE_EMAIL_EVENT,receiveHandler);
			comp.addEventListener(EmailEvent.SEND_EMAIL_EVENT,sendEmailHandler);
			comp.addEventListener(EmailEvent.CLOSE_EVENT,closeHandler);
			comp.addEventListener(EmailEvent.DELETE_ONE_EMAIL_EVENT,deleteOneEmailHandler);
			comp.addEventListener(EmailEvent.DELETE_ALL_READ_EMAIL_EVENT,deleteAllHandler);
			comp.addEventListener(EmailEvent.SHOW_EMAIL_INFOR_EVENT,showEmailInforHandler);
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
		protected function get comp():EmailComponent
		{
			return viewComponent as EmailComponent;
		}

		private function sendEmailHandler(event:EmailEvent):void
		{
			sendNotification(SendEmailComponentMediator.SHOW_NOTE);
		}
		
		private function receiveHandler(event:EmailEvent):void
		{
			emailProxy.getEmailList();
		}
		
		private function deleteOneEmailHandler(event:EmailEvent):void
		{
//			event.stopImmediatePropagation();
			comp.deleteEmailBtn.visible = true;
			comp.deleteSuccessBtn.visible = false;
			emailProxy.deleteEmail(event.obj);
		}
		
		private function deleteAllHandler(event:EmailEvent):void
		{
			emailProxy.deleteEmail(event.obj);
		}
		
		private function showEmailInforHandler(event:EmailEvent):void
		{
//			event.stopImmediatePropagation();
			if((event.obj as EmailItemVO).is_read == false)
			{
				//没读过的邮件才进行标记
				emailProxy.isRead((event.obj as EmailItemVO).id);
			}
			
			sendNotification(ViewEmailComponentMediator.SHOW_NOTE,event.obj);
		}
	}
}