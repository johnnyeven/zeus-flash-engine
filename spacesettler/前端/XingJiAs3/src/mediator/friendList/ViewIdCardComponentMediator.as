package mediator.friendList
{
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.friendList.ViewIdCardComponent;

	/**
	 *查看军官证
	 * @author lw
	 *
	 */
	public class ViewIdCardComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="ViewIdCardComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function ViewIdCardComponentMediator()
		{
			super(NAME, new ViewIdCardComponent());
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
		protected function get comp():ViewIdCardComponent
		{
			return viewComponent as ViewIdCardComponent;
		}

	}
}