package view.prompt
{
	import com.zn.utils.ClassUtil;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	
    public class GroupPopComponent extends Component
    {
		public static const OK_EVENT:String="okEvent";
		public static const NO_EVENT:String="noEvent";
		
		public var quXiaoBtn:Button;
		
		public var shengQingBtn:Button;
		
		public var infoTf:Label;

		
        public function GroupPopComponent()
        {
            super(ClassUtil.getObject("res.GroupPopSkin"));
			
			quXiaoBtn=createUI(Button,"quxiao_btn");
			shengQingBtn=createUI(Button,"shenqing_btn");
			infoTf=createUI(Label,"info_lable");
			
			sortChildIndex();
			
			shengQingBtn.addEventListener(MouseEvent.CLICK,okButton_clickHandler);
			quXiaoBtn.addEventListener(MouseEvent.CLICK,noButton_clickHandler);
        }
		
		protected function noButton_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event(NO_EVENT));
		}
		
		protected function okButton_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event(OK_EVENT));
		}
    }
}