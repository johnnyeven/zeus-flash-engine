package mediator.email
{
	import com.zn.multilanguage.MultilanguageManager;
	
	import enum.item.ItemEnum;
	
	import events.showBag.ShowBagEvent;
	
	import mediator.BaseMediator;
	import mediator.WindowMediator;
	import mediator.email.SendEmailComponentMediator;
	import mediator.mainView.ChatViewMediator;
	import mediator.prompt.PromptSureMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.email.EmailShowBagComponent;
	import view.showBag.ShowBagComponent;

	/**
	 *展示武器界面
	 * @author lw
	 *
	 */
	public class EmailShowBagComponentMediator extends WindowMediator implements IMediator
	{
		public static const NAME:String="EmailShowBagComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		private var isEmailInfor:Boolean = false;
		public function EmailShowBagComponentMediator()
		{
			super(NAME, new EmailShowBagComponent());
			comp.med=this;
			level=4;
			comp.addEventListener(ShowBagEvent.SHOW_DATA_EVENT,dataHandler);
			comp.addEventListener(ShowBagEvent.CLOSE_EVENT,closeHandler);
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
		protected function get comp():EmailShowBagComponent
		{
			return viewComponent as EmailShowBagComponent;
		}
		
		public function isEmail(bool:Boolean):void
		{
			isEmailInfor = bool;
		}
		
		private function dataHandler(event:ShowBagEvent):void
		{
			if(isEmailInfor)
			{
				if(event.baseItemVO.item_type == ItemEnum.recipes)
				{
					//vip道具不能邮寄给别人
					var obj:Object = {infoLable:MultilanguageManager.getString("showBagTitle"),showLable:MultilanguageManager.getString("showBagInfor"),mediatorLevel:level};
					sendNotification(PromptSureMediator.SHOW_NOTE,obj);
					return;
				}
				else
				{
					sendNotification(SendEmailComponentMediator.SELECTED_ITEM_DATA,event.baseItemVO);
				}
				
			}
			else
			{
				
				sendNotification(ChatViewMediator.SHOW_ZHANCHE,event.baseItemVO);
			}
			sendNotification(DESTROY_NOTE);
		}

	}
}