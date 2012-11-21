package view.ranking
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.DateFormatter;
	
	import events.ranking.RankingEvent;
	
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	
	import vo.ranking.RankingUserVo;
	
    public class RankingComponent extends Component
    {
		public var item_5:RankingItemComponent;
		public var item_4:RankingItemComponent;
		public var item_3:RankingItemComponent;
		public var item_2:RankingItemComponent;
		public var item_1:RankingItemComponent;
		public var closeBtn:Button;
		public var tiShiTf:Label;
		

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
			tiShiTf=createUI(Label,"tiShiTf");
			
			item_1.showCaiFu();
			item_2.showYaoSai();
			item_3.showJunTuan();
			item_4.showGeRen();
			item_5.showPve();
			item_5.visible=false;
			closeBtn.addEventListener(MouseEvent.CLICK,doCloseHandler);
			item_1.addEventListener(MouseEvent.CLICK,doShowCaiFuHandler);
			item_2.addEventListener(MouseEvent.CLICK,doShowYaoSaiHandler);
			item_3.addEventListener(MouseEvent.CLICK,doShowJunTuanHandler);
			item_4.addEventListener(MouseEvent.CLICK,doShowGeRenHandler);
			item_5.addEventListener(MouseEvent.CLICK,doShowPveHandler);
			item_5.mouseEnabled=item_5.mouseEnabled=false;
        }
		
		public function upData(rankVo:RankingUserVo):void
		{
			item_1.timeText.text=DateFormatter.formatterTimeNYR(rankVo.orders_rank_updated_time);
			item_2.timeText.text=DateFormatter.formatterTimeNYR(rankVo.forts_count_rank_updated_time);
			item_3.timeText.text=DateFormatter.formatterTimeNYR(rankVo.legion_prestige_rank_updated_time);
			item_4.timeText.text=DateFormatter.formatterTimeNYR(rankVo.person_prestige_rank_updated_time);
			
			item_1.zongBangText.text=rankVo.orders_total_rank_first;
			item_1.riBangText.text=rankVo.orders_daily_rank_first;
			
			item_2.zongBangText.text=rankVo.forts_count_total_rank_first;
			item_2.riBangText.text=rankVo.forts_count_daily_rank_first;
			
			item_3.zongBangText.text=rankVo.legion_prestige_total_rank_first;
			item_3.riBangText.text=rankVo.legion_prestige_daily_rank_first;
			
			item_4.zongBangText.text=rankVo.person_prestige_total_rank_first;
			item_4.riBangText.text=rankVo.person_prestige_daily_rank_first;
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