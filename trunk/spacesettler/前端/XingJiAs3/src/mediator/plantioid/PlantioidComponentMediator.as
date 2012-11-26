package mediator.plantioid
{
	import com.zn.multilanguage.MultilanguageManager;
	
	import controller.EnterMainSenceViewCommand;
	import controller.mainSence.ShowCommand;
	
	import enum.SenceTypeEnum;
	
	import events.plantioid.PlantioidEvent;
	
	import mediator.BaseMediator;
	import mediator.allView.XingXingComponentMediator;
	import mediator.battle.BattleEditMediator;
	import mediator.battleEnter.BattleEnterComponentMediator;
	import mediator.mainView.MainViewMediator;
	import mediator.prompt.PromptMediator;
	import mediator.prompt.PromptSureMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import proxy.battle.BattleProxy;
	import proxy.plantioid.PlantioidProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import view.plantioid.PlantioidComponent;

	/**
	 *小星星带
	 * @author zn
	 *
	 */
	public class PlantioidComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="PlantioidComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public static const SWITCH_PLANT_SENCE_NOTE:String="SWITCH_PLANT_SENCE_NOTE" + NAME;
		
		private var battleProxy:BattleProxy;
		private var id:String;
		public function PlantioidComponentMediator()
		{
			super(NAME, new PlantioidComponent());
			_popUp=false;
			battleProxy=getProxy(BattleProxy);
			comp.addEventListener(PlantioidEvent.ATTACK_EVENT, attackHandler);
			comp.addEventListener(PlantioidEvent.FORCE_ATTACK_EVENT, forceAttackHandler);
			comp.addEventListener(PlantioidEvent.MANAGER_EVENT, managerHandler);
			comp.addEventListener(PlantioidEvent.JUMP_EVENT, jumpHandler);
			comp.addEventListener(PlantioidEvent.MY_PLANT_EVENT, myPlantHandler);
		}

		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [DESTROY_NOTE, SWITCH_PLANT_SENCE_NOTE];
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
				case SWITCH_PLANT_SENCE_NOTE:
				{
					comp.switchPlantSence();
					break;
				}
			}
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		public function get comp():PlantioidComponent
		{
			return viewComponent as PlantioidComponent;
		}

		public override function show():void
		{
			Main.removeBG();
			super.show();
			sendNotification(MainViewMediator.HIDE_TOP_VIEW_NOTE);
			sendNotification(MainViewMediator.HIDE_RENWU_VIEW_NOTE);
		}

		public override function destroy():void
		{
			comp.removeEventListener(PlantioidEvent.ATTACK_EVENT, attackHandler);
			comp.removeEventListener(PlantioidEvent.FORCE_ATTACK_EVENT, forceAttackHandler);
			comp.removeEventListener(PlantioidEvent.MANAGER_EVENT, managerHandler);
			comp.removeEventListener(PlantioidEvent.JUMP_EVENT, jumpHandler);
			comp.removeEventListener(PlantioidEvent.MY_PLANT_EVENT, myPlantHandler);
			super.destroy();
//			sendNotification(MainViewMediator.SHOW_TOP_VIEW_NOTE);
		}


		protected function attackHandler(event:PlantioidEvent):void
		{
			PlantioidComponent.MOUSE_ENABLED=false;
			id=event.plantioidID;			
			sureZhanChe();			
		}
		private function sureZhanChe():void
		{
			var plantioidProxy:PlantioidProxy=getProxy(PlantioidProxy);
			plantioidProxy.setSelectedPlantioid(id);
			sendNotification(BattleEnterComponentMediator.SHOW_NOTE);
		}

		protected function forceAttackHandler(event:PlantioidEvent):void
		{
			PlantioidComponent.MOUSE_ENABLED=false;
			id=event.plantioidID;
			var plantioidProxy:PlantioidProxy=getProxy(PlantioidProxy);
			var obj:Object={};
			obj.okCallFun=function():void
			{
				plantioidProxy.break_into_fort(event.plantioidID,function():void
				{
					sureZhanChe();
				});
			};
			sendNotification(PlantioidTiShiComponentMediator.SHOW_NOTE,obj);			
		}

		protected function managerHandler(event:PlantioidEvent):void
		{
			var plantioidProxy:PlantioidProxy=getProxy(PlantioidProxy);
			plantioidProxy.setSelectedPlantioid(event.plantioidID);
			plantioidProxy.getPlantioidInfo(PlantioidProxy.selectedVO.id, function():void
			{
				var obj:Object={};
				obj.type=SenceTypeEnum.EDIT_BATTLE;
				obj.id=PlantioidProxy.selectedVO.map_type;
				sendNotification(ShowCommand.SHOW_INTERFACE,obj);
//				sendNotification(BattleEditMediator.SHOW_NOTE,PlantioidProxy.selectedVO.map_type);
				sendNotification(MainViewMediator.SHOW_TOP_VIEW_NOTE);
//				sendNotification(DESTROY_NOTE);
			});
		}

		protected function myPlantHandler(event:PlantioidEvent):void
		{
			var playerID:String=UserInfoProxy(getProxy(UserInfoProxy)).userInfoVO.player_id;
			sendNotification(XingXingComponentMediator.SHOW_NOTE,playerID);
		}

		protected function jumpHandler(event:PlantioidEvent):void
		{
			if(!PlantioidComponent.MOUSE_ENABLED)
				return ;
			
			var plantProxy:PlantioidProxy=getProxy(PlantioidProxy);
			if (event.jumpPoint.x > plantProxy.maxX)
			{
				event.jumpPoint.x=plantProxy.maxX;
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE, MultilanguageManager.getString("plantJumpMaxTips"));
			}
			if (event.jumpPoint.y > plantProxy.maxY)
			{
				event.jumpPoint.y=plantProxy.maxY;
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE, MultilanguageManager.getString("plantJumpMaxTips"));
			}

			if (event.jumpPoint.x != plantProxy.currentX ||
				event.jumpPoint.y != plantProxy.currentY)
			{
				PlantioidComponent.MOUSE_ENABLED=false;

				plantProxy.getPlantioidListByXY(event.jumpPoint.x, event.jumpPoint.y, function():void
				{
					sendNotification(SWITCH_PLANT_SENCE_NOTE);
				});
			}
		}
	}
}
