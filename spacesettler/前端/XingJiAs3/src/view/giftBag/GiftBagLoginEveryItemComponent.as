package view.giftBag
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.DateFormatter;
	
	import events.giftBag.GiftBagEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.core.Component;
	
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
		
		public function GiftBagLoginEveryItemComponent()
		{
			super(ClassUtil.getObject("view.giftItem2"));
			
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
			
			maskSp.buttonMode=maskSp.mouseEnabled=true;
			maskSp.addEventListener(MouseEvent.CLICK,getInfo_clickHandler);
			getBtn.addEventListener(MouseEvent.CLICK,getBtn_clickHandler);
		}
		
		public function set setValue(data:GiftBagVO):void
		{
			dateLabel.text=DateFormatter.formatterTimeNYR(data.begin_time)+"-"+DateFormatter.formatterTimeNYR(data.end_time);
			timeLabel.text="";
			crystalLabel.text=data.crystal+"";
			tritiumLabel.text=data.tritium+"";
			brokenCrystalLabel.text=data.broken_crystal+"";
			darkCrystalLabel.text=data.dark_crystal+"";
			nameNumLabel.text="";
			switch(data.days)
			{
				case 1:
					oneMC.gotoAndStop(1);
					twoMC.gotoAndStop(2);
					thrMC.gotoAndStop(2);
					fouMC.gotoAndStop(2);
					fivMC.gotoAndStop(2);
					sixMC.gotoAndStop(2);
					sevMC.gotoAndStop(2);
					break;
				case 2:
					oneMC.gotoAndStop(1);
					twoMC.gotoAndStop(1);
					thrMC.gotoAndStop(2);
					fouMC.gotoAndStop(2);
					fivMC.gotoAndStop(2);
					sixMC.gotoAndStop(2);
					sevMC.gotoAndStop(2);
					break;
				case 3:
					oneMC.gotoAndStop(1);
					twoMC.gotoAndStop(1);
					thrMC.gotoAndStop(1);
					fouMC.gotoAndStop(2);
					fivMC.gotoAndStop(2);
					sixMC.gotoAndStop(2);
					sevMC.gotoAndStop(2);
					break;
				case 4:
					oneMC.gotoAndStop(1);
					twoMC.gotoAndStop(1);
					thrMC.gotoAndStop(1);
					fouMC.gotoAndStop(1);
					fivMC.gotoAndStop(2);
					sixMC.gotoAndStop(2);
					sevMC.gotoAndStop(2);
					break;
				case 5:
					oneMC.gotoAndStop(1);
					twoMC.gotoAndStop(1);
					thrMC.gotoAndStop(1);
					fouMC.gotoAndStop(1);
					fivMC.gotoAndStop(1);
					sixMC.gotoAndStop(2);
					sevMC.gotoAndStop(2);
					break;
				case 6:
					oneMC.gotoAndStop(1);
					twoMC.gotoAndStop(1);
					thrMC.gotoAndStop(1);
					fouMC.gotoAndStop(1);
					fivMC.gotoAndStop(1);
					sixMC.gotoAndStop(1);
					sevMC.gotoAndStop(2);
					break;
				case 7:
					oneMC.gotoAndStop(1);
					twoMC.gotoAndStop(1);
					thrMC.gotoAndStop(1);
					fouMC.gotoAndStop(1);
					fivMC.gotoAndStop(1);
					sixMC.gotoAndStop(1);
					sevMC.gotoAndStop(1);
					break;
				default:
					oneMC.gotoAndStop(2);
					twoMC.gotoAndStop(2);
					thrMC.gotoAndStop(2);
					fouMC.gotoAndStop(2);
					fivMC.gotoAndStop(2);
					sixMC.gotoAndStop(2);
					sevMC.gotoAndStop(2);
					break;
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