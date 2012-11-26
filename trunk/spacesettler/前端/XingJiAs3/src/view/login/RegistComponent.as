package view.login
{
	import com.zn.utils.ClassUtil;
	
	import events.login.RegistEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	
	import proxy.login.LoginProxy;
	
	import ui.components.Button;
	import ui.components.TextInput;
	import ui.core.Component;
	
	/**
	 *注册
	 * @author lw
	 *
	 */
    public class RegistComponent extends Component
    {
		public var userNameTextInput:TextField;
		
		public var passwordTextInput:TextField;
		
		public var passwordAgainInput:TextField;
		
		public var nextBtn:Button;
		
		public var returnBtn:Button;
		
		public var serverList:Component;
		
        public function RegistComponent()
        {
            super(ClassUtil.getObject("view.login.RegistSkin"));
			
			var loginProxy:LoginProxy = ApplicationFacade.getProxy(LoginProxy);
			
			userNameTextInput=getSkin("userNameInput");
			userNameTextInput.restrict = "a-zA-Z0-9\u4e00-\u9fa5_-";
			userNameTextInput.maxChars = 16;
//			userNameTextInput.restrict = "^[a-zA-Z0-9\u4e00-\u9fa5_-]{6,16}$";
			
			passwordTextInput=getSkin("passwordInput");
			passwordTextInput.restrict = "a-zA-Z0-9_-";
			passwordTextInput.maxChars = 16;
//			passwordTextInput.restrict = "^[a-zA-Z0-9_-]{6,16}$";
			
			passwordTextInput.displayAsPassword = true;
			passwordAgainInput=getSkin("passwordAgainInput");
			passwordTextInput.restrict = "a-zA-Z0-9_-";
			passwordTextInput.maxChars = 16;
//			passwordAgainInput.restrict = "^[a-zA-Z0-9_-]{6,16}$";
			passwordAgainInput.displayAsPassword = true;
			
			userNameTextInput.text = passwordTextInput.text = passwordAgainInput.text = "";
			if(loginProxy.userName)
			{
			  userNameTextInput.text = loginProxy.userName;
			}
			if(loginProxy.passWord)
			{
				passwordTextInput.text = loginProxy.passWord;
			}
			if(loginProxy.passAgainWord)
			{
				passwordAgainInput.text = loginProxy.passAgainWord;
			}
			
			userNameTextInput.mouseEnabled = passwordTextInput.mouseEnabled = passwordAgainInput.mouseEnabled = true;
			
			nextBtn=createUI(Button,"nextBtn");
			returnBtn=createUI(Button,"returnBtn");
			
			serverList=createUI(SeverComponent,"serverList");
			
			
			sortChildIndex();
			
			nextBtn.addEventListener(MouseEvent.CLICK,nextBtn_clickHandler);
			returnBtn.addEventListener(MouseEvent.CLICK,returnBtn_clickHandler);
			userNameTextInput.addEventListener(TextEvent.TEXT_INPUT, nameInputEvent);
        }
		
		
		private function nameInputEvent(e:TextEvent):void
		{
			
			if((getStringBytesLength(userNameTextInput.text,"gb2312") +
				
				getStringBytesLength(e.text,'gb2312')) > userNameTextInput.maxChars)
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
		
		protected function returnBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new RegistEvent(RegistEvent.BACK_EVENT));
		}
		
		protected function nextBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new RegistEvent(RegistEvent.NEXT_EVENT,null,userNameTextInput.text,passwordTextInput.text,passwordAgainInput.text));
		}
	}
}