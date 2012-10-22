package mediator.group
{
	import events.group.GroupManageEvent;
	import events.group.GroupShowAndCloseEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.group.GroupProxy;
	
	import view.group.GroupManageComponent;

	public class GroupManageComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="GroupManageComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		
		private var groupProxy:GroupProxy;
		public function GroupManageComponentMediator()
		{
			super(NAME, new GroupManageComponent());
			comp.med=this;
			level=2;
			groupProxy=getProxy(GroupProxy);
			
			comp.addEventListener(GroupShowAndCloseEvent.CLOSE,closeHandler);
			comp.addEventListener(GroupManageEvent.GENGAI_EVENT,genGaiHandler);
			comp.addEventListener(GroupShowAndCloseEvent.SHOW_SHENHE_EVENT,showShenHeHandler);
			comp.addEventListener(GroupManageEvent.ZHIZAO_EVENT,zhiZaoHandler);
			comp.addEventListener(GroupManageEvent.ZHIZAO_COMPLETE_EVENT,zhiZaoCompleteHandler);
			comp.upData(groupProxy.groupInfoVo);
		}
		
		protected function showShenHeHandler(event:GroupShowAndCloseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function zhiZaoCompleteHandler(event:GroupManageEvent):void
		{
			groupProxy.update_produce_warship(function():void
			{
				comp.upData(groupProxy.groupInfoVo);
			});
		}
		
		protected function zhiZaoHandler(event:GroupManageEvent):void
		{
			groupProxy.produce_warship(event.makeNum,function():void
			{
				comp.upData(groupProxy.groupInfoVo);
			});
		}
		
		protected function genGaiHandler(event:GroupManageEvent):void
		{
			groupProxy.legion_manage(event.verification,event.forbid_getting_warship,event.desc,function():void
			{
				comp.upData(groupProxy.groupInfoVo);
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
		protected function get comp():GroupManageComponent
		{
			return viewComponent as GroupManageComponent;
		}

	}
}