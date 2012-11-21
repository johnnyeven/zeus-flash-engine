package mediator.battle
{
	import events.battle.fight.FightPanelEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.plantioid.PlantioidComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import ui.managers.PopUpManager;
	
	import view.battle.fightView.BattleVictoryPanelComponent;
	
	import vo.battle.fight.FightVictoryRewardVO;

	/**
	 * 战斗胜利
	 * @author lw
	 */
	public class BattleVictoryPanelComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="BattleVictoryPanelComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function BattleVictoryPanelComponentMediator()
		{
			super(NAME, new BattleVictoryPanelComponent());
			_popUp = true;
			mode = true;
			popUpEffect=CENTER;
			
			comp.med=this;
			level=2;
			
			comp.addEventListener(FightPanelEvent.CLOSE_EVENT,closeHandler);
			comp.addEventListener("victoryTimerEvent",victoryTimerEventHandler);
		}

		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [DESTROY_NOTE];//SHOW_NOTE, 
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
		protected function get comp():BattleVictoryPanelComponent
		{
			return viewComponent as BattleVictoryPanelComponent;
		}
		public function setVictoryData(data:FightVictoryRewardVO):void
		{
			comp.setVictoryData(data);
		}
		public override function destroy():void
		{
			PopUpManager.removePopUp(uiComp);
		}
		
		private function closeHandler(event:FightPanelEvent):void
		{
			sendNotification(DESTROY_NOTE);
			sendNotification(BattleFightMediator.DESTROY_NOTE);
			//默认显示小行星带
			sendNotification(PlantioidComponentMediator.SHOW_NOTE);
		}
		
		private function victoryTimerEventHandler(event:Event):void
		{
			sendNotification(DESTROY_NOTE);
			sendNotification(GoToManageComponentMediator.SHOW_NOTE);
		}
	}
}