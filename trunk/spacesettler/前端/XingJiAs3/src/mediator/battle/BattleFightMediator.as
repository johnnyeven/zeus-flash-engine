package mediator.battle
{
	import com.zn.utils.ScreenUtils;
	
	import controller.battle.fight.FightExplodeCommand;
	import controller.battle.fight.FightFireCommand;
	import controller.battle.fight.FightItemCommand;
	import controller.battle.fight.FightLockCommand;
	import controller.battle.fight.FightMoveCommand;
	
	import enum.SenceTypeEnum;
	
	import events.battle.fight.FightEvent;
	import events.battle.fight.FightFeiJiZiBaoEvent;
	import events.battle.fight.FightFireEvent;
	import events.battle.fight.FightLockEvent;
	import events.battle.fight.FightZhanCheMoveEvent;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Point;
	
	import mediator.BaseMediator;
	import mediator.mainView.MainViewMediator;
	import mediator.plantioid.PlantioidComponentMediator;
	
	import net.gameServer.GamerServerSocket;
	import net.roomServer.RoomSocket;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import proxy.battle.BattleProxy;
	
	import view.battle.fight.BattleFightComponent;
	import view.battle.fight.FightFeiJiComponent;
	import view.battle.fight.FightItemEvent;
	
	import vo.GlobalData;

	/**
	 *战场
	 * @author zn
	 *
	 */
	public class BattleFightMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="BattleFightMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		private var _battleProxy:BattleProxy;

		public function BattleFightMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			_popUp=false;

			_battleProxy=getProxy(BattleProxy);

			comp.addEventListener(FightZhanCheMoveEvent.ZHAN_CHE_MOVE_EVENT, zhanCheMoveHandler);
			comp.addEventListener(FightFireEvent.FIGHT_FIRE_EVENT, fireHandler);
			comp.addEventListener(FightLockEvent.LOCK_EVENT, lockHandler);
			comp.addEventListener(FightItemEvent.FIGHT_ITEM_EVENT, fightItemHandler);
			comp.addEventListener(FightFeiJiZiBaoEvent.FIGHT_FEI_JI_ZI_BAO_EVENT, feiJiZiBaoHandler);
			comp.addEventListener(FightEvent.FAIL_EVENT, failHandler);
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
		public function get comp():BattleFightComponent
		{
			return viewComponent as BattleFightComponent;
		}

		public override function showComplete():void
		{
			super.showComplete();

			ScreenUtils.normalW=comp.width;
			ScreenUtils.normalH=comp.height;
			ScreenUtils.addScreenScroll(comp, true);

			var obj:DisplayObject=comp.myZhanCheComp();
			ScreenUtils.scrollRectToPoint(new Point(obj.x, obj.y));

			GlobalData.currentSence=SenceTypeEnum.FIGHT_BATTLE;
			sendNotification(BattleFightViewComponentMediator.SHOW_NOTE);
			sendNotification(MainViewMediator.HIDE_RIGHT_VIEW_NOTE);
			sendNotification(MainViewMediator.HIDE_TOP_VIEW_NOTE);
		}
		
		public override function destroy():void
		{
			super.destroy();
			
			_battleProxy.backReturn();
			sendNotification(BattleTiShiPanelComponentMediator.DESTROY_NOTE);
			sendNotification(BattleFightViewComponentMediator.DESTROY_NOTE);
			sendNotification(BattleFightMediator.DESTROY_NOTE);
			sendNotification(PlantioidComponentMediator.SHOW_NOTE);
			sendNotification(MainViewMediator.SHOW_RIGHT_VIEW_NOTE);
			
			if(GamerServerSocket.instance.connected)
				GamerServerSocket.instance.close();
			if(RoomSocket.instance.connected)
				RoomSocket.instance.close();
			ScreenUtils.removeScreenScroll();
			
			FightFeiJiComponent.feiJiList=[];
		}

		
		/**
		 *移动
		 * @param event
		 *
		 */
		protected function zhanCheMoveHandler(event:FightZhanCheMoveEvent):void
		{
			event.stopImmediatePropagation();

			//通知服务器
			_battleProxy.zhanCheMove(event.fightMoveVO);

			// 通知战车移动控制器
			sendNotification(FightMoveCommand.FIGHT_MOVE_COMMAND, event.fightMoveVO);
		}

		/**
		 *开火
		 * @param event
		 *
		 */
		protected function fireHandler(event:FightFireEvent):void
		{
			event.stopImmediatePropagation();

//			//通知服务器
			_battleProxy.fire(event.fireVO);
		}

		/**
		 *锁定
		 * @param event
		 *
		 */
		public function lockHandler(event:FightLockEvent):void
		{
			_battleProxy.lock(event.fightLockVO);
			
			//通知锁定控制器
			sendNotification(FightLockCommand.FIGHT_LOCK_COMMAND, event.fightLockVO);
		}

		/**
		 *捡到物品
		 * @param event
		 *
		 */
		protected function fightItemHandler(event:FightItemEvent):void
		{
			_battleProxy.fightItem(event.itemVO);

		}
		
		/**
		 *飞机自爆 
		 * @param event
		 * 
		 */		
		protected function feiJiZiBaoHandler(event:FightFeiJiZiBaoEvent):void
		{
//			BattleProxy(getProxy(BattleProxy)).attacked(event.itemVO);
//			//通知爆炸控制器
//			sendNotification(FightExplodeCommand.FIGHT_EXPLODE_COMMAND, event.itemVO);
		}
		
		/**
		 *失败 
		 * @param event
		 * 
		 */
		protected function failHandler(event:Event):void
		{
			sendNotification(DESTROY_NOTE);
		}
	}
}
