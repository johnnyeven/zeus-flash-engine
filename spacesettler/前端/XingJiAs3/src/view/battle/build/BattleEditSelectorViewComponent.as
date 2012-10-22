package view.battle.build
{
    import com.greensock.TimelineLite;
    import com.greensock.TweenLite;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    
    import enum.battle.BattleBuildTypeEnum;
    
    import events.battle.BattleEidtSelectorViewEvent;
    import events.buildingView.AddSelectorViewEvent;
    import events.buildingView.AddViewEvent;
    
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    
    import proxy.plantioid.PlantioidProxy;
    
    import ui.core.Component;
    
    import vo.battle.BattleBuildVO;

    public class BattleEditSelectorViewComponent extends Component
    {
        public var upButton:BattleEditSelectedItemComponent;

        public var downButton:BattleEditSelectedItemComponent;

        public var leftButton:BattleEditSelectedItemComponent;

        public var rightButton:BattleEditSelectedItemComponent;

        private var sp:Sprite;

        private var oldPoint:Point = new Point(-80, -30);

        private var timeLine:TimelineLite;

        public var closeTweenLiteCompleteCallBack:Function;

		public var type:int;
		public var buildVO:BattleBuildVO;
		
        public function BattleEditSelectorViewComponent(type:int)
        {
            super(null);
			
			this.type=type;

            sp = new Sprite();
            addChild(sp);
            sp.addChild(ClassUtil.getObject("Build_ClickEffect"));

            var line:Sprite = ClassUtil.getObject("Build_ClickEffect_Line");
            sp.addChild(line);

            line.getChildByName("top").visible = line.getChildByName("right").visible = line.getChildByName("left").visible = line.getChildByName("down").visible = false;

            switch (type)
            {
                case 4:
                {
					var plantioidProxy:PlantioidProxy=ApplicationFacade.getProxy(PlantioidProxy);
					
                    leftButton = new BattleEditSelectedItemComponent();
					leftButton.buildVO=plantioidProxy.buildConentVODic[BattleBuildTypeEnum.JIA_Xie];
                    leftButton.x = oldPoint.x;
                    leftButton.y = oldPoint.y;
                    leftButton.addEventListener(MouseEvent.CLICK, leftButton_clickHandler);
                    addChild(leftButton);
                    line.getChildByName("left").visible = true;

                    rightButton = new BattleEditSelectedItemComponent();
					rightButton.buildVO=plantioidProxy.buildConentVODic[BattleBuildTypeEnum.JI_GUANG];
                    rightButton.x = oldPoint.x;
                    rightButton.y = oldPoint.y;
                    rightButton.addEventListener(MouseEvent.CLICK, rightButton_clickHandler);
                    addChild(rightButton);
                    line.getChildByName("right").visible = true;

                    upButton = new BattleEditSelectedItemComponent();
					upButton.buildVO=plantioidProxy.buildConentVODic[BattleBuildTypeEnum.DIAN_CI];
                    upButton.x = oldPoint.x;
                    upButton.y = oldPoint.y;
                    upButton.addEventListener(MouseEvent.CLICK, upButton_clickHandler);
                    addChild(upButton);
                    line.getChildByName("top").visible = true;

                    downButton = new BattleEditSelectedItemComponent();
					downButton.buildVO=plantioidProxy.buildConentVODic[BattleBuildTypeEnum.AN_NENG];
                    downButton.x = oldPoint.x;
                    downButton.y = oldPoint.y;
                    downButton.addEventListener(MouseEvent.CLICK, downButton_clickHandler);
                    addChild(downButton);
                    line.getChildByName("down").visible = true;
                    break;
                }
                case 2:
                {
                    upButton = new BattleEditSelectedItemComponent(false);
                    upButton.x = oldPoint.x;
                    upButton.y = oldPoint.y;
                    upButton.info = MultilanguageManager.getString("battleCaiChu");
                    upButton.addEventListener(MouseEvent.CLICK, upButton_clickHandler);
                    addChild(upButton);
                    line.getChildByName("top").visible = true;

                    downButton = new BattleEditSelectedItemComponent(false);
                    downButton.x = oldPoint.x;
                    downButton.y = oldPoint.y;
                    downButton.info = MultilanguageManager.getString("battleXingXi");
                    downButton.addEventListener(MouseEvent.CLICK, downButton_clickHandler);
                    addChild(downButton);
                    line.getChildByName("down").visible = true;
                }
            }

            mouseChildren = mouseEnabled = false;
        }

        public override function dispose():void
        {
            super.dispose();

            if (timeLine)
                timeLine.kill();

        }

        public function start():void
        {
            if (timeLine)
                timeLine.kill();

            mouseChildren = mouseEnabled = false;
            timeLine = new TimelineLite({ onComplete: function():void
            {
                mouseChildren = mouseEnabled = true;
            }});

            if (upButton)
                timeLine.insert(TweenLite.to(upButton, 0.5, { y: -100 }));
            if (downButton)
                timeLine.insert(TweenLite.to(downButton, 0.5, { y: 44 }));
            if (rightButton)
                timeLine.insert(TweenLite.to(rightButton, 0.5, { x: 54 }));
            if (leftButton)
                timeLine.insert(TweenLite.to(leftButton, 0.5, { x: -216 }));
        }

        public function endClose():void
        {
            if (timeLine)
                timeLine.kill();
            mouseChildren = mouseEnabled = false;
            timeLine = new TimelineLite({ onComplete: function():void
            {
                if (closeTweenLiteCompleteCallBack != null)
                    closeTweenLiteCompleteCallBack();
                closeTweenLiteCompleteCallBack = null;
            }});

            if (upButton)
                timeLine.insert(TweenLite.to(upButton, 0.5, { y: -28 }));
            if (downButton)
                timeLine.insert(TweenLite.to(downButton, 0.5, { y: -28 }));
            if (rightButton)
                timeLine.insert(TweenLite.to(rightButton, 0.5, { x: -81 }));
            if (leftButton)
                timeLine.insert(TweenLite.to(leftButton, 0.5, { x: -81 }));
        }

        protected function upButton_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new BattleEidtSelectorViewEvent(BattleEidtSelectorViewEvent.UP_EVENT));
        }

        protected function downButton_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new BattleEidtSelectorViewEvent(BattleEidtSelectorViewEvent.DOWN_EVENT));
        }

        protected function leftButton_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new BattleEidtSelectorViewEvent(BattleEidtSelectorViewEvent.LEFT_EVENT));
        }

        protected function rightButton_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new BattleEidtSelectorViewEvent(BattleEidtSelectorViewEvent.RIGHT_EVENT));
        }
    }
}
