package mediator.ranking
{
	
	import events.ranking.RankingEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.ranking.rankingPvpComponent;

	public class rankingPvpComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="rankingPvpComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function rankingPvpComponentMediator()
		{
			super(NAME, new rankingPvpComponent());
			this.popUpEffect=UP;
			level=2;
			comp.med=this;
			
			comp.addEventListener(RankingEvent.CLOSE,closeHandler);
		}
		
		protected function closeHandler(event:RankingEvent):void
		{
			sendNotification(DESTROY_NOTE);
//			sendNotification(RankingComponentMediator.SHOW_NOTE);
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
		protected function get comp():rankingPvpComponent
		{
			return viewComponent as rankingPvpComponent;
		}

	}
}