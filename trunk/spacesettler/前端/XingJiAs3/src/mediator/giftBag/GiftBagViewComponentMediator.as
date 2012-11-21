package mediator.giftBag
{
	import com.zn.utils.ClassUtil;
	
	import events.giftBag.GiftBagEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import proxy.taskGift.GiftBagProxy;
	
	import view.giftBag.GiftBagViewComponent;

	/**
	 *模板 
	 * @author zn
	 * 
	 */
	public class GiftBagViewComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="GiftBagViewComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public static const UPDATE_NOTE:String="update" + NAME + "Note";

		private var _giftProxy:GiftBagProxy;
		public function GiftBagViewComponentMediator()
		{
			super(NAME, new GiftBagViewComponent());
			comp.med = this;
			level = 1;
			
			_giftProxy=getProxy(GiftBagProxy);
			
			comp.addEventListener(GiftBagEvent.CLOSEVIEW_EVENT,closeViewHandler);
			comp.addEventListener(GiftBagEvent.GETGIFT_EVENT,getGiftHandler);
			comp.addEventListener(GiftBagEvent.GIFTITEM_EVENT,getOnlineGiftInfoHandler);
		}
		
		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [DESTROY_NOTE,UPDATE_NOTE];//SHOW_NOTE, 
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
				case UPDATE_NOTE:
				{
					comp.updataItem(note.getBody() as Array);
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
		public function get comp():GiftBagViewComponent
		{
			return viewComponent as GiftBagViewComponent;
		}
		
		protected function closeViewHandler(event:Event):void
		{
			sendNotification(DESTROY_NOTE);
		}
		
		protected function getGiftHandler(event:GiftBagEvent):void
		{
			_giftProxy.receiveReward(event.itemType,function ():void
			{
				
			});
		}
		
		protected function getOnlineGiftInfoHandler(event:GiftBagEvent):void
		{
			sendNotification(GiftDetileInfoViewComponentMediator.SHOW_NOTE,event.itemType);
		}

	}
}