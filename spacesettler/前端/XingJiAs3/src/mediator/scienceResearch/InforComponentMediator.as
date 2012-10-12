package mediator.scienceResearch
{
	import events.scienceResearch.ScienceResearchEvent;
	
	import mediator.BaseMediator;
	import mediator.WindowMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.scienceResearch.InforComponent;

	/**
	 *科技描述 
	 * @author lw
	 * 
	 */	
	public class InforComponentMediator extends WindowMediator implements IMediator
	{
		public static const NAME:String="InforComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function InforComponentMediator()
		{
			super(NAME, new InforComponent());
			level = 2;
			
			comp.addEventListener(ScienceResearchEvent.CLOSE_INFOR_EVENT,closeHandler);
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
		protected function get comp():InforComponent
		{
			return viewComponent as InforComponent;
		}
		
		public function setScienceType(value:int):void
		{
			comp.scienceType = value;
		}

	}
}