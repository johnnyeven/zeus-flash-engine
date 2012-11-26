package view.giftBag
{
	import com.zn.utils.ClassUtil;
	
	import enum.giftBag.GiftBagTypeEnum;
	
	import events.giftBag.GiftBagEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import proxy.taskGift.GiftBagProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.VScrollBar;
	import ui.core.Component;
	import ui.layouts.HLayout;
	import ui.layouts.VLayout;
	import ui.utils.DisposeUtil;
	
	public class GiftBagViewComponent extends Component
	{
		public var boxSp:Sprite;
		
		public var closeBtn:Button;
		
		public var vScrollBar:VScrollBar;
		
		public var container:Container;
		private  var isNumOne:Boolean=true;
		private var itemArr:Array=[];
		public function GiftBagViewComponent()
		{
			super(ClassUtil.getObject("view.giftViewSkin"));
			
			boxSp=getSkin("boxSp");
			closeBtn=createUI(Button,"close_btn");
			vScrollBar=createUI(VScrollBar,"vScrollBar");
			sortChildIndex();
			
			container=new Container(null);
			container.contentWidth=321;
			container.contentHeight=450;
			container.layout=new VLayout(container);
			boxSp.addChild(container);
			
			container.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			container.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			
			vScrollBar.viewport = container;
			vScrollBar.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			vScrollBar.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			vScrollBar.alpahaTweenlite(0);
			addChild(vScrollBar);
			
			var giftBagProxy:GiftBagProxy=ApplicationFacade.getProxy(GiftBagProxy);
			updataItem(giftBagProxy.giftBagArr);
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtn_clickHandler);
		}
		
		private function removeAllItem():void
		{
			while (container.num > 0)
				DisposeUtil.dispose(container.removeAt(0));
		}
		
		public function updataItem(arr:Array):void
		{
//			removeAllItem();
			
			if(isNumOne)
			{
				isNumOne=false;
				for(var i:int=0;i<arr.length;i++)
				{
					switch(arr[i].type)
					{
						case GiftBagTypeEnum.GiftBag_LoginEvery:
							var giftBagItem1Comp:GiftBagLoginEveryItemComponent=new GiftBagLoginEveryItemComponent();
							giftBagItem1Comp.setValue=arr[i];
							container.add(giftBagItem1Comp);
							itemArr[i]=giftBagItem1Comp;
							break;
						case GiftBagTypeEnum.GiftBag_LoginFirst:
							var giftBagItem2Comp:GiftBagLoginFirstItemComponent=new GiftBagLoginFirstItemComponent();
							giftBagItem2Comp.setValue=arr[i];
							container.add(giftBagItem2Comp);
							itemArr[i]=giftBagItem2Comp;
							break;
						case GiftBagTypeEnum.GiftBag_Online:
							var giftBagItem3Comp:GiftBagOnlineItemComponent=new GiftBagOnlineItemComponent();
							giftBagItem3Comp.setValue=arr[i];
							container.add(giftBagItem3Comp);
							itemArr[i]=giftBagItem3Comp;
							break;
						case GiftBagTypeEnum.GiftBag_PopRank:
							var giftBagItem4Comp:GiftBagPopRankItemComponent=new GiftBagPopRankItemComponent();
							giftBagItem4Comp.setValue=arr[i];
							container.add(giftBagItem4Comp);
							itemArr[i]=giftBagItem4Comp;
							break;
						case GiftBagTypeEnum.GiftBag_FortRank:
							var giftBagItem5Comp:GiftBagFortRankItemComponent=new GiftBagFortRankItemComponent();
							giftBagItem5Comp.setValue=arr[i];
							container.add(giftBagItem5Comp);
							itemArr[i]=giftBagItem5Comp;
							break;
						case GiftBagTypeEnum.GiftBag_RichRank:
							var giftBagItem6Comp:GiftBagRichRankItemComponent=new GiftBagRichRankItemComponent();
							giftBagItem6Comp.setValue=arr[i];
							container.add(giftBagItem6Comp);
							itemArr[i]=giftBagItem6Comp;
							break;
						case GiftBagTypeEnum.GiftBag_ConsumeBack:
							var giftBagItem7Comp:GiftBagConsumeItemComponent=new GiftBagConsumeItemComponent();
							giftBagItem7Comp.setValue=arr[i];
							container.add(giftBagItem7Comp);
							itemArr[i]=giftBagItem7Comp;
							break;
						case GiftBagTypeEnum.GiftBag_BuyChiort:
							var giftBagItem8Comp:GiftBagBuyChiortItemComponent=new GiftBagBuyChiortItemComponent();
							giftBagItem8Comp.setValue=arr[i];
							container.add(giftBagItem8Comp);
							itemArr[i]=giftBagItem8Comp;
							break;
					}
				}
				
				container.layout.update();
				vScrollBar.update();
			}else
			{
				for(var j:int=0;j<arr.length;j++)
				{
					switch(arr[j].type)
					{
						case GiftBagTypeEnum.GiftBag_LoginEvery:
							var giftBagItem11Comp:GiftBagLoginEveryItemComponent=itemArr[j] as GiftBagLoginEveryItemComponent;
							giftBagItem11Comp.setValue=arr[j];
							break;
						case GiftBagTypeEnum.GiftBag_LoginFirst:
							var giftBagItem22Comp:GiftBagLoginFirstItemComponent=itemArr[j] as GiftBagLoginFirstItemComponent;
							giftBagItem22Comp.setValue=arr[j];
							break;
						case GiftBagTypeEnum.GiftBag_Online:
							var giftBagItem33Comp:GiftBagOnlineItemComponent=itemArr[j] as GiftBagOnlineItemComponent;
							giftBagItem33Comp.setValue=arr[j];
							break;
						case GiftBagTypeEnum.GiftBag_PopRank:
							var giftBagItem44Comp:GiftBagPopRankItemComponent=itemArr[j] as GiftBagPopRankItemComponent;
							giftBagItem44Comp.setValue=arr[j];
							break;
						case GiftBagTypeEnum.GiftBag_FortRank:
							var giftBagItem55Comp:GiftBagFortRankItemComponent=itemArr[j] as GiftBagFortRankItemComponent;
							giftBagItem55Comp.setValue=arr[j];
							break;
						case GiftBagTypeEnum.GiftBag_RichRank:
							var giftBagItem66Comp:GiftBagRichRankItemComponent=itemArr[j] as GiftBagRichRankItemComponent;
							giftBagItem66Comp.setValue=arr[j];
							break;
						case GiftBagTypeEnum.GiftBag_ConsumeBack:
							var giftBagItem77Comp:GiftBagConsumeItemComponent=itemArr[j] as GiftBagConsumeItemComponent;
							giftBagItem77Comp.setValue=arr[j];
							break;
						case GiftBagTypeEnum.GiftBag_BuyChiort:
							var giftBagItem88Comp:GiftBagBuyChiortItemComponent=itemArr[j] as GiftBagBuyChiortItemComponent;
							giftBagItem88Comp.setValue=arr[j];
							break;
					}
				}
			}
			
		}
		
		protected function closeBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new GiftBagEvent(GiftBagEvent.CLOSEVIEW_EVENT,0,false,true));
		}
		
		protected function mouseOutHandler(event:MouseEvent):void
		{
			vScrollBar.alpahaTweenlite(0);
		}
		
		protected function mouseOverHandler(event:MouseEvent):void
		{
			vScrollBar.alpahaTweenlite(1);
		}
	}
}