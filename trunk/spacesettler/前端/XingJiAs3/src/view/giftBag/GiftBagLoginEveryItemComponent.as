package view.giftBag
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.ColorUtil;
	import com.zn.utils.DateFormatter;
	
	import enum.ResEnum;
	
	import events.giftBag.GiftBagEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import proxy.packageView.PackageViewProxy;
	import proxy.taskGift.GiftBagProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.core.Component;
	
	import vo.cangKu.BaseItemVO;
	import vo.giftBag.GiftBagVO;
	
	public class GiftBagLoginEveryItemComponent extends Component
	{
		public var dateLabel:Label;
		public var timeLabel:Label;
		public var crystalLabel:Label;
		public var tritiumLabel:Label;
		public var brokenCrystalLabel:Label;
		public var darkCrystalLabel:Label;
		public var getBtn:Button;
		public var maskSp:Sprite;
		
		public var oneMC:MovieClip;
		public var twoMC:MovieClip;
		public var thrMC:MovieClip;
		public var fouMC:MovieClip;
		public var fivMC:MovieClip;
		public var sixMC:MovieClip;
		public var sevMC:MovieClip;
		public var iconImg:LoaderImage;
		public var nameNumLabel:Label;
		
		public var itemType:int;
		
		private var _timer:Timer;
		private var _total:Number;
		private var _packageViewProxy:PackageViewProxy;
		public function GiftBagLoginEveryItemComponent()
		{
			super(ClassUtil.getObject("view.giftItem2"));
			_packageViewProxy=ApplicationFacade.getProxy(PackageViewProxy);
			_timer=new Timer(1000);
			_timer.addEventListener(TimerEvent.TIMER,timerHandler);
			
			dateLabel=createUI(Label,"lastTime");
			timeLabel=createUI(Label,"time");
			crystalLabel=createUI(Label,"crystalNum");
			tritiumLabel=createUI(Label,"tritiumNum");
			brokenCrystalLabel=createUI(Label,"brokenCrystalNum");
			darkCrystalLabel=createUI(Label,"darkCrystalNum");
			getBtn=createUI(Button,"getBtn");
			maskSp=getSkin("maskSp");
			
			oneMC=getSkin("oneDay");
			twoMC=getSkin("twoDay");
			thrMC=getSkin("thrDay");
			fouMC=getSkin("fourDay");
			fivMC=getSkin("fiveDay");
			sixMC=getSkin("sixDay");
			sevMC=getSkin("sevDay");
			iconImg=createUI(LoaderImage,"tankPartImg");
			nameNumLabel=createUI(Label,"nameNum");
			sortChildIndex();
			
			iconImg.isScale=true;
			
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
			crystalLabel.text=data.crystal+"";
			tritiumLabel.text=data.tritium+"";
			brokenCrystalLabel.text=data.broken_crystal+"";
			darkCrystalLabel.text=data.dark_crystal+"";
			
			var itemVO:BaseItemVO=new BaseItemVO;
			itemVO.item_type=data.r_type;
			itemVO.category=data.category;
			itemVO.enhanced=data.enhanced;
			itemVO.type=data.item_type;
			_packageViewProxy.setBaseItemName(itemVO,_packageViewProxy.packageXML);
			
			iconImg.source=ResEnum.senceEquipment + data.r_type + "_" + data.category + ".png";
			nameNumLabel.text=itemVO.name;
			switch(data.days)
			{
				case 1:
				{
					if(data.status=="false")
						oneMC.gotoAndStop(3);
					else
						oneMC.gotoAndStop(1);
					twoMC.gotoAndStop(2);
					thrMC.gotoAndStop(2);
					fouMC.gotoAndStop(2);
					fivMC.gotoAndStop(2);
					sixMC.gotoAndStop(2);
					sevMC.gotoAndStop(2);
					break;
				}
				case 2:
				{
					oneMC.gotoAndStop(1);
					if(data.status=="false")
						twoMC.gotoAndStop(3);
					else
						twoMC.gotoAndStop(1);
					thrMC.gotoAndStop(2);
					fouMC.gotoAndStop(2);
					fivMC.gotoAndStop(2);
					sixMC.gotoAndStop(2);
					sevMC.gotoAndStop(2);
					break;
				}
				case 3:
				{
					oneMC.gotoAndStop(1);
					twoMC.gotoAndStop(1);
					if(data.status=="false")
						thrMC.gotoAndStop(3);
					else
						thrMC.gotoAndStop(1);
					fouMC.gotoAndStop(2);
					fivMC.gotoAndStop(2);
					sixMC.gotoAndStop(2);
					sevMC.gotoAndStop(2);
					break;
				}
				case 4:
				{
					oneMC.gotoAndStop(1);
					twoMC.gotoAndStop(1);
					thrMC.gotoAndStop(1);
					if(data.status=="false")
						fouMC.gotoAndStop(3);
					else
						fouMC.gotoAndStop(1);
					fivMC.gotoAndStop(2);
					sixMC.gotoAndStop(2);
					sevMC.gotoAndStop(2);
					break;
				}
				case 5:
				{
					oneMC.gotoAndStop(1);
					twoMC.gotoAndStop(1);
					thrMC.gotoAndStop(1);
					fouMC.gotoAndStop(1);
					if(data.status=="false")
						fivMC.gotoAndStop(3);
					else
						fivMC.gotoAndStop(1);
					sixMC.gotoAndStop(2);
					sevMC.gotoAndStop(2);
					break;
				}
				case 6:
				{
					oneMC.gotoAndStop(1);
					twoMC.gotoAndStop(1);
					thrMC.gotoAndStop(1);
					fouMC.gotoAndStop(1);
					fivMC.gotoAndStop(1);
					if(data.status=="false")
						sixMC.gotoAndStop(3);
					else
						sixMC.gotoAndStop(1);
					sevMC.gotoAndStop(2);
					break;
				}
				case 7:
				{
					oneMC.gotoAndStop(1);
					twoMC.gotoAndStop(1);
					thrMC.gotoAndStop(1);
					fouMC.gotoAndStop(1);
					fivMC.gotoAndStop(1);
					sixMC.gotoAndStop(1);
					if(data.status=="false")
						sevMC.gotoAndStop(3);
					else
						sevMC.gotoAndStop(1);
					break;
				}
				default:
				{
					oneMC.gotoAndStop(2);
					twoMC.gotoAndStop(2);
					thrMC.gotoAndStop(2);
					fouMC.gotoAndStop(2);
					fivMC.gotoAndStop(2);
					sixMC.gotoAndStop(2);
					sevMC.gotoAndStop(2);
					break;
				}
			}
			
			if(data.status=="false")
				getBtn.enabled=true;
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