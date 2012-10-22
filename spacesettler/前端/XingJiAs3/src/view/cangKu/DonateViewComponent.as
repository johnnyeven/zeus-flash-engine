package view.cangKu
{
	import com.zn.multilanguage.MultilanguageManager;
	
	import events.buildingView.AddViewEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	
	import vo.cangKu.ZhanCheInfoVO;
	
	public class DonateViewComponent extends Component
	{
		public static const OK_EVENT:String="okEvent";		
		
		public var juanXianWuLabel:Label;//捐献物
		public var zheHeNumLabel:Label;//折合暗物质数量
		public var donateBtn:Button;//捐献按钮
		public var closeBtn:Button;//关闭按钮
		
		public function DonateViewComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			juanXianWuLabel=createUI(Label,"juanXianWu_tf");
			zheHeNumLabel=createUI(Label,"zheHeNum_tf");
			donateBtn=createUI(Button,"donate_btn");
			closeBtn=createUI(Button,"close_btn");
			
			sortChildIndex();
			
			donateBtn.addEventListener(MouseEvent.CLICK,donateBtn_clickHandler);
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtn_clickHandler);
		}
				
		protected function donateBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event(OK_EVENT));
		}
		
		protected function closeBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new AddViewEvent(AddViewEvent.CLOSE_EVENT));
		}
		
	}
}