package view.cangKu
{
    import events.cangKu.ChaKanEvent;
    
    import flash.display.DisplayObjectContainer;
    import flash.events.MouseEvent;
    
    import proxy.packageView.PackageViewProxy;
    
    import ui.components.Button;
    import ui.components.Label;
    import ui.core.Component;
    
    import vo.cangKu.BaseItemVO;
    import vo.cangKu.ItemVO;

    public class ChaKanTuZhiViewComponent extends Component
    {
        public var tzName:Label;

        public var tzInfo:Label;

        public var backBtn:Button;

        public var gongNengLabel:Label;
		
		public var techDesLabel:Label;
		
		public var useBtn:Button;
		
		private var itemVo:ItemVO;
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

            if (info.zhanCheVO)
                gongNengLabel.text = info.zhanCheVO.propertyDes;
            if (info.guaJianVO)
                gongNengLabel.text = info.guaJianVO.propertyDes;
			
			techDesLabel.text=info.techPropertyDes;
        }
    }
}
