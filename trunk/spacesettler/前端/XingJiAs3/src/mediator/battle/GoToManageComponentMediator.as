package mediator.battle
{
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.mainView.MainViewMediator;
	import mediator.plantioid.PlantioidComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.plantioid.PlantioidProxy;
	
	import view.battle.fightView.GoToManageComponent;

	/**
	 *提示是否对星球进行管理
	 * @author lw
	 *
	 */
	public class GoToManageComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="GoToManageComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function GoToManageComponentMediator()
		{
			super(NAME, new GoToManageComponent());
			comp.addEventListener("gotoExit",gotoExitHandler);
			comp.addEventListener("gotoManage",gotoManageHandler);
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
		protected function get comp():GoToManageComponent
		{
			return viewComponent as GoToManageComponent;
		}

		private function gotoExitHandler(event:Event):void
		{
			sendNotification(DESTROY_NOTE);
			//退出战场
			sendNotification(BattleFightMediator.DESTROY_NOTE);
			//默认显示小行星带
			sendNotification(PlantioidComponentMediator.SHOW_NOTE);
		}
		
		private function gotoManageHandler(event:Event):void
		{
			
			var plantioidProxy:PlantioidProxy = getProxy(PlantioidProxy);
			plantioidProxy.getPlantioidInfo(PlantioidProxy.selectedVO.id, function():void
			{  
				sendNotification(DESTROY_NOTE);
				//退出战场
				sendNotification(BattleFightMediator.DESTROY_NOTE);
				//显示可编辑要塞
				sendNotification(BattleEditMediator.SHOW_NOTE);
				sendNotification(MainViewMediator.SHOW_TOP_VIEW_NOTE);
			});
		}
	}
}