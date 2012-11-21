package view.battle.build
{
    import com.greensock.TimelineLite;
    import com.greensock.TweenLite;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    import com.zn.utils.ObjectUtil;
    
    import enum.BuildTypeEnum;
    import enum.ResEnum;
    import enum.battle.BattleBuildTypeEnum;
    import enum.science.ScienceEnum;
    
    import events.battle.BattleEditorConditionInforEvent;
    import events.battle.BattleEidtSelectorViewEvent;
    import events.buildingView.AddSelectorViewEvent;
    import events.buildingView.AddViewEvent;
    
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    
    import mx.binding.utils.BindingUtils;
    
    import proxy.BuildProxy;
    import proxy.login.LoginProxy;
    import proxy.plantioid.PlantioidProxy;
    import proxy.scienceResearch.ScienceResearchProxy;
    import proxy.userInfo.UserInfoProxy;
    
    import ui.core.Component;
    
    import vo.battle.BattleBuildVO;
    import vo.scienceResearch.ScienceResearchVO;
    import vo.userInfo.UserInfoVO;

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
		private var userInforProxy:UserInfoProxy;
		private var scienceResearchProxy:ScienceResearchProxy;
		private var buildProxy:BuildProxy;
		private var loginProxy:LoginProxy;
		private var techDicObj:Object = {};
        public function BattleEditSelectorViewComponent(type:int)
        {
            super(null);
			userInforProxy = ApplicationFacade.getProxy(UserInfoProxy);
			scienceResearchProxy = ApplicationFacade.getProxy(ScienceResearchProxy);
			loginProxy = ApplicationFacade.getProxy(LoginProxy);
			buildProxy = ApplicationFacade.getProxy(BuildProxy);
			buildProxy.getBuildInfoResult(loginProxy.serverData);
			scienceResearchProxy.getScienceResearchInfor(function():void
			{
				techDicObj = ObjectUtil.CreateDic(scienceResearchProxy.reaearchList,"science_type");
			});
			this.type=type;

            sp = new Sprite();
            addChild(sp);
            sp.addChild(ClassUtil.getObject("Build_ClickEffect"));

            var line:Sprite = ClassUtil.getObject("Build_ClickEffect_Line");
            sp.addChild(line);

            line.getChildByName("top").visible = line.getChildByName("right").visible = line.getChildByName("left").visible = line.getChildByName("down").visible = false;

			removeCWList();
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
					
					cwList.push(BindingUtils.bindSetter(function():void
					{
						leftButton.visible = false;
						line.getChildByName("left").visible = false;
						rightButton.visible = false;
						line.getChildByName("right").visible = false;
						upButton.visible = false;
						line.getChildByName("top").visible = false;
						downButton.visible = false;
						line.getChildByName("down").visible = false;
						if(userInforProxy.userInfoVO.level == 1)
						{
							leftButton.visible = true;
							line.getChildByName("left").visible = true;
							rightButton.visible = false;
							line.getChildByName("right").visible = false;
							upButton.visible = false;
							line.getChildByName("top").visible = false;
							downButton.visible = false;
							line.getChildByName("down").visible = false;
						}
						else if(userInforProxy.userInfoVO.level == 2)
						{
							leftButton.visible = true;
							line.getChildByName("left").visible = true;
							rightButton.visible = true;
							line.getChildByName("right").visible = true;
							upButton.visible = false;
							line.getChildByName("top").visible = false;
							downButton.visible = false;
							line.getChildByName("down").visible = false;
						}
						else if(userInforProxy.userInfoVO.level == 3)
						{
							leftButton.visible = true;
							line.getChildByName("left").visible = true;
							rightButton.visible = true;
							line.getChildByName("right").visible = true;
							upButton.visible = true;
							line.getChildByName("top").visible = true;
							downButton.visible = false;
							line.getChildByName("down").visible = false;
						}
						else if(userInforProxy.userInfoVO.level == 4)
						{
							leftButton.visible = true;
							line.getChildByName("left").visible = true;
							rightButton.visible = true;
							line.getChildByName("right").visible = true;
							upButton.visible = true;
							line.getChildByName("top").visible = true;
							downButton.visible = true;
							line.getChildByName("down").visible = true;
						}
					},userInforProxy,["userInfoVO","level"]));
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
			if(type == 4)
			{
				var array:Array = [];
				if(rightButton.buildVO.crystal >userInforProxy.userInfoVO.crystal)
				{
					var obj2:Object=new Object();
					obj2.imgSource=ResEnum.getConditionIconURL+"2.png";
					obj2.content=MultilanguageManager.getString("crystal")+int(userInforProxy.userInfoVO.crystal)+"/"+rightButton.buildVO.crystal;
					obj2.btnLabel=MultilanguageManager.getString("buy_click");
					array.push(obj2);
				}
				if(rightButton.buildVO.tritium > userInforProxy.userInfoVO.tritium)
				{
					var obj3:Object=new Object();
					obj3.imgSource=ResEnum.getConditionIconURL+"3.png";
					obj3.content=MultilanguageManager.getString("tritium")+int(userInforProxy.userInfoVO.tritium)+"/"+rightButton.buildVO.tritium;
					obj3.btnLabel=MultilanguageManager.getString("buy_click");
					array.push(obj3);
				}
				if(rightButton.buildVO.broken_crystal > userInforProxy.userInfoVO.broken_crysta)
				{
					var obj1:Object=new Object();
					obj1.imgSource=ResEnum.getConditionIconURL+"1.png";
					obj1.content=MultilanguageManager.getString("broken_crysta")+int(userInforProxy.userInfoVO.broken_crysta)+"/"+rightButton.buildVO.broken_crystal;
					obj1.btnLabel=MultilanguageManager.getString("buy_click");
					array.push(obj1);
				}
				if(techDicObj[ScienceEnum.DIAN_CHI_KE_JI] == null)
				{
					var obj4:Object=new Object();
					obj4.imgSource=ResEnum.getConditionIconURL+"6.png";
					obj4.content=MultilanguageManager.getString("science_build") + buildProxy.getBuild(BuildTypeEnum.KEJI).level+"/"+ 21;
					obj4.btnLabel=MultilanguageManager.getString("up_science");
					array.push(obj4);
				}
				else if((techDicObj[ScienceEnum.DIAN_CHI_KE_JI] as ScienceResearchVO).level==0)
				{
					var obj5:Object=new Object();
					obj5.imgSource=ResEnum.getConditionIconURL+"107.png";
					obj5.content=MultilanguageManager.getString("dian_ci_ke_ji") +0+"/"+1;
					obj5.btnLabel=MultilanguageManager.getString("study_click");
					array.push(obj5);	
				}
				if(array.length>0)
				{
					dispatchEvent(new BattleEditorConditionInforEvent(BattleEditorConditionInforEvent.BATTLE_EDITOR_CONDITION_INFOR_EVENT,array));
				}
				else
				{
					dispatchEvent(new BattleEidtSelectorViewEvent(BattleEidtSelectorViewEvent.UP_EVENT));
				}
				
			}
			else if(type == 2)
			{
				dispatchEvent(new BattleEidtSelectorViewEvent(BattleEidtSelectorViewEvent.UP_EVENT));
			}
            
        }

        protected function downButton_clickHandler(event:MouseEvent):void
        {
			if(type == 4)
			{
				var array:Array = [];
				if(rightButton.buildVO.crystal >userInforProxy.userInfoVO.crystal)
				{
					var obj2:Object=new Object();
					obj2.imgSource=ResEnum.getConditionIconURL+"2.png";
					obj2.content=MultilanguageManager.getString("crystal")+int(userInforProxy.userInfoVO.crystal)+"/"+rightButton.buildVO.crystal;
					obj2.btnLabel=MultilanguageManager.getString("buy_click");
					array.push(obj2);
				}
				if(rightButton.buildVO.tritium > userInforProxy.userInfoVO.tritium)
				{
					var obj3:Object=new Object();
					obj3.imgSource=ResEnum.getConditionIconURL+"3.png";
					obj3.content=MultilanguageManager.getString("tritium")+int(userInforProxy.userInfoVO.tritium)+"/"+rightButton.buildVO.tritium;
					obj3.btnLabel=MultilanguageManager.getString("buy_click");
					array.push(obj3);
				}
				if(rightButton.buildVO.broken_crystal > userInforProxy.userInfoVO.broken_crysta)
				{
					var obj1:Object=new Object();
					obj1.imgSource=ResEnum.getConditionIconURL+"1.png";
					obj1.content=MultilanguageManager.getString("broken_crysta")+int(userInforProxy.userInfoVO.broken_crysta)+"/"+rightButton.buildVO.broken_crystal;
					obj1.btnLabel=MultilanguageManager.getString("buy_click");
					array.push(obj1);
				}
				if(techDicObj[ScienceEnum.AN_NENG_KE_JI] == null)
				{
					var obj4:Object=new Object();
					obj4.imgSource=ResEnum.getConditionIconURL+"6.png";
					obj4.content=MultilanguageManager.getString("science_build") + buildProxy.getBuild(BuildTypeEnum.KEJI).level+"/"+ 31;
					obj4.btnLabel=MultilanguageManager.getString("up_science");
					array.push(obj4);
				}
				else if((techDicObj[ScienceEnum.AN_NENG_KE_JI] as ScienceResearchVO).level==0)
				{
					var obj5:Object=new Object();
					obj5.imgSource=ResEnum.getConditionIconURL+"1010.png";
					obj5.content=MultilanguageManager.getString("an_neng_ke_ji") +0+"/"+1;
					obj5.btnLabel=MultilanguageManager.getString("study_click");
					array.push(obj5);	
				}
				if(array.length>0)
				{
					dispatchEvent(new BattleEditorConditionInforEvent(BattleEditorConditionInforEvent.BATTLE_EDITOR_CONDITION_INFOR_EVENT,array));
				}
				else
				{
					dispatchEvent(new BattleEidtSelectorViewEvent(BattleEidtSelectorViewEvent.DOWN_EVENT));
				}
				
			}
			else if(type == 2)
			{
				dispatchEvent(new BattleEidtSelectorViewEvent(BattleEidtSelectorViewEvent.DOWN_EVENT));
			}
            
        }

        protected function leftButton_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new BattleEidtSelectorViewEvent(BattleEidtSelectorViewEvent.LEFT_EVENT));
        }

        protected function rightButton_clickHandler(event:MouseEvent):void
        {
			var array:Array = [];
			if(rightButton.buildVO.crystal >userInforProxy.userInfoVO.crystal)
			{
				var obj2:Object=new Object();
				obj2.imgSource=ResEnum.getConditionIconURL+"2.png";
				obj2.content=MultilanguageManager.getString("crystal")+int(userInforProxy.userInfoVO.crystal)+"/"+rightButton.buildVO.crystal;
				obj2.btnLabel=MultilanguageManager.getString("buy_click");
				array.push(obj2);
			}
			if(rightButton.buildVO.tritium > userInforProxy.userInfoVO.tritium)
			{
				var obj3:Object=new Object();
				obj3.imgSource=ResEnum.getConditionIconURL+"3.png";
				obj3.content=MultilanguageManager.getString("tritium")+int(userInforProxy.userInfoVO.tritium)+"/"+rightButton.buildVO.tritium;
				obj3.btnLabel=MultilanguageManager.getString("buy_click");
				array.push(obj3);
			}
			if(rightButton.buildVO.broken_crystal > userInforProxy.userInfoVO.broken_crysta)
			{
				var obj1:Object=new Object();
				obj1.imgSource=ResEnum.getConditionIconURL+"1.png";
				obj1.content=MultilanguageManager.getString("broken_crysta")+int(userInforProxy.userInfoVO.broken_crysta)+"/"+rightButton.buildVO.broken_crystal;
				obj1.btnLabel=MultilanguageManager.getString("buy_click");
				array.push(obj1);
			}
			if(techDicObj[ScienceEnum.JI_GUANG_KE_JI] == null)
			{
				var obj4:Object=new Object();
				obj4.imgSource=ResEnum.getConditionIconURL+"6.png";
				obj4.content=MultilanguageManager.getString("science_build") + buildProxy.getBuild(BuildTypeEnum.KEJI).level+"/"+ 11;
				obj4.btnLabel=MultilanguageManager.getString("up_science");
				array.push(obj4);
			}
			else if((techDicObj[ScienceEnum.JI_GUANG_KE_JI] as ScienceResearchVO).level==0)
			{
				var obj5:Object=new Object();
				obj5.imgSource=ResEnum.getConditionIconURL+"104.png";
				obj5.content=MultilanguageManager.getString("ji_guang_ke_ji") +0+"/"+1;
				obj5.btnLabel=MultilanguageManager.getString("study_click");
				array.push(obj5);	
			}
			if(array.length>0)
			{
				dispatchEvent(new BattleEditorConditionInforEvent(BattleEditorConditionInforEvent.BATTLE_EDITOR_CONDITION_INFOR_EVENT,array));
			}
			else
			{
				dispatchEvent(new BattleEidtSelectorViewEvent(BattleEidtSelectorViewEvent.RIGHT_EVENT));
			}
            
        }
    }
}
