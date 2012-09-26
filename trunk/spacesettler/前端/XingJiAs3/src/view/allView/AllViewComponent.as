package view.allView
{
	import com.zn.utils.ClassUtil;
	
	import events.allView.AllViewEvent;
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import proxy.allView.AllViewProxy;
	
	import ui.components.Button;
	import ui.components.Window;
	import ui.core.Component;
	
	/**
	 * 总览
	 * @author lw
	 * 
	 */	
    public class AllViewComponent extends Window
    {
		public var playerNameTxt:TextField;
		
		public var rongYuTxt:TextField;
		
		public var keJiShiDaiTxt:TextField;
		
		public var junTuanTxt:TextField;
		
		public var startCountTxt:TextField;
		
		public var junXianTxt:TextField;
		
		public var junXianLvTxt:TextField;
		
		public var jinJingCountTxt:TextField;
		
		public var chuanQiCountTxt:TextField;
		
		public var anWuZhiCountTxt:TextField;
		
		public var powerCountTxt:TextField;
		
		public var usePowerCountTxt:TextField;
		
		public var viewStartBtn:Button;
		
		public var viewRongYuBtn:Button;
		
		public var closedBtn:Button;
		
        public function AllViewComponent()
        {
            super(ClassUtil.getObject("view.allView.AllViewSkin"));
			
			var allViewProxy:AllViewProxy = ApplicationFacade.getProxy(AllViewProxy);
			
			playerNameTxt = getSkin("playerNameTxt");
			
			rongYuTxt = getSkin("rongYuTxt");
			
			keJiShiDaiTxt = getSkin("keJiShiDaiTxt");
			
			junTuanTxt = getSkin("junTuanTxt");
			
			startCountTxt = getSkin("startCountTxt");
			
			junXianTxt = getSkin("junXianTxt");
			
			junXianLvTxt = getSkin("junXianLvTxt");
			
			jinJingCountTxt = getSkin("jinJingCountTxt");
			
			chuanQiCountTxt = getSkin("chuanQiCountTxt");
			
			anWuZhiCountTxt = getSkin("anWuZhiCountTxt");
			
			powerCountTxt = getSkin("powerCountTxt");
			
			usePowerCountTxt = getSkin("usePowerCountTxt");
			
			sortChildIndex();
			
			playerNameTxt.text = rongYuTxt.text = keJiShiDaiTxt.text = junTuanTxt.text = startCountTxt.text = junXianTxt.text = junXianLvTxt.text="";
			jinJingCountTxt.text = chuanQiCountTxt.text = anWuZhiCountTxt.text = powerCountTxt.text = usePowerCountTxt.text = "";
			
			if(allViewProxy.allViewVO)
			{
				playerNameTxt.text = allViewProxy.allViewVO.playerNameTxt;
				
				rongYuTxt.text = allViewProxy.allViewVO.rongYuTxt +"";
				
				keJiShiDaiTxt.text = allViewProxy.allViewVO.keJiShiDaiTxt+"";
				
				if(allViewProxy.allViewVO.junTuanTxt)
				{
					junTuanTxt.text = allViewProxy.allViewVO.junTuanTxt;
				}
				
				
				startCountTxt.text = allViewProxy.allViewVO.startCountTxt+"";
				
				junXianTxt.text = allViewProxy.allViewVO.junXianTxt;
				
				junXianLvTxt.text = allViewProxy.allViewVO.junXianLvTxt+"";
				
				jinJingCountTxt.text = allViewProxy.allViewVO.jinJingCountTxt+"";
				
				chuanQiCountTxt.text = allViewProxy.allViewVO.chuanQiCountTxt+"";
				
				anWuZhiCountTxt.text = allViewProxy.allViewVO.anWuZhiCountTxt+"";
				
				powerCountTxt.text = allViewProxy.allViewVO.powerCountTxt+"";
				
				usePowerCountTxt.text = allViewProxy.allViewVO.usePowerCountTxt+"";
			}
			viewStartBtn = createUI(Button,"viewStartBtn");
			viewRongYuBtn = createUI(Button,"viewRongYuBtn");
			closedBtn = createUI(Button,"closedBtn");
			
			viewStartBtn.addEventListener(MouseEvent.CLICK,viewStart_clickHandler);
			viewRongYuBtn.addEventListener(MouseEvent.CLICK,viewRongYu_clickHandler);
			closedBtn.addEventListener(MouseEvent.CLICK,closed_clickHandler);
			
        }
		
		private function viewStart_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new AllViewEvent(AllViewEvent.VIEW_START_EVENT));
		}
		
		private function viewRongYu_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new AllViewEvent(AllViewEvent.VIEW_RONGYU_EVENT));
		}
		
		private function closed_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new AllViewEvent(AllViewEvent.CLOSED_EVENT));
		}
    }
}