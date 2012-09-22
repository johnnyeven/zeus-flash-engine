package mediator.allView
{
	import events.allView.AllViewEvent;
	
	import mediator.BaseMediator;
	import mediator.WindowMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.allView.RongYuComponent;

	/**
	 *荣誉 
	 * @author lw
	 * 
	 */	
	public class RongYuComponentMediator extends WindowMediator implements IMediator
	{
		public static const NAME:String="RongYuComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function RongYuComponentMediator()
		{
			super(NAME, new RongYuComponent());
			
			comp.addEventListener(AllViewEvent.CLOSED_RONGYU_EVENT,closeHandler);
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
		protected function get comp():RongYuComponent
		{
			return viewComponent as RongYuComponent;
		}

	}
}