package mediator.timeMachine
{
	import events.timeMachine.TimeMachineEvent;
	
	import mediator.BaseMediator;
	import mediator.WindowMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.timeMachine.TimeMachineInforComponent;

	/**
	 *时间机器描述
	 * @author lw
	 *
	 */
	public class TimeMachineInforComponentMediator extends WindowMediator implements IMediator
	{
		public static const NAME:String="TimeMachineInforComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function TimeMachineInforComponentMediator()
		{
			super(NAME, new TimeMachineInforComponent());
			comp.med = this;
			level = 2;
			
			comp.addEventListener(TimeMachineEvent.CLOSE_INFOR_COMPONENT_EVENT,closeHandler);
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
		protected function get comp():TimeMachineInforComponent
		{
			return viewComponent as TimeMachineInforComponent;
		}

	}
}