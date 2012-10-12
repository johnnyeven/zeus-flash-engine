package mediator.cangKu
{
	import com.zn.utils.ClassUtil;
	
	import events.buildingView.AddViewEvent;
	import events.cangKu.DonateEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import view.cangKu.DonateViewComponent;

	/**
	 *模板 
	 * @author zn
	 * 
	 */
	public class DonateViewComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="DonateViewComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		private var okCallBack:Function;
		public function DonateViewComponentMediator()
		{
			super(NAME, new DonateViewComponent(ClassUtil.getObject("donate_view")));
			comp.med=this;
			level = 2;
			popUpEffect=CENTER;
			comp.addEventListener(AddViewEvent.CLOSE_EVENT,closeHandler);
			comp.addEventListener(DonateViewComponent.OK_EVENT, okHandler);
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
		
		public function upData(data:*):void
		{
			var obj:Object = data;
			comp.juanXianWuLabel.text=obj.name;
			comp.zheHeNumLabel.text=String(obj.count);
			okCallBack = obj.okCallBack;
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
		protected function get comp():DonateViewComponent
		{
			return viewComponent as DonateViewComponent;
		}
		
		protected function closeHandler(event:AddViewEvent):void
		{
			sendNotification(DESTROY_NOTE);
		}
		
		protected function okHandler(event:Event):void
		{
			if (okCallBack != null)
				okCallBack();
			okCallBack = null;
			
			sendNotification(DESTROY_NOTE);
		}
		
	}
}