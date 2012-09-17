package view.login
{
    import com.zn.utils.ClassUtil;
    
    import events.login.LoginEvent;
    
    import flash.events.MouseEvent;
    
    import ui.components.Button;
    import ui.components.TextInput;
    import ui.core.Component;

    /**
     *登陆
     * @author zn
     *
     */
    public class LoginComponent extends Component
    {
        public var userNameTextInput:TextInput;

        public var passwordTextInput:TextInput;

        public var submitButton:Button;
		
		public var backBtn:Button;
		
		public var serverList:Component;
		
		public var serverBar:Component;
		
		public var barServerName:TextInput;
		
		public var listComponent:Component;

        public function LoginComponent()
        {
            super(ClassUtil.getObject("view.login.LoginSkin"));
			userNameTextInput=createUI(TextInput,"userNameInput");
			passwordTextInput=createUI(TextInput,"passwordInput");
			submitButton=createUI(Button,"loginBtn");
			backBtn=createUI(Button,"backBtn");
			
			serverList=createUI(Component,"serverList");
			serverBar=serverList.createUI(Component,"serverBar");
			barServerName=serverBar.createUI(TextInput,"serverName");
			
			listComponent=serverList.createUI(Component,"list");
			
			
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