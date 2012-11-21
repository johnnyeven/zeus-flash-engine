package mediator.systemView
{
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.systemView.SystemPassWordComponent;

	public class SystemPassWordComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="SystemPassWordComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function SystemPassWordComponentMediator()
		{
			super(NAME, new SystemPassWordComponent());
			
			comp.med=this;
			popUpEffect=CENTER;
			level=2;
			
			comp.addEventListener(SystemPassWordComponent.OK_EVENT,okhandler);
			comp.addEventListener(SystemPassWordComponent.NO_EVENT,nohandler);
		}
		
		protected function nohandler(event:Event):void
		{
			sendNotification(DESTROY_NOTE);
		}
		
		protected function okhandler(event:Event):void
		{
			// TODO GX
			
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
		protected function get comp():SystemPassWordComponent
		{
			return viewComponent as SystemPassWordComponent;
		}

	}
}