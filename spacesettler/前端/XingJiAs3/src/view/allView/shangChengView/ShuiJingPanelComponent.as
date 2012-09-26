package view.allView.shangChengView
{
	import com.zn.utils.ClassUtil;
	
	import events.allView.ShopEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.core.Component;
	
	public class ShuiJingPanelComponent extends Component
	{
		public var shuiJingComp_1:ShuiJingComponent;
		public var shuiJingComp_4:ShuiJingComponent;
		public var shuiJingComp_9:ShuiJingComponent;
		public var shuiJingComp_19:ShuiJingComponent;
		public var shuiJingComp_39:ShuiJingComponent;
		public var shuiJingComp_79:ShuiJingComponent;
		public var shuiJingComp_99:ShuiJingComponent;
		
		
		public function ShuiJingPanelComponent()
		{
			super(ClassUtil.getObject("view.allView.ShuiJingPanelSkin"));
			shuiJingComp_1=createUI(ShuiJingComponent,"mc_1");
			shuiJingComp_4=createUI(ShuiJingComponent,"mc_2");
			shuiJingComp_9=createUI(ShuiJingComponent,"mc_3");
			shuiJingComp_19=createUI(ShuiJingComponent,"mc_4");
			shuiJingComp_39=createUI(ShuiJingComponent,"mc_5");
			shuiJingComp_79=createUI(ShuiJingComponent,"mc_6");
			shuiJingComp_99=createUI(ShuiJingComponent,"mc_7");
			
			shuiJingComp_1.money="1";
			shuiJingComp_4.money="4";
			shuiJingComp_9.money="9";
			shuiJingComp_19.money="19";
			shuiJingComp_39.money="39";
			shuiJingComp_79.money="79";
			shuiJingComp_99.money="99";				
			
			addMouseClickEvent(shuiJingComp_1.exchangeBtn);
			addMouseClickEvent(shuiJingComp_4.exchangeBtn);
			addMouseClickEvent(shuiJingComp_9.exchangeBtn);
			addMouseClickEvent(shuiJingComp_19.exchangeBtn);
			addMouseClickEvent(shuiJingComp_39.exchangeBtn);
			addMouseClickEvent(shuiJingComp_79.exchangeBtn);
			addMouseClickEvent(shuiJingComp_99.exchangeBtn);
		}
		
		private function addMouseClickEvent(mc:Button):void
		{
			mc.addEventListener(MouseEvent.CLICK,doClickHandler);
		}
		
		protected function doClickHandler(event:MouseEvent):void
		{
			var button:Button=event.currentTarget as Button;
			switch(button)
			{
				case shuiJingComp_1.exchangeBtn:
				{
					dispatchEvent(new ShopEvent(ShopEvent.BUY_DARK_CRYSTAL,true,false,1,"DOLLAR_1_99"));
					break;
				}
				case shuiJingComp_4.exchangeBtn:
				{
					dispatchEvent(new ShopEvent(ShopEvent.BUY_DARK_CRYSTAL,true,false,4,"DOLLAR_4_99"));
					break;
				}
				case shuiJingComp_9.exchangeBtn:
				{
					dispatchEvent(new ShopEvent(ShopEvent.BUY_DARK_CRYSTAL,true,false,9,"DOLLAR_9_99"));
					break;
				}
				case shuiJingComp_19.exchangeBtn:
				{
					dispatchEvent(new ShopEvent(ShopEvent.BUY_DARK_CRYSTAL,true,false,19,"DOLLAR_19_99"));
					break;
				}
				case shuiJingComp_39.exchangeBtn:
				{
					dispatchEvent(new ShopEvent(ShopEvent.BUY_DARK_CRYSTAL,true,false,39,"DOLLAR_39_99"));
					break;
				}
				case shuiJingComp_79.exchangeBtn:
				{
					dispatchEvent(new ShopEvent(ShopEvent.BUY_DARK_CRYSTAL,true,false,79,"DOLLAR_79_99"));
					break;
				}
				case shuiJingComp_99.exchangeBtn:
				{
					dispatchEvent(new ShopEvent(ShopEvent.BUY_DARK_CRYSTAL,true,false,99,"DOLLAR_99_99"));
					break;
				}
			}
		}
	}
}