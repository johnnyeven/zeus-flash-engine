package mediator.email
{
	import events.email.EmailEvent;
	
	import mediator.BaseMediator;
	import mediator.WindowMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.email.EmailProxy;
	
	import view.email.ViewEmailComponent;
	
	import vo.email.EmailItemVO;

	/**
	 *查看邮件
	 * @author lw
	 *
	 */
	public class ViewEmailComponentMediator extends WindowMediator implements IMediator
	{
		public static const NAME:String="ViewEmailComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		/**
		 * 收取附件成功
		 */		
		public static const receive_attachment:String="receive" + NAME + "attachment";

		private var emailProxy:EmailProxy;
		public function ViewEmailComponentMediator()
		{
			super(NAME, new ViewEmailComponent());
			
			comp.med = this;
			level = 2;
			emailProxy = getProxy(EmailProxy);
			
			comp.addEventListener(EmailEvent.RECEIVE_SOURCE_EVENT,receiveHandler);
			comp.addEventListener("closeViewEmailComponent",closeHandler);
			comp.addEventListener(EmailEvent.DELETE_EMAIL_BY_VIEW_COMPONENT_EVENT,deleteOwnHandler);
			comp.addEventListener(EmailEvent.CALL_BACK_EMAIL_EVENT,callBackHandler);
		}
		
		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [DESTROY_NOTE,receive_attachment];
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
				case receive_attachment:
				{
					comp.receive_attachment();
					break;
				}
			}
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		protected function get comp():ViewEmailComponent
		{
			return viewComponent as ViewEmailComponent;
		}
		
		public function setData(obj:Object):void
		{
			comp.data = (obj as EmailItemVO);
		}
		
		private function receiveHandler(event:EmailEvent):void
		{
			emailProxy.getSource(event.obj as String);
		}
		
		private function deleteOwnHandler(event:EmailEvent):void
		{
			emailProxy.deleteEmail(event.obj);
		}
		
		private function callBackHandler(event:EmailEvent):void
		{
			sendNotification(SendEmailComponentMediator.SHOW_NOTE);
			sendNotification(SendEmailComponentMediator.CALL_BACK_EMAIL,event.obj);
		}

	}
}