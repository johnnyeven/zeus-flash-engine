package mediator.groupFight.tiShi
{
	import enum.groupFightEnum.GroupFightEnum;
	
	import events.groupFight.GroupFightEvent;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.groupFight.tiShi.GroupFightOneComponent;

	public class GroupFightOneComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="GroupFightOneComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		
		public function GroupFightOneComponentMediator()
		{
			super(NAME, new GroupFightOneComponent());
			popUpEffect=CENTER;
			comp.med=this;
			level=3;
			
			comp.addEventListener(GroupFightEvent.CLOSE_EVENT,closeHandler);
			comp.upData(GroupFightEnum.CURRTENT_STARVO);
		}
		
		protected function closeHandler(event:GroupFightEvent):void
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
		protected function get comp():GroupFightOneComponent
		{
			return viewComponent as GroupFightOneComponent;
		}

	}
}