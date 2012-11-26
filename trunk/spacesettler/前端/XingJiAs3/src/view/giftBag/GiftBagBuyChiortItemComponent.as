package view.giftBag
{
	import com.zn.utils.ClassUtil;
	
	import enum.ResEnum;
	
	import events.giftBag.GiftBagEvent;
	
	import flash.display.DisplayObjectContainer;
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
	
	public class GiftBagBuyChiortItemComponent extends Component
	{
		public var dateLabel:Label;
		public var timeLabel:Label;
		public var chaiortNameLabel:Label;
		public var priceLabel:Label;
		public var darkCrystalGetLabel:Label;
		public var getBtn:Button;
		public var maskSp:Sprite;
		public var iconImg:LoaderImage;
		
		public var itemType:int;
		
		private var _timer:Timer;
		private var _total:Number;
		
		private var _packageViewProxy:PackageViewProxy;
		public function GiftBagBuyChiortItemComponent()
		{
			super(ClassUtil.getObject("view.giftItem9"));
			_timer=new Timer(1000);
			_timer.addEventListener(TimerEvent.TIMER,timerHandler);
			
			_packageViewProxy=ApplicationFacade.getProxy(PackageViewProxy);
			
			dateLabel=createUI(Label,"lastTime");
			timeLabel=createUI(Label,"time");
			chaiortNameLabel=createUI(Label,"chaiortName");
			priceLabel=createUI(Label,"numPrice");
			darkCrystalGetLabel=createUI(Label,"darkCrystalGetNum");
			getBtn=createUI(Button,"buyBtn");
			maskSp=getSkin("maskSp");
			iconImg=createUI(LoaderImage,"tankPartImg");
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
			darkCrystalGetLabel.text=data.dark_crystal+"";
			priceLabel.text=data.dark_crystal+"";
			
			var itemVO:BaseItemVO=new BaseItemVO;
			itemVO.item_type=data.r_type;
			itemVO.category=data.category;
			itemVO.enhanced=data.enhanced;
			itemVO.type=data.item_type;
			_packageViewProxy.setBaseItemName(itemVO,_packageViewProxy.packageXML);
			
			iconImg.source=ResEnum.senceEquipment + data.r_type + "_" + data.category + ".png";
			chaiortNameLabel.text=itemVO.name;
			
			
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
//			dispatchEvent(new GiftBagEvent(GiftBagEvent.GIFTITEM_EVENT,itemType,true,true));
		}
	}
}