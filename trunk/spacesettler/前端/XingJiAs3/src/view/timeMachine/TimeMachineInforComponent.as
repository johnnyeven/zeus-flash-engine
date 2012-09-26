package view.timeMachine
{
	import com.zn.utils.ClassUtil;
	
	import events.timeMachine.TimeMachineEvent;
	
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Window;
	import ui.core.Component;
	
	/**
	 *时间机器描述
	 * @author lw
	 *
	 */
    public class TimeMachineInforComponent extends Window
    {
		public var closeBtn:Button;
		
        public function TimeMachineInforComponent()
        {
            super(ClassUtil.getObject("view.timeMachine.TimeMachineInfor"));
			
			closeBtn = createUI(Button,"closeBtn");
			
			sortChildIndex();
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtn_clickHAndler);
        }
		
		private function closeBtn_clickHAndler(event:MouseEvent):void
		{
			dispatchEvent(new TimeMachineEvent(TimeMachineEvent.CLOSE_INFOR_COMPONENT_EVENT,0));
		}
    }
}