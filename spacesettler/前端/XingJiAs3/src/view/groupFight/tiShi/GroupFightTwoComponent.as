package view.groupFight.tiShi
{
	import com.zn.utils.ClassUtil;
	
	import events.groupFight.GroupFightEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.HSlider;
	import ui.components.Label;
	import ui.core.Component;
	
	import vo.groupFight.GroupFightVo;
	
    public class GroupFightTwoComponent extends Component
    {
		public var hsBar:HSlider;
		
		public var numLable2:Label;
		public var numLable1:Label;
		
		public var sureBtn:Button;
		public var closeBtn:Button;

		
        public function GroupFightTwoComponent()
        {
            super(ClassUtil.getObject("view.GroupFightTwoSkin"));
			
			sureBtn=createUI(Button,"sureBtn");
			closeBtn=createUI(Button,"closeBtn");
			numLable1=createUI(Label,"numLable1");
			numLable2=createUI(Label,"numLable2");
			hsBar=createUI(HSlider,"hsBar");
			
			sortChildIndex();
			
			closeBtn.addEventListener(MouseEvent.CLICK,closeHandler);
			sureBtn.addEventListener(MouseEvent.CLICK,sureHandler);
        }
		
		public function upData(starVo:GroupFightVo):void
		{
			numLable1.text=starVo.warship.toString();
			numLable2.text="0";
			hsBar.maxValue=starVo.warship;
			hsBar.addEventListener(Event.CHANGE,changeHandler);
		}
		
		protected function changeHandler(event:Event):void
		{
			numLable2.text=hsBar.value.toString();
		}
		
		protected function sureHandler(event:MouseEvent):void
		{
			if(hsBar.value==0)
				dispatchEvent(new GroupFightEvent(GroupFightEvent.CLOSE_EVENT));
			else
				dispatchEvent(new GroupFightEvent(GroupFightEvent.SURE_EVENT,hsBar.value));
		}
		
		protected function closeHandler(event:MouseEvent):void
		{
			dispatchEvent(new GroupFightEvent(GroupFightEvent.CLOSE_EVENT));
		}
	}
}