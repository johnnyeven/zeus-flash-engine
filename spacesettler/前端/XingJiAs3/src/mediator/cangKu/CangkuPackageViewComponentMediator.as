package mediator.cangKu
{
	import com.zn.utils.ClassUtil;
	
	import events.buildingView.AddViewEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import view.cangKu.CangkuPackageViewComponent;

	/**
	 *模板 
	 * @author zn
	 * 
	 */
	public class CangkuPackageViewComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="CangkuPackageViewComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function CangkuPackageViewComponentMediator()
		{
			super(NAME, new CangkuPackageViewComponent(ClassUtil.getObject("cangKuPackage_view")));
			comp.addEventListener(AddViewEvent.CLOSE_EVENT,closeHandler);
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
		protected function get comp():CangkuPackageViewComponent
		{
			return viewComponent as CangkuPackageViewComponent;
		}
		
		protected function closeHandler(event:Event):void
		{
			sendNotification(DESTROY_NOTE);
		}

	}
}