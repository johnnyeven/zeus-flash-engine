package view.timeMachine
{
	import com.zn.utils.ClassUtil;
	
	import events.timeMachine.TimeMachineEvent;
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import proxy.timeMachine.TimeMachineProxy;
	
	import ui.components.Button;
	import ui.components.Window;
	import ui.core.Component;
	
	import vo.timeMachine.TimeMachineVO;
	
	/**
	 *时间机器
	 * @author lw
	 *
	 */
    public class TimeMachineComponent extends Window
    {
		public var totalCrystalCountTxt:TextField;
		
		public var allSpeedBtn:Button;
		
		public var closeBtn:Button;
		
		public var timeMachineInforBtn:Button;
		
        public function TimeMachineComponent()
        {
            super(ClassUtil.getObject("view.timeMachine.TimeMachine"));
			var timeMachineProxy:TimeMachineProxy = ApplicationFacade.getProxy(TimeMachineProxy);
			
			totalCrystalCountTxt = getSkin("totalCrystalCountTxt");
			allSpeedBtn = createUI(Button,"allSpeedBtn");
			closeBtn = createUI(Button,"closeBtn");
			timeMachineInforBtn = createUI(Button,"timeMachineInforBtn");
			
			sortChildIndex();
			
			setData(timeMachineProxy.timeMachineList);
			allSpeedBtn.addEventListener(MouseEvent.CLICK,allSpeedBtn_clickHandler);
			closeBtn.addEventListener(MouseEvent.CLICK,closedBtn_clickHandler);
			timeMachineInforBtn.addEventListener(MouseEvent.CLICK,timeMachineInforBtn_clickHAndler);
			
        }
		
		private function setData(arr:Array):void
		{
			if(arr.length>1)
			{
				totalCrystalCountTxt.text = (arr[arr.length-1] as TimeMachineVO).totalCrystal +"";
			}
		}
		
		private function allSpeedBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new TimeMachineEvent(TimeMachineEvent.ALL_SPEED_EVENT,0));
		}
		
		private function closedBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new TimeMachineEvent(TimeMachineEvent.CLOSE_EVENT,0));
		}
		
		private function timeMachineInforBtn_clickHAndler(event:MouseEvent):void
		{
			dispatchEvent(new TimeMachineEvent(TimeMachineEvent.SHOW_INFOR_COMPONENT_EVENT,0));
		}
    }
}