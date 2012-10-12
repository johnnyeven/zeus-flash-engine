package mediator.scienceResearch
{
	import events.scienceResearch.ScienceResearchEvent;
	
	import mediator.BaseMediator;
	import mediator.WindowMediator;
	import mediator.buildingView.CenterUpComponentMediator;
	import mediator.buildingView.KeJiUpComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.scienceResearch.PopuItemComponent;
	
	import vo.scienceResearch.ScienceResearchVO;

	/**
	 *科研弹出框
	 * @author lw
	 *
	 */
	public class PopuItemComponentMediator extends WindowMediator implements IMediator
	{
		public static const NAME:String="PopuItemComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function PopuItemComponentMediator()
		{
			super(NAME, new PopuItemComponent());
			level = 2;
			comp.addEventListener(ScienceResearchEvent.POPU_UP_EVENT,popuUpHandler);
			comp.addEventListener(ScienceResearchEvent.POPU_CLOSE_EVENT,closeHandler);
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
//				case SHOW_NOTE:
//				{
//					
//				}
			}
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		protected function get comp():PopuItemComponent
		{
			return viewComponent as PopuItemComponent;
		}

		public function setDat(data:Object):void
		{
			comp.data(data as ScienceResearchVO);
		}
		
		private function popuUpHandler(event:ScienceResearchEvent):void
		{
			if(event.scienceType == 1)
			{
				sendNotification(CenterUpComponentMediator.SHOW_NOTE);
			}
			else if(event.scienceType == 3)
			{
				sendNotification(KeJiUpComponentMediator.SHOW_NOTE);
			}
		}
	}
}