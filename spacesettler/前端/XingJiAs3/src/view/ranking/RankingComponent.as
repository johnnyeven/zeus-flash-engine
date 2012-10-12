package view.ranking
{
	import com.zn.utils.ClassUtil;
	
	import events.ranking.RankingEvent;
	
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.core.Component;
	
    public class RankingComponent extends Component
    {
		public var item_5:RankingItemComponent;
		public var item_4:RankingItemComponent;
		public var item_3:RankingItemComponent;
		public var item_2:RankingItemComponent;
		public var item_1:RankingItemComponent;
		public var closeBtn:Button;

		/**
		 *排行主体Ui level1 
		 * 
		 */		
        public function RankingComponent()
        {
            super(ClassUtil.getObject("view.allView.RankingSkin"));
			
			item_1=createUI(RankingItemComponent,"item_1");
			item_2=createUI(RankingItemComponent,"item_2");
			item_3=createUI(RankingItemComponent,"item_3");
			item_4=createUI(RankingItemComponent,"item_4");
			item_5=createUI(RankingItemComponent,"item_5");
			closeBtn=createUI(Button,"close_btn");
			
			item_1.showCaiFu();
			item_2.showYaoSai();
			item_3.showJunTuan();
			item_4.showGeRen();
			item_5.showPve();
			
			closeBtn.addEventListener(MouseEvent.CLICK,doCloseHandler);
			item_1.addEventListener(MouseEvent.CLICK,doShowCaiFuHandler);
			item_2.addEventListener(MouseEvent.CLICK,doShowYaoSaiHandler);
			item_3.addEventListener(MouseEvent.CLICK,doShowJunTuanHandler);
			item_4.addEventListener(MouseEvent.CLICK,doShowGeRenHandler);
			item_5.addEventListener(MouseEvent.CLICK,doShowPveHandler);

        }
		
		protected function doShowCaiFuHandler(event:MouseEvent):void
		{
			dispatchEvent(new RankingEvent(RankingEvent.SHOW_CAIFU));
		}
		
		protected function doShowYaoSaiHandler(event:MouseEvent):void
		{
			dispatchEvent(new RankingEvent(RankingEvent.SHOW_YAOSAI));
		}
		
		protected function doShowJunTuanHandler(event:MouseEvent):void
		{
			dispatchEvent(new RankingEvent(RankingEvent.SHOW_JUNTUAN));
		}
		
		protected function doShowGeRenHandler(event:MouseEvent):void
		{
			dispatchEvent(new RankingEvent(RankingEvent.SHOW_GEREN));
		}
		
		protected function doShowPveHandler(event:MouseEvent):void
		{
			dispatchEvent(new RankingEvent(RankingEvent.SHOW_PVE));
		}
		
		protected function doCloseHandler(event:MouseEvent):void
		{
			dispatchEvent(new RankingEvent(RankingEvent.CLOSE_ALL));
			
		}
	}
}