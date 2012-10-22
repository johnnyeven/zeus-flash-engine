package mediator.showBag
{
	import events.showBag.ShowBagEvent;
	
	import mediator.BaseMediator;
	import mediator.WindowMediator;
	import mediator.mainView.ChatViewMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.showBag.ShowBagComponent;

	/**
	 *展示武器界面
	 * @author lw
	 *
	 */
	public class ShowBagComponentMediator extends WindowMediator implements IMediator
	{
		public static const NAME:String="ShowBagComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function ShowBagComponentMediator()
		{
			super(NAME, new ShowBagComponent());
			
			comp.addEventListener(ShowBagEvent.SHOW_DATA_EVENT,dataHandler);
			comp.addEventListener(ShowBagEvent.CLOSE_EVENT,closeHandler);
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
		protected function get comp():ShowBagComponent
		{
			return viewComponent as ShowBagComponent;
		}
		
		private function dataHandler(event:ShowBagEvent):void
		{
			sendNotification(DESTROY_NOTE);
			sendNotification(ChatViewMediator.SHOW_ZHANCHE,event.baseItemVO);
		}

	}
}