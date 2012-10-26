package mediator.group
{
	import events.group.GroupExamineEvent;
	import events.group.GroupShowAndCloseEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.group.GroupProxy;
	
	import view.group.GroupAuditComponent;

	public class GroupAuditComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="GroupAuditComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		private var groupProxy:GroupProxy;
		private var list:Array=[];
		public function GroupAuditComponentMediator()
		{
			super(NAME, new GroupAuditComponent());
			comp.med=this;
			level=2;
			
			groupProxy=getProxy(GroupProxy);
			comp.upData(groupProxy.auditArr);
			
			comp.addEventListener(GroupShowAndCloseEvent.CLOSE,closeHandler);
			comp.addEventListener(GroupExamineEvent.ALL_ALLOW,allAllowHandler);
			comp.addEventListener(GroupExamineEvent.ALL_REFUSE,allRefuseHandler);
			comp.addEventListener(GroupExamineEvent.ALLOW,allowHandler);
			comp.addEventListener(GroupExamineEvent.REFUSE,refuseHandler);
		}
		
		protected function allAllowHandler(event:GroupExamineEvent):void
		{
			groupProxy.allow_all(function():void
			{
				comp.upData(list);
			});			
		}
		
		protected function allRefuseHandler(event:GroupExamineEvent):void
		{
			groupProxy.refuse_all(function():void
			{
				comp.upData(list);
			});
		}
		
		protected function allowHandler(event:GroupExamineEvent):void
		{
			groupProxy.allowJoinGroup(event.playerId,event.applyId,function():void
			{
				comp.upData(groupProxy.auditArr);
				groupProxy.refreshGroup();
			});
		}
		
		protected function refuseHandler(event:GroupExamineEvent):void
		{
			groupProxy.refresJoinGroup(event.playerId,event.applyId,function():void
			{
				comp.upData(groupProxy.auditArr);
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
		protected function get comp():view.group.GroupAuditComponent
		{
			return viewComponent as GroupAuditComponent;
		}

	}
}