package mediator.groupFight
{
	import events.groupFight.GroupFightEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import view.groupFight.GroupFightMapComponent;
	import view.groupFight.GroupFightSenceComponent;

	/**
	 *模板 
	 * @author zn
	 * 
	 */
	public class GroupFightMapComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="GroupFightMapComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public static const MOVE_NOTE:String="move" + NAME + "Note";
		
		public static const CHANGE_NOTE:String="change" + NAME + "Note";

		private var _senceComp:GroupFightSenceComponent;
		
		public function GroupFightMapComponentMediator()
		{
			super(NAME, new GroupFightMapComponent());
			
			_popUp=false;
			comp.med=this;
			comp.x=comp.y=0;
			
			comp.addEventListener(GroupFightEvent.SENCECHANGE_EVENT,changeHandler);
		}
		
		protected function changeHandler(event:GroupFightEvent):void
		{
			sendNotification(GroupFightComponentMediator.SENCECHANGE_NOTE,event);
		}
		
		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [MOVE_NOTE,DESTROY_NOTE,CHANGE_NOTE];//SHOW_NOTE, 
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
				case MOVE_NOTE:
				{
					//销毁对象
					comp.rectMoveHandler(note.getBody() as GroupFightEvent);
					break;
				}
				case CHANGE_NOTE:
				{
					//销毁对象
					comp.updataMap();
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
		public function get comp():GroupFightMapComponent
		{
			return viewComponent as GroupFightMapComponent;
		}

	}
}