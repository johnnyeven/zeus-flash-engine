package view.login
{
    import com.greensock.TweenLite;
    import com.zn.utils.ClassUtil;
    
    import events.login.LoginEvent;
    
    import flash.display.SpreadMethod;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    
    import proxy.login.LoginProxy;
    
    import ui.components.Button;
    import ui.components.TextInput;
    import ui.core.Component;
    
    import vo.ServerItemVO;

    /**
     *登陆
     * @author zn
     *
     */
    public class LoginComponent extends Component
    {
        public var userNameTextInput:TextField;

        public var passwordTextInput:TextField;

        public var submitButton:Button;
		
		public var backBtn:Button;
		
		/**
		 *服务器列表 
		 */		
		public var serverList:Component;
		
        public function LoginComponent()
        {
            super(ClassUtil.getObject("view.login.LoginSkin"));
			
			var loginProxy:LoginProxy = ApplicationFacade.getProxy(LoginProxy);
			
			userNameTextInput = getSkin("userNameInput");
			userNameTextInput.restrict = "a-zA-Z0-9\u4e00-\u9fa5_-";
			userNameTextInput.maxChars = 16;
//			userNameTextInput.restrict = "^[a-zA-Z0-9\u4e00-\u9fa5_-]{6,16}$";
			passwordTextInput =getSkin("passwordInput");
			passwordTextInput.restrict = "a-zA-Z0-9_-";
			passwordTextInput.maxChars = 16;
//			passwordTextInput.restrict = "^[a-zA-Z0-9_-]{6,16}$";
			
			passwordTextInput.displayAsPassword=true;
			passwordTextInput.mouseEnabled=userNameTextInput.mouseEnabled=true;
			passwordTextInput.text=userNameTextInput.text="";
			
			submitButton = createUI(Button,"loginBtn");
			backBtn = createUI(Button,"backBtn");
			
			serverList = createUI(SeverComponent,"serverList");
			
			sortChildIndex();
			
			submitButton.addEventListener(MouseEvent.CLICK, submitButton_clickHandler);
			backBtn.addEventListener(MouseEvent.CLICK,backBtn_clickHandler);
        }
		
		protected function backBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new LoginEvent(LoginEvent.BACK_EVENT));
		}
		
        protected function submitButton_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new LoginEvent(LoginEvent.LOGIN_EVENT,userNameTextInput.text,passwordTextInput.text));
        }
    }
}