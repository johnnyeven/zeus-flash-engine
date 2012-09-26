package view.allView
{
	import com.zn.utils.ClassUtil;
	
	import events.allView.AllViewEvent;
	
	import flash.events.MouseEvent;
	
	import ui.components.Window;
	import ui.core.Component;
	
	/**
	 * 荣誉
	 * @author lw
	 * 
	 */	
    public class RongYuComponent extends Window
    {
		public var closedBtn:Component;
		
        public function RongYuComponent()
        {
            super(ClassUtil.getObject("view.allView.RongYuSkin"));
			
			closedBtn = createUI(Component,"closedBtn");
			sortChildIndex();
			closedBtn.addEventListener(MouseEvent.CLICK,closedBtn_clickHandler);
        }
		
		private function closedBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new AllViewEvent(AllViewEvent.CLOSED_RONGYU_EVENT));
		}
    }
}