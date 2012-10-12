package mediator.cangKu
{
	import com.zn.utils.ClassUtil;
	
	import events.cangKu.ChaKanEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import view.cangKu.ChaKanDaoJuViewComponent;

	/**
	 *模板 
	 * @author zn
	 * 
	 */
	public class ChaKanDaoJuViewComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="ChaKanDaoJuViewComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function ChaKanDaoJuViewComponentMediator(viewComponent:Object=null)
		{
			super(NAME, new ChaKanDaoJuViewComponent(ClassUtil.getObject("item_View")));
			comp.med=this;
			level=2;
			comp.addEventListener(ChaKanEvent.CLOSEVIEW_EVENT,closeHandler);
		}
		
		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [DESTROY_NOTE];//SHOW_NOTE, 
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
				/*case SHOW_NOTE:
				{
					show();
					break;
				}*/
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
		protected function get comp():ChaKanDaoJuViewComponent
		{
			return viewComponent as ChaKanDaoJuViewComponent;
		}
		
		protected function closeHandler(event:Event):void
		{
			sendNotification(DESTROY_NOTE);
		}

	}
}