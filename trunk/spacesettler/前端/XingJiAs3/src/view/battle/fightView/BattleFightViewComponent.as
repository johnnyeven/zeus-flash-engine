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
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.core.Component;
	import ui.layouts.VLayout;
	
	import utils.battle.FightDataUtil;
	
	import vo.cangKu.BaseItemVO;
	import vo.cangKu.ZhanCheInfoVO;
	
    public class BattleFightViewComponent extends Component
    {
		public static const MAXNUM:int=44;
		public static const FIVEXSEX:int=300;
		
		//玩家panel
		public var sp:Sprite;
		public var container:Container;
		public var player:BattleNameItemComponent;
		//护盾和能量显示
		public var overMc:MovieClip;
		public var timeLabel:Label;
		public var enduranceLabel:Label;
		public var shieldLabel:Label;
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
		private var timeNum:Number;
        public function BattleFightViewComponent()
        {
            super(ClassUtil.getObject("battle.BattleFightViewSkin"));
			sp=getSkin("playerContainer");
			
			myCar=FightDataUtil.getMyChariot();
			
			scoreLabel=createUI(Label,"scoreLabel");
			enduranceLabel=createUI(Label,"enduranceLabel");
			nameLabel=createUI(Label,"nameLabel");
			shieldLabel=createUI(Label,"shieldLabel");
			timeLabel=createUI(Label,"timeLabel");
			
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
			timer=new Timer(100);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			backBtn.addEventListener(MouseEvent.CLICK,backClickHandler);
			
			overMc.visible=false;
			timeNum=FIVEXSEX;
			upData();
			attackCd();
			overMc.addEventListener(Event.COMPLETE,playCompleteHandler);
			
			container=new Container(null);
			container.layout=new VLayout(container);
			container.contentWidth=150;
			container.contentHeight=500;
			addItem();
			sp.addChild(container);
        }
		
		private function removeAllItem():void
		{
			while (container.num > 0)
				dispose();
		}
		
		public function addItem():void
		{
			removeAllItem();
			
			var arr:Array=FightDataUtil.getPlayerList();
			var player1:PLAYER1;
			var len:int=arr.length;
			var isVip:Boolean;
			
			for(var i:int=0;i<len;i++)
			{
				player1=arr[i];
				player=new BattleNameItemComponent();
				isVip=player1.players[0].playerType==1?false:true;
				player.setValue(isVip,player1.players[0].nickname);
				player.PH=player1.chariots[0].currentEndurance;
				container.add(player);
			}
			container.layout.update();
		}
		
		protected function playCompleteHandler(event:Event):void
		{
			dispatchEvent(new FightViewEvent(FightViewEvent.GAME_OVER_EVENT));
		}
		
		protected function timerHandler(event:TimerEvent):void
		{
			myCar=FightDataUtil.getMyChariot();	
			attackCd();
		}
		public override function dispose():void
		{
			super.dispose();
			stopTimer();
			
			container.removeAt(0);
		}
		public function stopTimer():void
		{
			if(timer!=null)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER,timerHandler);
				timer=null;				
			}
		}
		
		protected function backClickHandler(event:MouseEvent):void
		{
			dispatchEvent(new FightViewEvent(FightViewEvent.RETURN_EVENT));
		}
		public function attackCd():void
		{		
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
				dispatchEvent(new FightViewEvent(FightViewEvent.GAME_COMPLETE_EVENT));
			}
			timeNum-=0.1;
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
				time1=1-(tank1.attackCoolEndTime)/tank1.attackCoolDown;
				var num_1:int=int((MAXNUM)*time1);
				if(time1==0)	
					num_1=1;
				tankPartCircle1.gotoAndStop(num_1);
				attact1Label.text=myCar.tank1.attack.toString();
			}
			if(tank2)
			{
				var time2:Number=0;
				time2=1-(tank2.attackCoolEndTime)/tank2.attackCoolDown;
				var num_2:int=int((MAXNUM)*time2);
				if(time2==0)	
					num_2=1;
				tankPartCircle2.gotoAndStop(num_2);
				attact2Label.text=myCar.tank2.attack.toString();
			}
				
			if(tank3)
			{
				var time3:Number=0;
				time3=1-(tank3.attackCoolEndTime)/tank3.attackCoolDown;
				var num_3:int=int((MAXNUM)*time3);
				if(time3==0)	
					num_3=1;
				tankPartCircle3.gotoAndStop(num_3);
				attact3Label.text=myCar.tank3.attack.toString();
			}
			num1=myCar.currentShield/myCar.totalShield;
			num2=myCar.currentEndurance/myCar.totalEndurance;
			
			chaiortCircle.upDataSh(num1);
			chaiortCircle.upDataEn(num2);
		}
		
		public function upData():void
		{
			chariotImg.source=ResEnum.senceEquipment+ItemEnum.Chariot+"_"+myCar.category+".png"
			
			shieldLabel.text=myCar.currentShield.toString();
			enduranceLabel.text=myCar.currentEndurance.toString();
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