package mediator.timeMachine
{
	import events.timeMachine.TimeMachineEvent;
	
	import mediator.BaseMediator;
	import mediator.WindowMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.BuildProxy;
	import proxy.timeMachine.TimeMachineProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import view.timeMachine.TimeMachineComponent;

	/**
	 *时间机器
	 * @author lw
	 *
	 */
	public class TimeMachineComponentMediator extends WindowMediator implements IMediator
	{
		public static const NAME:String="TimeMachineComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function TimeMachineComponentMediator()
		{
			super(NAME, new TimeMachineComponent());
			
			comp.addEventListener(TimeMachineEvent.ALL_SPEED_EVENT,allSpeedHandler);
			comp.addEventListener(TimeMachineEvent.CLOSE_EVENT,closeHandler);
			comp.addEventListener(TimeMachineEvent.SHOW_INFOR_COMPONENT_EVENT,showInforComponetHandler);
			comp.addEventListener(TimeMachineEvent.SPEED_EVENT,speedHandler);
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
		protected function get comp():TimeMachineComponent
		{
			return viewComponent as TimeMachineComponent;
		}

		private function allSpeedHandler(event:TimeMachineEvent):void
		{
			var timeMachineProxy:TimeMachineProxy = getProxy(TimeMachineProxy);
			var userInforProxy:UserInfoProxy = getProxy(UserInfoProxy);
			timeMachineProxy.allSpeed(userInforProxy.userInfoVO.id);
		}
		
		private function showInforComponetHandler(event:TimeMachineEvent):void
		{
			sendNotification(TimeMachineInforComponentMediator.SHOW_NOTE);
		}
		
		private function speedHandler(event:TimeMachineEvent):void
		{
			var builderProxy:BuildProxy = getProxy(BuildProxy);
			builderProxy.speedUpBuild(event.idType);
		}
	}
}