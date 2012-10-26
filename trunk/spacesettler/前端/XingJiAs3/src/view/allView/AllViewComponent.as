package view.allView
{
	import com.zn.utils.ClassUtil;
	
	import events.allView.AllViewEvent;
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import proxy.allView.AllViewProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.components.Window;
	import ui.core.Component;
	
	/**
	 * 总览
	 * @author lw
	 * 
	 */	
    public class AllViewComponent extends Window
    {
		public var playerNameTxt:Label;
		
		public var rongYuTxt:Label;
		
		public var keJiShiDaiTxt:Label;
		
		public var junTuanTxt:Label;
		
		public var startCountTxt:Label;
		
		public var junXianTxt:Label;
		
		public var scienceLvTxt:Label;
		
		public var jinJingCountTxt:Label;
		
		public var chuanQiCountTxt:Label;
		
		public var anWuZhiCountTxt:Label;
		
		public var powerCountTxt:Label;
		
		public var usePowerCountTxt:Label;
		
		public var viewStartBtn:Button;
		
		public var viewRongYuBtn:Button;
		
		public var closedBtn:Button;
		
        public function AllViewComponent()
        {
            super(ClassUtil.getObject("view.allView.AllViewSkin"));
			
			var allViewProxy:AllViewProxy = ApplicationFacade.getProxy(AllViewProxy);
			var userInforProxy:UserInfoProxy = ApplicationFacade.getProxy(UserInfoProxy);
			
			playerNameTxt = createUI(Label,"playerNameTxt");
			
			rongYuTxt = createUI(Label,"rongYuTxt");
			
			keJiShiDaiTxt = createUI(Label,"keJiShiDaiTxt");
			
			junTuanTxt = createUI(Label,"junTuanTxt");
			
			startCountTxt = createUI(Label,"startCountTxt");
			
			junXianTxt = createUI(Label,"junXianTxt");
			
			scienceLvTxt = createUI(Label,"scienceLvTxt");
			
			jinJingCountTxt = createUI(Label,"jinJingCountTxt");
			
			chuanQiCountTxt = createUI(Label,"chuanQiCountTxt");
			
			anWuZhiCountTxt = createUI(Label,"anWuZhiCountTxt");
			
			powerCountTxt = createUI(Label,"powerCountTxt");
			
			usePowerCountTxt = createUI(Label,"usePowerCountTxt");
			
			sortChildIndex();
			
			playerNameTxt.text = rongYuTxt.text = keJiShiDaiTxt.text = junTuanTxt.text = startCountTxt.text = junXianTxt.text = scienceLvTxt.text="";
			jinJingCountTxt.text = chuanQiCountTxt.text = anWuZhiCountTxt.text = powerCountTxt.text = usePowerCountTxt.text = "";
			
			if(allViewProxy.allViewVO)
			{
				playerNameTxt.text = allViewProxy.allViewVO.playerNameTxt;
				
				rongYuTxt.text = allViewProxy.allViewVO.rongYuTxt +"";
				
				keJiShiDaiTxt.text = allViewProxy.allViewVO.getKeJiShiDaiNameByKeJiShiDaiLevel;
				
				if(allViewProxy.allViewVO.junTuanTxt)
				{
					junTuanTxt.text = allViewProxy.allViewVO.junTuanTxt;
				}
				
				
				startCountTxt.text = allViewProxy.allViewVO.startCountTxt+"个";
				
				junXianTxt.text = allViewProxy.allViewVO.junXianTxt;
				
				scienceLvTxt.text = allViewProxy.allViewVO.scienceLvTxt+"级";
				
				jinJingCountTxt.text = allViewProxy.allViewVO.jinJingCountTxt+"/h";
				
				chuanQiCountTxt.text = allViewProxy.allViewVO.chuanQiCountTxt+"/h";
				
				anWuZhiCountTxt.text = allViewProxy.allViewVO.anWuZhiCountTxt+"/h";
				
				powerCountTxt.text = allViewProxy.allViewVO.powerCountTxt+"/h";
				
				usePowerCountTxt.text = allViewProxy.allViewVO.usePowerCountTxt+"/h";
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