package view.plantioid
{
	import com.zn.utils.ClassUtil;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.core.Component;
	
    public class PlantioidTiShiComponent extends Component
    {
		public static const OK_EVENT:String="ok_event";
		public static const NO_EVENT:String="no_event";
		
		
		public var closeBtn:Button;
		public var sureBtn:Button;

		
        public function PlantioidTiShiComponent()
        {
            super(ClassUtil.getObject("plantioid.PlantioidTiShiSkin"));
			
			closeBtn=createUI(Button,"CloseBtn")
			sureBtn=createUI(Button,"sureBtn")
				
			sortChildIndex();
			closeBtn.addEventListener(MouseEvent.CLICK,closeHandler);
			sureBtn.addEventListener(MouseEvent.CLICK,sureHandler);
        }
		
		protected function sureHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event(OK_EVENT));
		}
		
		protected function closeHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event(NO_EVENT));
		}
	}
}