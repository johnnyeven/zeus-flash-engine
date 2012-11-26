package view.cangKu
{
    import com.zn.multilanguage.MultilanguageManager;
    
    import enum.ResEnum;
    
    import events.buildingView.ConditionEvent;
    import events.cangKu.ChaKanEvent;
    
    import flash.display.DisplayObjectContainer;
    import flash.events.MouseEvent;
    
    import proxy.packageView.PackageViewProxy;
    
    import ui.components.Button;
    import ui.components.Label;
    import ui.core.Component;
    
    import vo.cangKu.BaseItemVO;
    import vo.cangKu.ItemVO;
    import vo.scienceResearch.ScienceResearchVO;

    public class ChaKanTuZhiViewComponent extends Component
    {
        public var tzName:Label;

        public var tzInfo:Label;

        public var backBtn:Button;

        public var gongNengLabel:Label;
		
		public var techDesLabel:Label;
		
		public var useBtn:Button;
		
		private var itemVo:ItemVO;
		private var conditionArr:Array=[];
        public function ChaKanTuZhiViewComponent(skin:DisplayObjectContainer)
        {
            super(skin);
            tzName = createUI(Label, "tzName_tf");
            tzInfo = createUI(Label, "tzInfo_tf");
            backBtn = createUI(Button, "back_btn");
			useBtn = createUI(Button, "use_btn");
            gongNengLabel = createUI(Label, "gongNengLabel");
			techDesLabel=createUI(Label,"techDesLabel");
			
            sortChildIndex();

            backBtn.addEventListener(MouseEvent.CLICK, backBtn_clickHandler);
			useBtn.addEventListener(MouseEvent.CLICK,useClickHandler);
			
			var packageProxy:PackageViewProxy =ApplicationFacade.getProxy(PackageViewProxy);
			itemVo=packageProxy.chakanVO as ItemVO
			setValue(itemVo);
        }
		
		protected function useClickHandler(event:MouseEvent):void
		{
			if(conditionArr.length>0)
				dispatchEvent(new ConditionEvent(ConditionEvent.ADDCONDITIONVIEW_EVENT,conditionArr));
			else
				dispatchEvent(new ChaKanEvent(ChaKanEvent.USE_EVENT,itemVo));
		}
		
        protected function backBtn_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new ChaKanEvent(ChaKanEvent.CLOSEVIEW_EVENT));
        }

        public function setValue(info:ItemVO):void
        {
            tzName.text = info.name;
            tzInfo.text = info.description;

			if(info.isChatData == true)
			{
				useBtn.visible = false;
			}
			else
			{
				useBtn.visible = true;
			}
            if (info.zhanCheVO)
                gongNengLabel.text = info.zhanCheVO.propertyDes;
            if (info.guaJianVO)
                gongNengLabel.text = info.guaJianVO.propertyDes;
			
			techDesLabel.text=info.techPropertyDes;
			
			for(var i:int=0;i<info.techVOList.length;i++)
			{
				var techVO:ScienceResearchVO=info.techVOList[i] as ScienceResearchVO;
				if(techVO.currentLevel<techVO.level)
				{
					var obj6:Object=new Object();
					obj6.imgSource=ResEnum.getConditionIconURL+"6.png";
					obj6.content=MultilanguageManager.getString("science")+techVO.currentLevel+"/"+techVO.level;
					obj6.btnLabel=MultilanguageManager.getString("study_click");
					conditionArr.push(obj6);
				}
			}
			
			if(conditionArr.length>0)
				techDesLabel.color=0xff0000;
			else
				techDesLabel.color=0x00cc33;
			
				
        }
    }
}
