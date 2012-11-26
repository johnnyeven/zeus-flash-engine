package view.giftBag
{
	import com.zn.utils.ClassUtil;
	
	import events.giftBag.GiftBagEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import proxy.taskGift.GiftBagProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	
	import vo.giftBag.GiftBagVO;
	
	public class GiftBagOnlineItemComponent extends Component
	{
		public var dateLabel:Label;
		public var timeLabel:Label;
		public var crystalLabel:Label;
		public var tritiumLabel:Label;
		public var brokenCrystalLabel:Label;
		public var darkCrystalLabel:Label;
		public var getBtn:Button;
		public var levelMC1:MovieClip;
		public var levelMC2:MovieClip;
		public var levelMC3:MovieClip;
		public var levelMC4:MovieClip;
		public var levelMC5:MovieClip;
		public var levelMC6:MovieClip;
		public var levelMC7:MovieClip;
		public var levelMC8:MovieClip;
		public var maskSp:Sprite;
		
		public var itemType:int;
		
		private var _timer:Timer;
		private var _total:Number;
		private var _count:int;
		
		public function GiftBagOnlineItemComponent()
		{
			super(ClassUtil.getObject("view.giftItem4"));
			_timer=new Timer(1000);
			_timer.addEventListener(TimerEvent.TIMER,timerHandler);
			
			dateLabel=createUI(Label,"lastTime");
			timeLabel=createUI(Label,"time");
			crystalLabel=createUI(Label,"crystalNum");
			tritiumLabel=createUI(Label,"tritiumNum");
			brokenCrystalLabel=createUI(Label,"brokenCrystalNum");
			darkCrystalLabel=createUI(Label,"darkCrystalNum");
			getBtn=createUI(Button,"getBtn");
			getBtn.enabled=false;
			levelMC1=getSkin("lvMC1");
			levelMC2=getSkin("lvMC2");
			levelMC3=getSkin("lvMC3");
			levelMC4=getSkin("lvMC4");
			levelMC5=getSkin("lvMC5");
			levelMC6=getSkin("lvMC6");
			levelMC7=getSkin("lvMC7");
			levelMC8=getSkin("lvMC8");
			maskSp=getSkin("maskSp");
			
			maskSp.buttonMode=maskSp.mouseEnabled=true;
			maskSp.addEventListener(MouseEvent.CLICK,getInfo_clickHandler);
			getBtn.addEventListener(MouseEvent.CLICK,getBtn_clickHandler);
		}
		
		override public function dispose():void
		{
			maskSp.removeEventListener(MouseEvent.CLICK,getInfo_clickHandler);
			if(_timer)
			{
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER,timerHandler);
				_timer=null;
			}
			super.dispose();
		}
		
		protected function timerHandler(event:TimerEvent):void
		{
			_total--;
			if(_total<=0)
			{
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER,timerHandler);
			}
			
			var s:int=int(_total/60/60);
			var f:int=int(_total/60%60);
			var m:int=int(_total%60);
			timeLabel.text=(s>9?s:"0"+s)+":"+(f>9?f:"0"+f)+":"+(m>9?m:"0"+m);
		}
		
		public function set setValue(data:GiftBagVO):void
		{
			var giftBagProxy:GiftBagProxy=ApplicationFacade.getProxy(GiftBagProxy);
			
			dateLabel.text=giftBagProxy.setTime(data.begin_time)+"-"+giftBagProxy.setTime(data.end_time);
			_total=data.countdown;
			_timer.repeatCount=_total;
			_timer.start();
			_count=(data.now_time-data.last_time)/60;
			
			crystalLabel.text=data.crystal+"";
			tritiumLabel.text=data.tritium+"";
			brokenCrystalLabel.text=data.broken_crystal+"";
			darkCrystalLabel.text=data.dark_crystal+"";
			
			switch(data.level)
			{
				case 1:
					levelMC1.gotoAndStop(2);
					levelMC2.gotoAndStop(1);
					levelMC3.gotoAndStop(1);
					levelMC4.gotoAndStop(1);
					levelMC5.gotoAndStop(1);
					levelMC6.gotoAndStop(1);
					levelMC7.gotoAndStop(1);
					levelMC8.gotoAndStop(1);
					break;
				case 2:
					levelMC1.gotoAndStop(2);
					levelMC2.gotoAndStop(2);
					levelMC3.gotoAndStop(1);
					levelMC4.gotoAndStop(1);
					levelMC5.gotoAndStop(1);
					levelMC6.gotoAndStop(1);
					levelMC7.gotoAndStop(1);
					levelMC8.gotoAndStop(1);
					break;
				case 3:
					levelMC1.gotoAndStop(2);
					levelMC2.gotoAndStop(2);
					levelMC3.gotoAndStop(2);
					levelMC4.gotoAndStop(1);
					levelMC5.gotoAndStop(1);
					levelMC6.gotoAndStop(1);
					levelMC7.gotoAndStop(1);
					levelMC8.gotoAndStop(1);
					break;
				case 4:
					levelMC1.gotoAndStop(2);
					levelMC2.gotoAndStop(2);
					levelMC3.gotoAndStop(2);
					levelMC4.gotoAndStop(2);
					levelMC5.gotoAndStop(1);
					levelMC6.gotoAndStop(1);
					levelMC7.gotoAndStop(1);
					levelMC8.gotoAndStop(1);
					break;
				case 5:
					levelMC1.gotoAndStop(2);
					levelMC2.gotoAndStop(2);
					levelMC3.gotoAndStop(2);
					levelMC4.gotoAndStop(2);
					levelMC5.gotoAndStop(2);
					levelMC6.gotoAndStop(1);
					levelMC7.gotoAndStop(1);
					levelMC8.gotoAndStop(1);
					break;
				case 6:
					levelMC1.gotoAndStop(2);
					levelMC2.gotoAndStop(2);
					levelMC3.gotoAndStop(2);
					levelMC4.gotoAndStop(2);
					levelMC5.gotoAndStop(2);
					levelMC6.gotoAndStop(2);
					levelMC7.gotoAndStop(1);
					levelMC8.gotoAndStop(1);
					break;
				case 7:
					levelMC1.gotoAndStop(2);
					levelMC2.gotoAndStop(2);
					levelMC3.gotoAndStop(2);
					levelMC4.gotoAndStop(2);
					levelMC5.gotoAndStop(2);
					levelMC6.gotoAndStop(2);
					levelMC7.gotoAndStop(2);
					levelMC8.gotoAndStop(1);
					break;
				case 8:
					levelMC1.gotoAndStop(2);
					levelMC2.gotoAndStop(2);
					levelMC3.gotoAndStop(2);
					levelMC4.gotoAndStop(2);
					levelMC5.gotoAndStop(2);
					levelMC6.gotoAndStop(2);
					levelMC7.gotoAndStop(2);
					levelMC8.gotoAndStop(2);
					break;
				default:
					levelMC1.gotoAndStop(1);
					levelMC2.gotoAndStop(1);
					levelMC3.gotoAndStop(1);
					levelMC4.gotoAndStop(1);
					levelMC5.gotoAndStop(1);
					levelMC6.gotoAndStop(1);
					levelMC7.gotoAndStop(1);
					levelMC8.gotoAndStop(1);
					break;
			}
			
			if(data.status=="false")
			{
				if(_count>=data.time)
					getBtn.enabled=true;
				else
					getBtn.enabled=false;
			}
			else
				getBtn.enabled=false;
			
			itemType=data.type;
		}
		
		protected function getBtn_clickHandler(event:MouseEvent):void
		{
			// 领取礼包
			dispatchEvent(new GiftBagEvent(GiftBagEvent.GETGIFT_EVENT,itemType,true,true));
		}
		
		protected function getInfo_clickHandler(event:MouseEvent):void
		{
			// 详细信息
			dispatchEvent(new GiftBagEvent(GiftBagEvent.GIFTITEM_EVENT,itemType,true,true));
		}
	}
}