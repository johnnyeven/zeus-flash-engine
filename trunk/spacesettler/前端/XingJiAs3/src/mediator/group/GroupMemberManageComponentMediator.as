package mediator.group
{
	import events.group.GroupShowAndCloseEvent;
	import events.group.MemberManageEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.group.GroupProxy;
	
	import view.group.GroupMemberManageComponent;

	public class GroupMemberManageComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="GroupMemberManageComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		private var groupProxy:GroupProxy;
		public function GroupMemberManageComponentMediator()
		{
			super(NAME, new GroupMemberManageComponent());			
			comp.med=this;
			level=2;
			groupProxy=getProxy(GroupProxy);
			
//			comp.upData(groupProxy.memberArr);
			comp.addEventListener(GroupShowAndCloseEvent.CLOSE,closeHandler);
			comp.addEventListener(MemberManageEvent.SURE_EVENT,sureHandler);
		}
		
		protected function sureHandler(event:MemberManageEvent):void
		{
			groupProxy.legion_member_manage(event._member_level,event._member_warship_capacity,
											event._member_id,event._kick_member,function():void
											{
												comp.upData(groupProxy.memberArr);
											});
		}
		
		protected function closeHandler(event:GroupShowAndCloseEvent):void
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
		protected function get comp():GroupMemberManageComponent
		{
			return viewComponent as GroupMemberManageComponent;
		}

	}
}