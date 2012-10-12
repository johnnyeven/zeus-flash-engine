package mediator.buildingView
{
	import com.zn.utils.ClassUtil;
	
	import events.buildingView.AddViewEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import view.buildingView.SpeedViewComponent;

	/**
	 *模板 
	 * @author zn
	 * 
	 */
	public class SpeedViewComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="ComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function SpeedViewComponentMediator()
		{
			super(NAME, new SpeedViewComponent(ClassUtil.getObject("speed_info_view")));
			comp.med=this;
			level=2;
			comp.addEventListener(AddViewEvent.CLOSE_EVENT,closehandler);
		}
		
		protected function closehandler(event:AddViewEvent):void
		{
			sendNotification(DESTROY_NOTE);
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
		protected function get comp():SpeedViewComponent
		{
			return viewComponent as SpeedViewComponent;
		}

	}
}