package view.systemView
{
	import com.zn.utils.ClassUtil;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import ui.components.Button;
	import ui.core.Component;
	
    public class SystemPassWordComponent extends Component
    {
		public static const OK_EVENT:String="ok_event";
		public static const NO_EVENT:String="no_event";
		
		public var passWord3:TextField;
		public var passWord2:TextField;
		public var passWord1:TextField;
		
		public var CloseBtn:Button;
		public var sureBtn:Button;

		
        public function SystemPassWordComponent()
        {
            super(ClassUtil.getObject("view.systemView.SystemPassWordSkin"));
			
			passWord1=getSkin("passWord1");
			passWord2=getSkin("passWord2");
			passWord3=getSkin("passWord3");
			
			sureBtn=createUI(Button,"sureBtn");
			CloseBtn=createUI(Button,"CloseBtn");
			
			sortChildIndex();
			
			passWord1.mouseEnabled=passWord2.mouseEnabled=passWord3.mouseEnabled=true;
//			passWord1.displayAsPassword=passWord2.displayAsPassword=passWord3.displayAsPassword=true;
			passWord1.restrict=passWord2.restrict=passWord3.restrict="0-9a-zA-Z"
			passWord1.maxChars=passWord2.maxChars=passWord3.maxChars=16;
			CloseBtn.addEventListener(MouseEvent.CLICK,closeHandler);
			sureBtn.addEventListener(MouseEvent.CLICK,sureHandler);
			
        }
		
		protected function sureHandler(event:MouseEvent):void
		{
			
			if(passWord2.text==passWord3.text&&passWord2.length>6&&passWord3.length>6)
				dispatchEvent(new Event(OK_EVENT));
		}
		
		protected function closeHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event(NO_EVENT));
		}
	}
}