package mediator.group
{
	import events.group.GroupShowAndCloseEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.group.GroupProxy;
	
	import view.group.GroupComponent;

	public class GroupComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="GroupComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		
		private var groupProxy:GroupProxy;
		public function GroupComponentMediator()
		{
			super(NAME, new GroupComponent());
			groupProxy=getProxy(GroupProxy);
			comp.med=this;
			level=1;
			
			comp.addEventListener(GroupShowAndCloseEvent.CLOSE,closeHandler);
			comp.addEventListener(GroupShowAndCloseEvent.SHOW_GROUPMANAGE,showGroupManageHandler);
			comp.addEventListener(GroupShowAndCloseEvent.SHOW_LOOKMEMBER,showLookMemberHandler)
			comp.addEventListener(GroupShowAndCloseEvent.SHOW_MEMBERMANAGE,showMemberManageHandler);
		}
		
		protected function closeHandler(event:GroupShowAndCloseEvent):void
		{
			sendNotification(DESTROY_NOTE);
		}
		
		protected function showGroupManageHandler(event:GroupShowAndCloseEvent):void
		{
			sendNotification(GroupManageComponentMediator.SHOW_NOTE);
		}
		
		protected function showLookMemberHandler(event:GroupShowAndCloseEvent):void
		{
			groupProxy.groupMemberList(groupProxy.groupInfoVo.id,function():void
			{				
				sendNotification(GroupMemberComponentMediator.SHOW_NOTE);
			});
		}
		
		protected function showMemberManageHandler(event:GroupShowAndCloseEvent):void
		{
			groupProxy.groupMemberList(groupProxy.groupInfoVo.id,function():void
			{				
				sendNotification(GroupMemberManageComponentMediator.SHOW_NOTE);
			});
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
		protected function get comp():GroupComponent
		{
			return viewComponent as GroupComponent;
		}

	}
}