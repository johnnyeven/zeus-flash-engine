package view.login
{
	import com.greensock.plugins.ShortRotationPlugin;
	import com.zn.utils.ClassUtil;
	
	import events.login.NameInforEvent;
	
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.TextInput;
	import ui.core.Component;
	
	/**
	 *昵称
	 * @author lw
	 *
	 */
    public class NameInforComponent extends Component
    {
		public var nameTextInput:TextInput;
		
		public var emailTextInput:TextInput;
		
		public var returnBtn:Button;
		
		public var nextBtn:Button;
		
        public function NameInforComponent()
        {
            super(ClassUtil.getObject("view.login.NameInforSkin"));
			
			nameTextInput=createUI(TextInput,"nameInput");
			emailTextInput=createUI(TextInput,"emaillInput");
			returnBtn=createUI(Button,"returnBtn");
			nextBtn=createUI(Button,"nextBtn");
			
			sortChildIndex();
			returnBtn.addEventListener(MouseEvent.CLICK,returnBtn_clickHandler);
			nextBtn.addEventListener(MouseEvent.CLICK,nextBtn_clickHandler);
        }
		
		protected function nextBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new NameInforEvent(NameInforEvent.BACK_EVENT));
		}
		
		protected function returnBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new NameInforEvent(NameInforEvent.NEXT_EVENT,nameTextInput.text,emailTextInput.text));
		}
	}
}