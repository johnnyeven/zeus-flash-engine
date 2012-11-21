package mediator.giftBag
{
	import events.giftBag.GiftBagEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import ui.managers.PopUpManager;
	
	import view.giftBag.GiftDetileInfoViewComponent;

	/**
	 *模板 
	 * @author zn
	 * 
	 */
	public class GiftDetileInfoViewComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="GiftDetileInfoViewComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function GiftDetileInfoViewComponentMediator()
		{
			super(NAME, new GiftDetileInfoViewComponent());
			comp.med = this;
			level = 2;
			
			_popUp = true;
			mode = true;
			popUpEffect=CENTER;
			
			width=314;
			height=321;
			
			comp.addEventListener(GiftBagEvent.CLOSEVIEW_EVENT,closeViewHandler);
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
		public function get comp():GiftDetileInfoViewComponent
		{
			return viewComponent as GiftDetileInfoViewComponent;
		}
		
		public override function destroy():void
		{
			PopUpManager.removePopUp(uiComp);
		}
		
		protected function closeViewHandler(event:Event):void
		{
			sendNotification(DESTROY_NOTE);
		}

	}
}