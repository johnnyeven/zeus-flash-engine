package mediator.mainSence
{
	import events.buildEvent.BuildCompleteEvent;
	import events.buildingView.AddSelectorViewEvent;
	import events.buildingView.AddViewEvent;
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import mediator.BaseMediator;
	import mediator.buildingView.CangKuCreateComponentMediator;
	import mediator.buildingView.ChuanQinCreateComponentMediator;
	import mediator.buildingView.DianChangCreateComponentMediator;
	import mediator.buildingView.JunGongCreateComponentMediator;
	import mediator.buildingView.KeJiCreateComponentMediator;
	import mediator.buildingView.SelectorViewComponentMediator;
	import mediator.buildingView.YeLianCreateComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import view.mainSence.MainSenceComponent;


	/**
	 *主场景 
	 * @author zn
	 * 
	 */	
	public class MainSenceComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="MainSenceComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		
		public function MainSenceComponentMediator()
		{
			super(NAME, new MainSenceComponent());
			_popUp=false;
			
			comp.addEventListener(AddSelectorViewEvent.ADDSELECTORVIEW_EVENT,addSelectorViewHandler);
			comp.addEventListener(AddViewEvent.ADDCANGKUCREATEVIEW_EVENT,addCangKuCreateViewHandler);
			comp.addEventListener(AddViewEvent.ADDCHUANQINCREATEVIEW_EVENT,addChuanQinCreateViewHandler);
			comp.addEventListener(AddViewEvent.ADDDIANCHANGCREATEVIEW_EVENT,addDianChangCreateViewHandler);
			comp.addEventListener(AddViewEvent.ADDJUNGONGCREATEVIEW_EVENT,addJunGongCreateViewHandler);
			comp.addEventListener(AddViewEvent.ADDKEJICREATEVIEW_EVENT,addKeJiCreateViewHandler);
			comp.addEventListener(AddViewEvent.ADDYELIANCREATEVIEW_EVENT,addYeLianCreateViewHandler);
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
		protected function get comp():MainSenceComponent
		{
			return viewComponent as MainSenceComponent;
		}
		
		protected function addSelectorViewHandler(event:AddSelectorViewEvent):void
		{
			setTimeout(function():void
			{
				sendNotification(SelectorViewComponentMediator.SHOW_NOTE, event);
			},100);
		}
		
		protected function addCangKuCreateViewHandler(event:AddViewEvent):void
		{
			sendNotification(CangKuCreateComponentMediator.SHOW_NOTE);
		}
		
		protected function addChuanQinCreateViewHandler(event:AddViewEvent):void
		{
			sendNotification(ChuanQinCreateComponentMediator.SHOW_NOTE);
		}
		
		protected function addDianChangCreateViewHandler(event:AddViewEvent):void
		{
			sendNotification(DianChangCreateComponentMediator.SHOW_NOTE);
		}
		
		protected function addJunGongCreateViewHandler(event:AddViewEvent):void
		{
			sendNotification(JunGongCreateComponentMediator.SHOW_NOTE);
		}
		
		protected function addKeJiCreateViewHandler(event:AddViewEvent):void
		{
			sendNotification(KeJiCreateComponentMediator.SHOW_NOTE);
		}
		
		protected function addYeLianCreateViewHandler(event:AddViewEvent):void
		{
			sendNotification(YeLianCreateComponentMediator.SHOW_NOTE);
		}
	}
}