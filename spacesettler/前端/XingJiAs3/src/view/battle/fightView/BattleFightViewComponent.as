package view.battle.fightView
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.DateFormatter;
	
	import enum.ResEnum;
	import enum.item.ItemEnum;
	
	import events.battle.fight.FightViewEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import proxy.battle.BattleProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.core.Component;
	import ui.layouts.VLayout;
	import ui.managers.SystemManager;
	import ui.utils.DisposeUtil;
	
	import utils.battle.FightDataUtil;
	
	import vo.cangKu.BaseItemVO;
	import vo.cangKu.ZhanCheInfoVO;

	/**
	 * 战场底部界面
	 * @author gx
	 * 
	 */	
    public class BattleFightViewComponent extends Component
    {
		public static const MAXNUM:int=44;
		
		//玩家panel
		public var sp:Sprite;
		public var container:Container;
		public var player:BattleNameItemComponent;
		private var _curPlayer:BattleNameItemComponent;
		private var _player1:PLAYER1;
		//护盾和能量显示
		public var overMc:MovieClip;
		public var timeLabel:Label;
		public var enduranceLabel:Label;
		public var shieldLabel:Label;
		public var countLabel:Label;
		//防御
		public var defense4Label:Label;
		public var defense3Label:Label;
		public var defense2Label:Label;
		public var defense1Label:Label;
		//挂件的攻击力
		public var attact3Label:Label;
		public var attact2Label:Label;
		public var attact1Label:Label;
		//名字和评分
		public var nameLabel:Label;
		public var scoreLabel:Label;
		//挂件loader中间三个
		public var tankPart3Img:LoaderImage;
		public var tankPart2Img:LoaderImage;
		public var tankPart1Img:LoaderImage;
		public var chariotImg:LoaderImage;
		
		//挂件右边显示攻击力的
		public var tankpard_3:LoaderImage;
		public var tankpard_2:LoaderImage;
		public var tankpard_1:LoaderImage;
		
		//挂件的攻击间隔
		public var tankPartCircle3:MovieClip;
		public var tankPartCircle2:MovieClip;
		public var tankPartCircle1:MovieClip;
		
		//战车的能量和护盾显示
		public var chaiortCircle:BattleEnergShieldComponent;

		//返回按钮
		public var backBtn:Button;
		
		private var myCar:CHARIOT;	
		private var num1:Number;//hudun
		private var num2:Number;//nengliang
		
		private var tank1:TANKPART;//第一个挂件
		private var tank2:TANKPART;//第二个挂件
		private var tank3:TANKPART;//第三个挂件
		private var timer:Timer;
		private var shiJiantimer:Timer;
		private var timeNum:Number;
		private var battleProxy:BattleProxy;
		private var count:int;
		
		
		private var countDown:BattleCountDownComponent;
        public function BattleFightViewComponent()
        {
            super(ClassUtil.getObject("battle.BattleFightViewSkin"));
			
			countDown=new BattleCountDownComponent();
			countDown.x=Main.WIDTH*0.5;
			countDown.y=Main.HEIGHT*0.5;
			countDown.alpha=0.5;
			countDown.visible=false;
			SystemManager.instance.addPop(countDown);
			
			sp=getSkin("playerContainer");
			battleProxy=ApplicationFacade.getProxy(BattleProxy);
			myCar=FightDataUtil.getMyChariot();
			
			scoreLabel=createUI(Label,"scoreLabel");
			enduranceLabel=createUI(Label,"enduranceLabel");
			nameLabel=createUI(Label,"nameLabel");
			shieldLabel=createUI(Label,"shieldLabel");
			timeLabel=createUI(Label,"timeLabel");
			countLabel=createUI(Label,"countLabel");
			
			attact3Label=createUI(Label,"attact3Label");
			attact2Label=createUI(Label,"attact2Label");
			attact1Label=createUI(Label,"attact1Label");
			
			defense1Label=createUI(Label,"defense1Label");
			defense2Label=createUI(Label,"defense2Label");
			defense3Label=createUI(Label,"defense3Label");
			defense4Label=createUI(Label,"defense4Label");
			
			chariotImg=createUI(LoaderImage,"chariotImg");
			
			tankPart1Img=createUI(LoaderImage,"tankPart1Img");
			tankPart2Img=createUI(LoaderImage,"tankPart2Img");
			tankPart3Img=createUI(LoaderImage,"tankPart3Img");
			
			tankpard_1=createUI(LoaderImage,"tankpard_1");
			tankpard_2=createUI(LoaderImage,"tankpard_2");
			tankpard_3=createUI(LoaderImage,"tankpard_3");
			
			backBtn=createUI(Button,"backBtn");
			chaiortCircle=createUI(BattleEnergShieldComponent,"chaiortCircle");
			
			tankPartCircle3=getSkin("tankPartCircle3");
			tankPartCircle2=getSkin("tankPartCircle2");
			tankPartCircle1=getSkin("tankPartCircle1");
			overMc=getSkin("overMc");
			
			sortChildIndex();
			
			chariotImg.isScale=true;
			chariotImg.mouseEnabled=chariotImg.buttonMode=true;
			chariotImg.addEventListener(MouseEvent.CLICK,changeSenceHandler);
			
			container=new Container(null);
			container.layout=new VLayout(container);
			container.contentWidth=150;
			container.contentHeight=500;
			upDataItem();
			sp.addChild(container);
			
			timer=new Timer(100);
			shiJiantimer=new Timer(1000);
			timer.start();
			shiJiantimer.start();
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			shiJiantimer.addEventListener(TimerEvent.TIMER,shiJiantimerHandler);
			backBtn.addEventListener(MouseEvent.CLICK,backClickHandler);
			
			countLabel.text="x"+count+"";
			
			overMc.visible=false;
			timeNum=battleProxy.roomVO.roomTime;
			upData();
			attackCd();
			overMc.addEventListener(Event.COMPLETE,playCompleteHandler);
        }
		
		protected function changeSenceHandler(event:MouseEvent):void
		{
			dispatchEvent(new FightViewEvent(FightViewEvent.CHANGESENCE_EVENT));
		}
		
		public function playOverMc():void
		{
			overMc.visible=true;
			overMc.play();
		}
		
		protected function shiJiantimerHandler(event:TimerEvent):void
		{
			timeNum-=1;
			timeLabel.text=DateFormatter.formatterTime(timeNum);
			if(timeNum<=0)
			{
				overMc.visible=true;
				overMc.play();
				stopTimer();
			}
			if(timeNum==20)
			{
				dispatchEvent(new FightViewEvent(FightViewEvent.GAME_EVENT));
			}
			if(timeNum==15)
			{
				dispatchEvent(new FightViewEvent(FightViewEvent.GAME_OVER_EVENT));
			}
			if(timeNum<=10)
			{
				countDown.visible=true;
				countDown.timeNum=timeNum;
			}
			if(timeNum<=0)
			{
				stopTimer();
			}
		}
		
		private function removeAllItem():void
		{
			while (container.num > 0)
				DisposeUtil.dispose(container.removeAt(0));
		}
		
		public function upDataItem():void
		{
			removeAllItem();
			
			var arr:Array=FightDataUtil.getPlayerList();//_playerArr
			var len:int=arr.length;
			var isVip:Boolean;
			
			for(var i:int=0;i<len;i++)
			{
				_player1=arr[i];
				player=new BattleNameItemComponent();
				player.info=_player1;
				_curPlayer=player;
				isVip=_player1.players[0].playerType==1?false:true;
				player.setValue(isVip,_player1.players[0].nickname);
//				player.HP=_player1.chariots[0].currentEndurance/_player1.chariots[0].totalEndurance;
				container.add(player);
			}
			
			container.layout.update();
		}
		
		protected function playCompleteHandler(event:Event):void
		{
			dispatchEvent(new FightViewEvent(FightViewEvent.GAME_COMPLETE_EVENT));
		}
		
		protected function timerHandler(event:TimerEvent):void
		{
//			if(_curPlayer.info.players[0].nickname==_player1.players[0].nickname)
//				_curPlayer.HP=_player1.chariots[0].currentEndurance/_player1.chariots[0].totalEndurance;//更新玩家面板的血量条
			myCar=FightDataUtil.getMyChariot();	
			attackCd();
		}
		public override function dispose():void
		{
			super.dispose();
			stopTimer();
		}
		public function stopTimer():void
		{
			if(timer!=null)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER,timerHandler);
				timer=null;				
			}
			if(shiJiantimer!=null)
			{
				shiJiantimer.stop();
				shiJiantimer.removeEventListener(TimerEvent.TIMER,shiJiantimerHandler);
				shiJiantimer=null;				
			}
			if(SystemManager.instance.contains(countDown))
				SystemManager.instance.removePop(countDown);
		}
		
		protected function backClickHandler(event:MouseEvent):void
		{
			dispatchEvent(new FightViewEvent(FightViewEvent.RETURN_EVENT));
		}
		public function attackCd():void
		{					
			shieldLabel.text=int(myCar.currentShield).toString();
			enduranceLabel.text=int(myCar.currentEndurance).toString();
			
			if(myCar.source1)
			{				
				tankpard_1.source=myCar.source1;
				tankPart1Img.source=myCar.source1;
				tank1=myCar.tank1;
			}
			if(myCar.source2)
			{
				tankpard_2.source=myCar.source2;				
				tankPart2Img.source=myCar.source2;	
				tank2=myCar.tank2;
			}
			if(myCar.source3)
			{
				tankpard_3.source=myCar.source3;				
				tankPart3Img.source=myCar.source3;
				tank3=myCar.tank3;
			}
			if(tank1)
			{
				var time1:Number=0;
				if(tank1.attackCoolEndTime)
				{
					time1=1-(tank1.attackCoolEndTime-DateFormatter.currentTimeM)/tank1.attackCoolDown;
					var num_1:int=int((MAXNUM)*time1);
					if(time1==0)	
						num_1=1;
				}else
				{
					num_1=MAXNUM;
				}
				
				tankPartCircle1.gotoAndStop(num_1);
				attact1Label.text=myCar.tank1.attack.toString();
			}
			if(tank2)
			{
				var time2:Number=0;
				if(tank2.attackCoolEndTime)
				{
					time2=1-(tank2.attackCoolEndTime-DateFormatter.currentTimeM)/tank2.attackCoolDown;
					var num_2:int=int((MAXNUM)*time2);
					if(time2==0)	
						num_2=1;
				}else
				{
					num_2=MAXNUM;
				}
				
				tankPartCircle2.gotoAndStop(num_2);
				attact2Label.text=myCar.tank2.attack.toString();
			}
				
			if(tank3)
			{
				var time3:Number=0;
				if(tank3.attackCoolEndTime)
				{
					time3=1-(tank3.attackCoolEndTime-DateFormatter.currentTimeM)/tank3.attackCoolDown;
					var num_3:int=int((MAXNUM)*time3);
					if(time3==0)	
						num_3=1;
				}else
				{
					num_3=MAXNUM;
				}
				
				tankPartCircle3.gotoAndStop(num_3);
				attact3Label.text=myCar.tank3.attack.toString();
			}
			num1=myCar.currentShield/myCar.totalShield;
			num2=myCar.currentEndurance/myCar.totalEndurance;
			
			chaiortCircle.upDataSh(num1);
			chaiortCircle.upDataEn(num2);
			
		}
		
		public function CDStop():void
		{
			tankPartCircle1.visible=false;
			tankPartCircle2.visible=false;
			tankPartCircle3.visible=false;
		}
		
		public function addCount(num:int):void
		{
			count += num;
			countLabel.text="x"+count+"";
		}
		
		public function upData():void
		{
			chariotImg.source=ResEnum.senceEquipment+ItemEnum.Chariot+"_"+myCar.category+".png"		
			
			nameLabel.text=myCar.name;
			scoreLabel.text=myCar.value.toString();
			var str1:String=(myCar.num1*100).toFixed(1);
			var str2:String=(myCar.num2*100).toFixed(1);
			var str3:String=(myCar.num3*100).toFixed(1);
			var str4:String=(myCar.num4*100).toFixed(1);
						
			defense1Label.text=str1+"%";
			defense2Label.text=str2+"%";
			defense3Label.text=str3+"%";
			defense4Label.text=str4+"%";			
			
			switch(myCar.length)
			{
				
				case 0:
				{
					tankpard_1.visible=false;
					tankpard_2.visible=false;
					tankpard_3.visible=false;
					attact3Label.visible=false;
					attact2Label.visible=false;
					attact1Label.visible=false;
					tankPartCircle3.visible=false;
					tankPartCircle2.visible=false;
					tankPartCircle1.visible=false;
					break;
				}
				case 1:
				{
					tankpard_2.visible=false;
					tankpard_3.visible=false;
					attact3Label.visible=false;
					attact2Label.visible=false;
					tankPartCircle3.visible=false;
					tankPartCircle2.visible=false;
					break;
				}
				case 2:
				{
					tankpard_3.visible=false;
					attact3Label.visible=false;
					tankPartCircle3.visible=false;
					break;
				}
			}		
		}
		
		//*******************fengexian
	}
}