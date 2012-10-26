package mediator.email
{
	import events.email.EmailEvent;
	
	import mediator.BaseMediator;
	import mediator.WindowMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.email.SourceSendComponent;

	/**
	 *资源库存
	 * @author lw
	 *
	 */
	public class SourceSendComponentMediator extends WindowMediator implements IMediator
	{
		public static const NAME:String="SourceSendComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function SourceSendComponentMediator()
		{
			super(NAME, new SourceSendComponent());
			comp.med=this;
			level = 4;
			comp.addEventListener("closeSendSourceComponent",closeHandler);
			comp.addEventListener(EmailEvent.SEND_SOURCE_DATA_EVENT,sendSourceHandler);
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
		protected function get comp():SourceSendComponent
		{
			return viewComponent as SourceSendComponent;
		}

		private function sendSourceHandler(event:EmailEvent):void
		{
			sendNotification(DESTROY_NOTE);
			sendNotification(SendEmailComponentMediator.SELECTED_SOURCE_DATA,event.obj);
		}
	}
}