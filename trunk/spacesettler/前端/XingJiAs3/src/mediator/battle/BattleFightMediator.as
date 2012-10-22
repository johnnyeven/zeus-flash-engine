package mediator.battle
{
    import com.zn.utils.ScreenUtils;
    
    import controller.battle.fight.FightFireCommand;
    import controller.battle.fight.FightLockCommand;
    import controller.battle.fight.FightZhanCheMoveCommand;
    
    import enum.SenceTypeEnum;
    
    import events.battle.fight.FightFireEvent;
    import events.battle.fight.FightLockEvent;
    import events.battle.fight.FightZhanCheMoveEvent;
    
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.geom.Point;
    
    import mediator.BaseMediator;
    
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;
    
    import proxy.battle.BattleProxy;
    
    import view.battle.fight.BattleFightComponent;
    
    import vo.GlobalData;
    import vo.battle.fight.FightMoveVO;

    /**
     *战场
     * @author zn
     *
     */
    public class BattleFightMediator extends BaseMediator implements IMediator
    {
        public static const NAME:String = "BattleFightMediator";

        public static const SHOW_NOTE:String = "show" + NAME + "Note";

        public static const DESTROY_NOTE:String = "destroy" + NAME + "Note";

        private var _battleProxy:BattleProxy;

        public function BattleFightMediator(viewComponent:Object = null)
        {
            super(NAME, viewComponent);
            _popUp = false;

            _battleProxy = getProxy(BattleProxy);

            comp.addEventListener(FightZhanCheMoveEvent.ZHAN_CHE_MOVE_EVENT, zhanCheMoveHandler);
			comp.addEventListener(FightFireEvent.FIGHT_FIRE_EVENT, fireHandler);
			comp.addEventListener(FightLockEvent.LOCK_EVENT, lockHandler);
        }
		
        /**
         *添加要监听的消息
         * @return
         *
         */
        override public function listNotificationInterests():Array
        {
            return [ DESTROY_NOTE ];
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
                    ScreenUtils.removeScreenScroll();
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

            ScreenUtils.normalW = comp.width;
            ScreenUtils.normalH = comp.height;
            ScreenUtils.addScreenScroll(comp, true);
			
			var obj:DisplayObject=comp.myZhanCheComp();
			ScreenUtils.scrollRectToPoint(new Point(obj.x,obj.y));
			
            GlobalData.currentSence = SenceTypeEnum.FIGHT_BATTLE;
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
			sendNotification(FightZhanCheMoveCommand.FIGHT_ZHAN_CHE_MOVE_COMMAND, event.fightMoveVO);
        }
		
		/**
		 *开火 
		 * @param event
		 * 
		 */
		protected function fireHandler(event:FightFireEvent):void
		{
			event.stopImmediatePropagation();
			
			//通知服务器
			_battleProxy.fire(event.fireVO);
			
			//通知开火控制器
			sendNotification(FightFireCommand.FIGHT_FIRE_COMMAND, event.fireVO);
		}
		
		/**
		 *锁定 
		 * @param event
		 * 
		 */		
		protected function lockHandler(event:FightLockEvent):void
		{
			_battleProxy.lock(event.fightLockVO);			
			//通知锁定控制器
			sendNotification(FightLockCommand.FIGHT_LOCK_COMMAND, event.fightLockVO);
		}
    }
}
