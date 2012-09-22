package mediator.mainView
{
	import mediator.BaseMediator;
	
	import mx.core.UIComponent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import view.mainView.ChatViewComponent;
	
	public class ChatViewMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="ChatViewMediator";
		
		public static const SHOW_NOTE:String="show" + NAME + "Note";
		
		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		public function ChatViewMediator()
		{
			super(NAME, new ChatViewComponent());
		}
		
		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [SHOW_NOTE, DESTROY_NOTE];
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
				case SHOW_NOTE:
				{
					show();
					break;
				}
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
		protected function get comp():UIComponent
		{
			return viewComponent as UIComponent;
		}
	}
}