package view.groupFight.tiShi
{
	import com.zn.utils.ClassUtil;
	
	import events.groupFight.GroupFightEvent;
	
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	
    public class GroupFightThreeComponent extends Component
    {
		public var numLable:Label;
		public var sureBtn:Button;
		public var closeBtn:Button;

		
        public function GroupFightThreeComponent()
        {
            super(ClassUtil.getObject("view.GroupFightThreeSkin"));
			
			closeBtn=createUI(Button,"closeBtn");
			sureBtn=createUI(Button,"sureBtn");
			numLable=createUI(Label,"numLable");
			
			sortChildIndex();
			
			closeBtn.addEventListener(MouseEvent.CLICK,closeHandler);
			sureBtn.addEventListener(MouseEvent.CLICK,sureHandler);
		}
		
		protected function sureHandler(event:MouseEvent):void
		{
			dispatchEvent(new GroupFightEvent(GroupFightEvent.SURE_EVENT));
		}
		
		protected function closeHandler(event:MouseEvent):void
		{
			dispatchEvent(new GroupFightEvent(GroupFightEvent.CLOSE_EVENT));
        }
    }
}