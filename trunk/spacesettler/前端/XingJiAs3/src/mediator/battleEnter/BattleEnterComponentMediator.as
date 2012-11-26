package mediator.battleEnter
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Linear;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.SoundUtil;
    
    import controller.EnterMainSenceViewCommand;
    
    import enum.SoundEnum;
    import enum.factory.FactoryEnum;
    
    import events.battle.BattleEnterEvent;
    
    import flash.events.Event;
    import flash.utils.setTimeout;
    
    import mediator.BaseMediator;
    import mediator.battle.BattleFightMediator;
    import mediator.battle.BottomViewComponentMediator;
    import mediator.factory.FactoryChangeComponentMediator;
    import mediator.factory.FactoryMakeAndServiceComponentMediator;
    import mediator.mainView.MainViewMediator;
    import mediator.prompt.PromptSureMediator;
    import mediator.prompt.PromptWeiXiuMediator;
    import mediator.shangCheng.ShangChengComponentMediator;
    
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;
    
    import proxy.battle.BattleProxy;
    import proxy.factory.FactoryProxy;
    import proxy.plantioid.PlantioidProxy;
    import proxy.userInfo.UserInfoProxy;
    
    import ui.managers.SystemManager;
    
    import view.battle.bottomView.BottomViewComponent;
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
			width=Main.WIDTH;
			height=Main.HEIGHT;

            comp.addEventListener(BattleEnterEvent.BATTLE_ENTER_EVENT, battleEnterHandler);
			comp.addEventListener("selectedZhanCheTips",selectedZhanCheTipsHandler);
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
					SoundUtil.stop(SoundEnum.plane_fly);
					SoundUtil.play(SoundEnum.plane_flying,false);
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
		
		private function weiXiuShow():void
		{
			sendNotification(FactoryChangeComponentMediator.SHOW_NOTE);
		}
		
		private function showZhanChang():void
		{
			sendNotification(BattleFightMediator.SHOW_NOTE,PlantioidProxy.selectedVO.map_type);
		}

        protected function battleEnterHandler(event:BattleEnterEvent):void
        {
            var battleProxy:BattleProxy = getProxy(BattleProxy);
			var factoryProxy:FactoryProxy = getProxy(FactoryProxy);
			var userProxy:UserInfoProxy = getProxy(UserInfoProxy);
			if(event.selectedZhanChe.attack<=0||!event.selectedZhanChe.attack)
			{
				var obj1:Object={};//判断有无武器挂件！
				obj1.infoLable="提示";
				obj1.showLable="战车未装载武器挂件，不能进行攻击！";
				obj1.okCallBack=function():void
				{
					Main.addBG();
					sendNotification(EnterMainSenceViewCommand.ENTER_MAIN_SENCE_VIEW_COMMAND);
					sendNotification(MainViewMediator.SHOW_RENWU_VIEW_NOTE);
					setTimeout(weiXiuShow,1500);
				}
				sendNotification(PromptSureMediator.SHOW_NOTE,obj1);
			}else
			{
				if(event.selectedZhanChe.current_endurance>0)//能量大于0 才能进入战场
				{ 
					battleProxy.enterBattle(event.selectedZhanChe.id, function():void
					{
						sendNotification(DESTROY_NOTE);
						setTimeout(showZhanChang,500);
					});				
				}else
				{
					var obj:Object={};
					obj.infoLable=MultilanguageManager.getString("naijiuweiling");
					obj.showLable="维修需要物资："+String(event.selectedZhanChe.repair_cost_broken_crystal)+"暗物质";
					obj.mediatorLevel = level;
					obj.okCallBack = function():void
					{
						//判断资源是否足够维修
						if(event.selectedZhanChe.repair_cost_broken_crystal >userProxy.userInfoVO.broken_crysta)
						{
							var obj:Object = {infoLable:MultilanguageManager.getString("notEnoughSourceTitle"),showLable:MultilanguageManager.getString("notEnoughSourceInfor"),mediatorLevel:level+2,
								okCallBack:function():void
								{
									var shangChengObj:Object ={mediatorLevel:level+2} 
									sendNotification(ShangChengComponentMediator.SHOW_NOTE,shangChengObj);
								} };    
							sendNotification(PromptSureMediator.SHOW_NOTE,obj);
						}
						else
						{
							factoryProxy.repair(event.selectedZhanChe.id,function():void
							{
								//更新战车数据
								var battleProxy:BattleProxy = getProxy(BattleProxy);
								battleProxy.getAllZhanCheList(function():void
								{
									comp.infoComp.setZhanCheList(battleProxy.allZhanCheList);
									//提示维修完成
									var obj:Object = {infoLable:MultilanguageManager.getString("wei_Xiu_Wan_Cheng_Title"),showLable:MultilanguageManager.getString("wei_Xiu_Wan_Cheng_Title_Infor"),mediatorLevel:level+2};
									sendNotification(PromptSureMediator.SHOW_NOTE,obj);
								});
								
							});
						}					
					};
					sendNotification(PromptWeiXiuMediator.SHOW_NOTE,obj);
				}           
			}			
			
        }
		
		private function selectedZhanCheTipsHandler(event:Event):void
		{
			var obj:Object = {infoLable:MultilanguageManager.getString("enterBattleTitle"),showLable:MultilanguageManager.getString("enterBattleInfor"),mediatorLevel:level};
			sendNotification(PromptSureMediator.SHOW_NOTE,obj);
		}
    }
}
