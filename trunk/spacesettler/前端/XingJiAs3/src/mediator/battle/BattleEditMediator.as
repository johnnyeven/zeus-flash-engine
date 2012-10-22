package mediator.battle
{
    import com.zn.events.ScreenScrollEvent;
    import com.zn.utils.ScreenUtils;
    
    import enum.SenceTypeEnum;
    import enum.battle.BattleBuildTypeEnum;
    
    import events.battle.BattleBuildEvent;
    
    import flash.events.Event;
    import flash.geom.Point;
    import flash.utils.setTimeout;
    
    import mediator.BaseMediator;
    
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;
    
    import view.battle.build.BattleEditBuildItemComponent;
    import view.battle.build.BattleEditComponent;
    import view.battle.build.BattleEditSelectorViewComponent;
    import view.battle.fight.BattleFightComponent;
    
    import vo.GlobalData;

    /**
     *战场
     * @author zn
     *
     */
    public class BattleEditMediator extends BaseMediator implements IMediator
    {
        public static const NAME:String = "BattleEditMediator";

        public static const SHOW_NOTE:String = "show" + NAME + "Note";

        public static const DESTROY_NOTE:String = "destroy" + NAME + "Note";

        public function BattleEditMediator(viewComponent:Object = null)
        {
            super(NAME, viewComponent);
            _popUp = false;

            comp.addEventListener(BattleBuildEvent.BUILD_CLICK_EVENT, build_clickHandler);
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
					sendNotification(BottomViewComponentMediator.DESTROY_NOTE);
					sendNotification(TimeViewComponentMediator.DESTROY_NOTE);
                    break;
                }
            }
        }

        /**
         *获取界面
         * @return
         *
         */
        protected function get comp():BattleEditComponent
        {
            return viewComponent as BattleEditComponent;
        }

        public override function showComplete():void
        {
            super.showComplete();

            ScreenUtils.normalW = comp.width;
            ScreenUtils.normalH = comp.height;
            ScreenUtils.addScreenScroll(comp, true);

            GlobalData.currentSence = SenceTypeEnum.EDIT_BATTLE;
			
			sendNotification(BottomViewComponentMediator.SHOW_NOTE);
			sendNotification(TimeViewComponentMediator.SHOW_NOTE);
        }

        protected function build_clickHandler(event:BattleBuildEvent):void
        {
            var buildComp:BattleEditBuildItemComponent = event.target as BattleEditBuildItemComponent;

            sendNotification(BattleEditSelectorViewComponentMediator.DESTROY_NOTE);

            if (buildComp.buildVO.type != BattleBuildTypeEnum.JI_DI && buildComp.buildVO.type != BattleBuildTypeEnum.CAI_JI)
            {
                setTimeout(function():void
                {
                    sendNotification(BattleEditSelectorViewComponentMediator.SHOW_NOTE, buildComp.buildVO);
                }, 100);
            }
        }

        public function addSelctedComp(viewComp:BattleEditSelectorViewComponent):void
        {
            comp.addChild(viewComp);
        }
    }
}
