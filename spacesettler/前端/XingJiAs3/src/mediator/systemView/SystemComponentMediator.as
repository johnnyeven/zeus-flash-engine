package mediator.systemView
{
	
	import com.zn.utils.URLFunc;
	
	import events.system.SystemEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.MainMediator;
	import mediator.mainSence.MainSenceComponentMediator;
	import mediator.mainView.MainViewMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.systemView.SystemComponent;

	public class SystemComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="SystemComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function SystemComponentMediator()
		{
			super(NAME, new SystemComponent());
			
			
			comp.addEventListener(SystemEvent.CLOSE_ALL,closeAll_clickHandler);
			comp.addEventListener(SystemEvent.SHOW_ACCOUNTNUMBERBOUNDARY,accountNumberBtn_clickHandler);
			comp.addEventListener(SystemEvent.SHOW_HELPBOUNDARY,helpBtn_clickHandler);
			comp.addEventListener(SystemEvent.SHOW_OPTIONBOUNDARY,optionBtn_clickHandler);
			comp.addEventListener(SystemEvent.LOGIN_OUT,loginOutHandler);
		}
		
		protected function loginOutHandler(event:Event):void
		{
			URLFunc.openHTML(URLFunc.getURL());
		}
		
		protected function optionBtn_clickHandler(event:SystemEvent):void
		{
			sendNotification(OptionBoundaryComponentMediator.SHOW_NOTE);
		}
		
		protected function helpBtn_clickHandler(event:SystemEvent):void
		{
			sendNotification(HelpBoundaryComponentMediator.SHOW_NOTE);
		}
		
		protected function accountNumberBtn_clickHandler(event:SystemEvent):void
		{
			sendNotification(AccountNumberBoundaryComponentMediator.SHOW_NOTE);
		}
		
		protected function closeAll_clickHandler(event:SystemEvent):void
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
		protected function get comp():SystemComponent
		{
			return viewComponent as SystemComponent;
		}

	}
}