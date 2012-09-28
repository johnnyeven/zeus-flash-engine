package view.timeMachine
{
	import com.zn.utils.ClassUtil;
	
	import events.timeMachine.TimeMachineEvent;
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.timeMachine.TimeMachineProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.Label;
	import ui.components.VScrollBar;
	import ui.components.Window;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	
	import vo.timeMachine.TimeMachineVO;
	
	/**
	 *时间机器
	 * @author lw
	 *
	 */
    public class TimeMachineComponent extends Window
    {
		public var totalCrystalCountTxt:Label;
		
		public var allSpeedBtn:Button;
		
		public var closeBtn:Button;
		
		public var timeMachineInforBtn:Button;
		
		private var container:Container;
		public var vscrollBar:VScrollBar;
		
		private var totalCrystal:int;
		
        public function TimeMachineComponent()
        {
            super(ClassUtil.getObject("view.timeMachine.TimeMachine"));
			var timeMachineProxy:TimeMachineProxy = ApplicationFacade.getProxy(TimeMachineProxy);
			
			totalCrystalCountTxt = createUI(Label,"totalCrystalCountTxt");
			allSpeedBtn = createUI(Button,"allSpeedBtn");
			closeBtn = createUI(Button,"closeBtn");
			timeMachineInforBtn = createUI(Button,"timeMachineInforBtn");
			vscrollBar = createUI(VScrollBar,"vscrollBar");
			sortChildIndex();
			
			totalCrystalCountTxt.text = "";
			
			
			removeCWList();
			
			var userInforProxy:UserInfoProxy = ApplicationFacade.getProxy(UserInfoProxy);
			cwList.push(BindingUtils.bindProperty(totalCrystalCountTxt,"text",userInforProxy,["userInfoVO","dark_crystal"]));
			container = new Container(null);
			container.contentWidth = 330;
			container.contentHeight =370;
			container.layout = new HTileLayout(container);
			container.x = 4;
			container.y = 100;
			addChild(container);
			
			
			setData(timeMachineProxy.timeMachineList);
			allSpeedBtn.addEventListener(MouseEvent.CLICK,allSpeedBtn_clickHandler);
			closeBtn.addEventListener(MouseEvent.CLICK,closedBtn_clickHandler);
			timeMachineInforBtn.addEventListener(MouseEvent.CLICK,timeMachineInforBtn_clickHAndler);
			
        }
		
		private function setData(arr:Array):void
		{
			if(arr.length>0)
			{
				totalCrystal = (arr[arr.length-1] as TimeMachineVO).totalCrystal;
			}
			var timeMachineItem:TimeMachineItem;
			for(var i:int =0;i<arr.length;i++)
			{
				timeMachineItem = new TimeMachineItem();
				timeMachineItem.data = arr[i] as TimeMachineVO;
				container.add(timeMachineItem);
			}
			container.layout.update();
			vscrollBar.viewport = container;
		}
		
		private function allSpeedBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new TimeMachineEvent(TimeMachineEvent.ALL_SPEED_EVENT,0,totalCrystal));
		}
		
		private function closedBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new TimeMachineEvent(TimeMachineEvent.CLOSE_EVENT,0,0));
		}
		
		private function timeMachineInforBtn_clickHAndler(event:MouseEvent):void
		{
			dispatchEvent(new TimeMachineEvent(TimeMachineEvent.SHOW_INFOR_COMPONENT_EVENT,0,0));
		}
    }
}