package mediator.battleEnter
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Linear;
    
    import events.battle.BattleEnterEvent;
    
    import flash.events.Event;
    
    import mediator.BaseMediator;
    
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;
    
    import proxy.battle.BattleProxy;
    
    import ui.managers.SystemManager;
    
    import view.battleEnter.BattleEnterComponent;

    /**
     *飞船入口
     * @author zn
     *
     */
    public class BattleEnterComponentMediator extends BaseMediator implements IMediator
    {
        public static const NAME:String = "BattleEnterComponentMediator";

        public static const SHOW_NOTE:String = "show" + NAME + "Note";

        public static const DESTROY_NOTE:String = "destroy" + NAME + "Note";

        public function BattleEnterComponentMediator()
        {
            super(NAME, new BattleEnterComponent());
            comp.med = this;
            level = 1;
            popUpEffect = UP;
			
			comp.addEventListener(BattleEnterEvent.BATTLE_ENTER_EVENT,battleEnterHandler);
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
                    break;
                }
            }
        }

        /**
         *获取界面
         * @return
         *
         */
        protected function get comp():BattleEnterComponent
        {
            return viewComponent as BattleEnterComponent;
        }


        public override function destroy():void
        {
            var h:Number = -comp.height;
            TweenLite.to(uiComp, 0.4, { y: h, ease: Linear.easeNone, onComplete: removeTweenLiteComplete });
            removeCWList();

            facade.removeMediator(getMediatorName());
        }
		
		protected function battleEnterHandler(event:BattleEnterEvent):void
		{
			var battleProxy:BattleProxy=getProxy(BattleProxy);
			battleProxy.enterBattle(event.selectedZhanChe.id,function():void
			{
				sendNotification(DESTROY_NOTE);
			});
		}
    }
}
