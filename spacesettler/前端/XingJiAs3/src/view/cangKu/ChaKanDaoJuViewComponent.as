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
	
	public class ChaKanDaoJuViewComponent extends Component
	{
		public var itemName:Label;
		
		public var backBtn:Button;
		
		public var desLabel:Label;
		
		public function ChaKanDaoJuViewComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			itemName=createUI(Label,"itemName_tf");
			backBtn=createUI(Button,"back_btn");
			desLabel=createUI(Label,"desLabel");
			
			sortChildIndex();
			
			backBtn.addEventListener(MouseEvent.CLICK,backBtn_clickHandler);
			
			var packageProxy:PackageViewProxy=ApplicationFacade.getProxy(PackageViewProxy);
			setValue(packageProxy.chakanVO as ItemVO);
		}
		
		protected function backBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new ChaKanEvent(ChaKanEvent.CLOSEVIEW_EVENT));
		}
		
		public function setValue(info:ItemVO):void
		{
			itemName.text=info.name;
			desLabel.text=info.description;
		}
	}
}