package view.login
{
	import com.zn.utils.ClassUtil;
	
	import events.login.PkEvent;
	
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.core.Component;
	
	/**
	 *阵营
	 * @author lw
	 *
	 */
    public class PkComponent extends Component
    {
		public var allianceBtn:Button;
		
		public var haiDaoBtn:Button;
		
		public var returnBtn:Button;
		
		public var beginBtn:Button;
		
		private var alliance:String;
		
        public function PkComponent()
        {
            super(ClassUtil.getObject("view.login.PkSkin"));
			
			allianceBtn=createUI(Button,"allianceBtn");
			haiDaoBtn=createUI(Button,"haiDaoBtn");
			returnBtn=createUI(Button,"returnBtn");
			beginBtn=createUI(Button,"beginBtn");
			
			sortChildIndex();
			
			allianceBtn.addEventListener(MouseEvent.CLICK,allianceBtn_clickHandler);
			haiDaoBtn.addEventListener(MouseEvent.CLICK,haiDaoBtn_clickHandler);
			returnBtn.addEventListener(MouseEvent.CLICK,returnBtn_clickHandler);
			beginBtn.addEventListener(MouseEvent.CLICK,beginBtn_clickHandler);
        }
		
		protected function beginBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new PkEvent(PkEvent.START_EVENT,alliance));
		}
		
		protected function returnBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new PkEvent(PkEvent.BACK_EVENT));
		}
		
		protected function haiDaoBtn_clickHandler(event:MouseEvent):void
		{
			
		}
		
		protected function allianceBtn_clickHandler(event:MouseEvent):void
		{
			
		}
	}
}