package mediator.battle
{
	import enum.battle.BattleVoteTypeEnum;
	
	import events.battle.BattleBuyEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.plantioid.PlantioidComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.battle.BattleProxy;
	
	import view.battle.fightView.BattleBuyComponent;

	/**
	 *购买要塞
	 * @author lw
	 *
	 */
	public class BattleBuyComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="BattleBuyComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		private var battleProxy:BattleProxy;
		public function BattleBuyComponentMediator()
		{
			super(NAME, new BattleBuyComponent());
			battleProxy = getProxy(BattleProxy);
			comp.addEventListener("giveUpBuy",giveUpBuyHandler);
			comp.addEventListener(BattleBuyEvent.BATTLE_BUY_EVENT,battleBuyHandler);
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
		protected function get comp():BattleBuyComponent
		{
			return viewComponent as BattleBuyComponent;
		}

		private function giveUpBuyHandler(event:Event):void
		{
			//退出战场
			battleProxy.buy(BattleVoteTypeEnum.VOTE_TYPE_GIVEUP,0);
			sendNotification(DESTROY_NOTE);
			sendNotification(BattleFightMediator.DESTROY_NOTE);
			//默认显示小行星带
			sendNotification(PlantioidComponentMediator.SHOW_NOTE);
		}
		
		private function battleBuyHandler(event:BattleBuyEvent):void
		{
			//购买要塞
			if(event.cost == 0)
			{
				battleProxy.buy(BattleVoteTypeEnum.VOTE_TYPE_NEED,event.cost);
			}
			else
			{
				battleProxy.buy(BattleVoteTypeEnum.VOTE_TYPE_BUY,event.cost);
			}
			sendNotification(DESTROY_NOTE);
		}
	}
}