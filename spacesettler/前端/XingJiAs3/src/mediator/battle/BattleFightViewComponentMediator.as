package mediator.battle
{
	import com.zn.multilanguage.MultilanguageManager;
	
	import enum.item.ItemEnum;
	
	import events.battle.fight.FightViewEvent;
	
	import flash.events.Event;
	
	import mediator.BaseMediator;
	import mediator.mainView.MainViewMediator;
	import mediator.plantioid.PlantioidComponentMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.BuildProxy;
	import proxy.battle.BattleProxy;
	import proxy.packageView.PackageViewProxy;
	
	import ui.managers.PopUpManager;
	
	import utils.battle.FightDataUtil;
	
	import view.battle.fightView.BattleFightViewComponent;
	
	import vo.cangKu.BaseItemVO;
	import vo.cangKu.ZhanCheInfoVO;

	public class BattleFightViewComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="BattleFightViewComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";
		
		private var battleProxy:BattleProxy;
		public function BattleFightViewComponentMediator()
		{
			super(NAME, new BattleFightViewComponent());
			battleProxy=getProxy(BattleProxy);
			
			_popUp=false;
			comp.med=this;
			comp.y=500;
			comp.x=390.95;
			
			comp.addEventListener(FightViewEvent.RETURN_EVENT,backHandler);
			comp.addEventListener(FightViewEvent.GAME_EVENT,gameHandler);
			comp.addEventListener(FightViewEvent.GAME_COMPLETE_EVENT,gameCompleteHandler);
			comp.addEventListener(FightViewEvent.GAME_OVER_EVENT,backHandler);
		}
		
		protected function gameCompleteHandler(event:FightViewEvent):void
		{
			sendNotification(BattleTiShiPanelComponentMediator.DESTROY_NOTE);
		}
		
		protected function gameHandler(event:FightViewEvent):void
		{
			var obj:Object={};
			obj.showLable=MultilanguageManager.getString("battleTiShi1");
			sendNotification(BattleTiShiPanelComponentMediator.SHOW_NOTE,obj);
		}
				
		protected function backHandler(event:FightViewEvent):void
		{
			sendNotification(BattleFightMediator.DESTROY_NOTE);
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
		protected function get comp():BattleFightViewComponent
		{
			return viewComponent as BattleFightViewComponent;
		}

	}
}