package mediator.friendList
{
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.friendList.EnemyListComponent;

	/**
	 *显示敌人列表
	 * @param lw
	 *
	 */
	public class EnemyListComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="EnemyListComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function EnemyListComponentMediator()
		{
			super(NAME, new EnemyListComponent());
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
		protected function get comp():EnemyListComponent
		{
			return viewComponent as EnemyListComponent;
		}

	}
}