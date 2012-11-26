package view.login
{
	import com.greensock.plugins.ShortRotationPlugin;
	import com.zn.utils.ClassUtil;
	
	import events.login.NameInforEvent;
	
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	
	import proxy.login.LoginProxy;
	
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
		public var nameTextInput:TextField;
		
		public var emailTextInput:TextField;
		
		public var returnBtn:Button;
		
		public var returnSprie:Button;
		
		public var nextBtn:Button;
		
        public function NameInforComponent()
        {
            super(ClassUtil.getObject("view.login.NameInforSkin"));
			
			var loginProxy:LoginProxy = ApplicationFacade.getProxy(LoginProxy);
			
			nameTextInput=getSkin("nameInput");
			nameTextInput.restrict = "a-zA-Z0-9\u4e00-\u9fa5_-";
			nameTextInput.maxChars=16;
//			nameTextInput.restrict = "^[a-zA-Z0-9\u4e00-\u9fa5_-]{6,16}$";
			emailTextInput=getSkin("emaillInput");
//			emailTextInput.restrict = "^(?:[a-z\d]+[_\-\+\.]?)*[a-z\d]+@(?:([a-z\d]+\-?)*[a-z\d]+\.)+([a-z]{2,})+$";
			
			nameTextInput.mouseEnabled = emailTextInput.mouseEnabled = true;
			nameTextInput.text = emailTextInput.text = "";
			
			if(loginProxy.name)
			{
				nameTextInput.text = loginProxy.name;
			}
			if(loginProxy.email)
			{
				emailTextInput.text = loginProxy.email;
			}
			returnBtn=createUI(Button,"returnBtn");
			returnSprie = createUI(Button,"returnSprie");
			returnSprie.visible = false;
			nextBtn=createUI(Button,"nextBtn");
			
			sortChildIndex();
			returnBtn.addEventListener(MouseEvent.CLICK,returnBtn_clickHandler);
			nextBtn.addEventListener(MouseEvent.CLICK,nextBtn_clickHandler);
			nameTextInput.addEventListener(TextEvent.TEXT_INPUT, nameInputEvent);
        }
		
		private function nameInputEvent(e:TextEvent):void
		{
			
			if((getStringBytesLength(nameTextInput.text,"gb2312") +
				
				getStringBytesLength(e.text,'gb2312')) > nameTextInput.maxChars)
			{
				e.preventDefault();
				return; 
			}
		}
		
		private function getStringBytesLength(str:String,charSet:String):int
		{
			
			var bytes:ByteArray = new ByteArray();
			
			bytes.writeMultiByte(str, charSet);
			
			bytes.position = 0;
			
			return bytes.length;
			
		}
		
		
		protected function nextBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new NameInforEvent(NameInforEvent.NEXT_EVENT,nameTextInput.text,emailTextInput.text));
		}
		
		protected function returnBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new NameInforEvent(NameInforEvent.BACK_EVENT));
		}
	}
}