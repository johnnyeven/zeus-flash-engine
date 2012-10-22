package mediator.battle
{
    import com.zn.utils.ClassUtil;
    
    import enum.BuildTypeEnum;
    import enum.battle.BattleBuildTypeEnum;
    
    import events.battle.BattleEidtSelectorViewEvent;
    import events.buildingView.AddSelectorViewEvent;
    import events.buildingView.AddViewEvent;
    import events.buildingView.UpLevelEvent;
    
    import flash.events.Event;
    import flash.geom.Point;
    
    import mediator.BaseMediator;
    import mediator.allView.AllViewComponentMediator;
    import mediator.allView.RongYuComponentMediator;
    import mediator.buildingView.YeLianChangUpComponentMediator;
    import mediator.cangKu.CangkuPackageViewComponentMediator;
    import mediator.crystalSmelter.CrystalSmelterFunctionComponentMediator;
    import mediator.scienceResearch.ScienceResearchComponentMediator;
    import mediator.timeMachine.TimeMachineComponentMediator;
    
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;
    
    import proxy.allView.AllViewProxy;
    import proxy.plantioid.PlantioidProxy;
    import proxy.timeMachine.TimeMachineProxy;
    import proxy.userInfo.UserInfoProxy;
    
    import ui.managers.PopUpManager;
    
    import view.battle.build.BattleEditSelectorViewComponent;
    import view.buildingView.SelectorViewComponent;
    
    import vo.battle.BattleBuildVO;

    /**
     *建筑功能选择
     * @author zn
     *
     */
    public class BattleEditSelectorViewComponentMediator extends BaseMediator implements IMediator
    {
        public static const NAME:String = "BattleEditSelectorViewComponentMediator";

        public static const SHOW_NOTE:String = "show" + NAME + "Note";

        public static const DESTROY_NOTE:String = "destroy" + NAME + "Note";

        public var viewComp:BattleEditSelectorViewComponent;

        private var buildVO:BattleBuildVO;

        private var _arr:Array = [];

        public function BattleEditSelectorViewComponentMediator()
        {
            super(NAME, null);
        }

        /**
         *添加要监听的消息
         * @return
         *
         */
        override public function listNotificationInterests():Array
        {
            return [ SHOW_NOTE, DESTROY_NOTE ];
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
                case SHOW_NOTE:
                {
                    buildVO = note.getBody() as BattleBuildVO;
                    show();

                    break;
                }
                case DESTROY_NOTE:
                {
                    //销毁对象
                    destroy();
                    break;
                }
            }
        }

        public override function show():void
        {
            var type:int = 2;
            if (buildVO.type == BattleBuildTypeEnum.EMPTY)
                type = 4;
            if (buildVO.type != BattleBuildTypeEnum.JI_DI && buildVO.type != BattleBuildTypeEnum.CAI_JI)
            {
                viewComp = new BattleEditSelectorViewComponent(type);
                viewComp.buildVO = buildVO;

                _arr.push(viewComp);

                viewComp.x = buildVO.x;
                viewComp.y = buildVO.y;

                viewComp.addEventListener(BattleEidtSelectorViewEvent.UP_EVENT, upHandler);
                viewComp.addEventListener(BattleEidtSelectorViewEvent.DOWN_EVENT, downHandler);
                viewComp.addEventListener(BattleEidtSelectorViewEvent.RIGHT_EVENT, rightHandler);
                viewComp.addEventListener(BattleEidtSelectorViewEvent.LEFT_EVENT, leftHandler);

				var battleEditMed:BattleEditMediator=getMediator(BattleEditMediator);
				battleEditMed.addSelctedComp(viewComp);

                viewComp.start();
            }

        }

        public override function destroy():void
        {
            for (var i:int; i < _arr.length; i++)
            {
                var comp:BattleEditSelectorViewComponent = _arr[i];
                comp.closeTweenLiteCompleteCallBack = function():void
                {
                    comp.dispose();
                    comp = null
                }
                comp.endClose();
            }
            _arr = [];
        }

        protected function upHandler(event:BattleEidtSelectorViewEvent):void
        {
			var comp:BattleEditSelectorViewComponent=event.currentTarget as BattleEditSelectorViewComponent;
			var plantProxy:PlantioidProxy=getProxy(PlantioidProxy);
			if(comp.buildVO.type==BattleBuildTypeEnum.EMPTY)
				plantProxy.buildPaoTa(BattleBuildTypeEnum.DIAN_CI,comp.buildVO.x,comp.buildVO.y);
			else
				plantProxy.destroyPaoTa(comp.buildVO.id);
			
            sendNotification(DESTROY_NOTE);
        }

        protected function downHandler(event:BattleEidtSelectorViewEvent):void
        {
			var comp:BattleEditSelectorViewComponent=event.currentTarget as BattleEditSelectorViewComponent;
			var plantProxy:PlantioidProxy=getProxy(PlantioidProxy);
			if(comp.buildVO.type==BattleBuildTypeEnum.EMPTY)
				plantProxy.buildPaoTa(BattleBuildTypeEnum.AN_NENG,comp.buildVO.x,comp.buildVO.y);
			else
				sendNotification(BattleBuildInfoComponentMediator.SHOW_NOTE,buildVO);
				
            sendNotification(DESTROY_NOTE);
        }

        protected function rightHandler(event:BattleEidtSelectorViewEvent):void
        {
			var comp:BattleEditSelectorViewComponent=event.currentTarget as BattleEditSelectorViewComponent;
			var plantProxy:PlantioidProxy=getProxy(PlantioidProxy);
			if(comp.buildVO.type==BattleBuildTypeEnum.EMPTY)
				plantProxy.buildPaoTa(BattleBuildTypeEnum.JI_GUANG,comp.buildVO.x,comp.buildVO.y);
			
			sendNotification(DESTROY_NOTE);
        }

        private function leftHandler(event:BattleEidtSelectorViewEvent):void
        {
			var comp:BattleEditSelectorViewComponent=event.currentTarget as BattleEditSelectorViewComponent;
			var plantProxy:PlantioidProxy=getProxy(PlantioidProxy);
			if(comp.buildVO.type==BattleBuildTypeEnum.EMPTY)
				plantProxy.buildPaoTa(BattleBuildTypeEnum.JIA_Xie,comp.buildVO.x,comp.buildVO.y);
			sendNotification(DESTROY_NOTE);
        }
    }
}
