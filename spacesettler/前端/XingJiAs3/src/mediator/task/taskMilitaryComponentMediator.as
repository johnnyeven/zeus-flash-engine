package mediator.task
{
	import controller.task.TaskCompleteCommand;
	
	import events.task.TaskEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.task.TaskProxy;
	
	import view.task.taskMilitaryComponent;
	
	import vo.task.TaskInfoVO;

	public class taskMilitaryComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="taskMilitaryComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		private var taskProxy:TaskProxy;
		public function taskMilitaryComponentMediator()
		{
			super(NAME, new taskMilitaryComponent());
			taskProxy=getProxy(TaskProxy);
			popUpEffect=CENTER;
			level=1;
			comp.med=this;
			
			comp.addEventListener(TaskEvent.CLOSE_EVENT,sureClickHandler);
		}
		
		protected function sureClickHandler(event:TaskEvent):void
		{
			taskProxy.web_update(event.username,event.passWord,event.nickName,event.email,function():void
			{
				sendNotification(DESTROY_NOTE);
				sendNotification(TaskCompleteCommand.TASKCOMPLETE_COMMAND);
			});
		}
		
		public function upData(taskVo:TaskInfoVO):void
		{
			comp.upData(taskVo);
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
		protected function get comp():taskMilitaryComponent
		{
			return viewComponent as taskMilitaryComponent;
		}

	}
}