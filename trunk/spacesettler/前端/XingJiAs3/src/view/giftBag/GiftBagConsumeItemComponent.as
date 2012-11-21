package view.giftBag
{
	import com.zn.utils.ClassUtil;
	
	import events.giftBag.GiftBagEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	
	import vo.giftBag.GiftBagVO;
	
	public class GiftBagConsumeItemComponent extends Component
	{
		public var dateLabel:Label;
		public var timeLabel:Label;
		public var darkCrystalUseLabel:Label;
		public var darkCrystalGetLabel:Label;
		public var getBtn:Button;
		public var maskSp:Sprite;
		
		public var itemType:int;
		public function GiftBagConsumeItemComponent()
		{
			super(ClassUtil.getObject("view.giftItem8"));
			dateLabel=createUI(Label,"lastTime");
			timeLabel=createUI(Label,"time");
			darkCrystalUseLabel=createUI(Label,"darkCrystalUseNum");
			darkCrystalGetLabel=createUI(Label,"darkCrystalGetNum");
			getBtn=createUI(Button,"getBtn");
			maskSp=getSkin("maskSp");
			sortChildIndex();
			
			maskSp.buttonMode=maskSp.mouseEnabled=true;
			maskSp.addEventListener(MouseEvent.CLICK,getInfo_clickHandler);
			getBtn.addEventListener(MouseEvent.CLICK,getBtn_clickHandler);
			
		}
		
		public function set setValue(data:GiftBagVO):void
		{
			dateLabel.text=data.begin_time+"-"+data.end_time;
			timeLabel.text="";
			darkCrystalUseLabel.text=data.consumer_count+"";
			darkCrystalGetLabel.text=data.back+"";
			
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