package mediator.mainView
{
	import mediator.BaseMediator;
	import mediator.MainMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.facade.Facade;
	
	import view.mainView.MainViewComponent;

	/**
	 *游戏主界面
	 * @author zn
	 *
	 */
	public class MainViewMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="MainViewMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function MainViewMediator()
		{
			super(NAME, new MainViewComponent());

			_popUp=false;
			

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
		protected function get comp():MainViewComponent
		{
			return viewComponent as MainViewComponent;
		}

		/**
		 *显示界面
		 *
		 */
		public override function show():void
		{
			MainMediator(getMediator(MainMediator)).component.addView(uiComp);
		}

	}
}