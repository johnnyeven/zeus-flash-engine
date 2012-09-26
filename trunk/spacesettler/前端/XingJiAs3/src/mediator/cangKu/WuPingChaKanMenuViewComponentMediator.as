package mediator.cangKu
{
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import ui.managers.PopUpManager;
	
	import view.cangKu.WuPingChaKanMenuViewComponent;

	/**
	 *物品查看菜单界面 
	 * @author zn
	 * 
	 */
	public class WuPingChaKanMenuViewComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="WuPingChaKanMenuViewComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public var viewComp:WuPingChaKanMenuViewComponent;
		public function WuPingChaKanMenuViewComponentMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
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
					viewComp=new WuPingChaKanMenuViewComponent("武器",1);
					
					PopUpManager.addPopUp(viewComp);
					viewComp.move();
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
		protected function get comp():WuPingChaKanMenuViewComponent
		{
			return viewComponent as WuPingChaKanMenuViewComponent;
		}

	}
}