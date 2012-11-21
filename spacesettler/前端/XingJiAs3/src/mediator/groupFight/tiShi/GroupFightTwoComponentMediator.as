package mediator.groupFight.tiShi
{
	import enum.groupFightEnum.GroupFightEnum;
	
	import events.groupFight.GroupFightEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.groupFight.GroupFightComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.groupFight.GroupFightProxy;
	
	import view.groupFight.GroupFightComponent;
	import view.groupFight.tiShi.GroupFightTwoComponent;

	public class GroupFightTwoComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="GroupFightTwoComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		private var groupFightProxy:GroupFightProxy;
		public function GroupFightTwoComponentMediator()
		{
			super(NAME, new GroupFightTwoComponent());
			groupFightProxy=getProxy(GroupFightProxy);
			comp.med=this;
			level=3;
			popUpEffect=UP;
			
			comp.upData(GroupFightEnum.CURRTENT_STARVO);
			comp.addEventListener(GroupFightEvent.CLOSE_EVENT,closeHandler);
			comp.addEventListener(GroupFightEvent.SURE_EVENT,sureHandler);
		}
		
		protected function sureHandler(event:GroupFightEvent):void
		{
			GroupFightEnum.NUM=event.warship_count;
			if(GroupFightEnum.CURRTENT_TO_STARVO.isMine)
			{
				groupFightProxy.move_to_star(GroupFightEnum.CURRTENT_STARVO.name,GroupFightEnum.CURRTENT_TO_STARVO.name,
										event.warship_count,function():void
										{
											GroupFightComponent.MOUSE_ENABLED=true;
											sendNotification(DESTROY_NOTE);
										});				
			}else
			{
				sendNotification(GroupFightComponentMediator.ATTACK_NOTE);
				sendNotification(DESTROY_NOTE);
			}
		}
		
		protected function closeHandler(event:GroupFightEvent):void
		{
			GroupFightComponent.MOUSE_ENABLED=true;
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
		protected function get comp():GroupFightTwoComponent
		{
			return viewComponent as GroupFightTwoComponent;
		}

	}
}