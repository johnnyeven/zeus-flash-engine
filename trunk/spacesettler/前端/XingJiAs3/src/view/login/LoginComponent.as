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

        public function LoginComponent()
        {
            super(ClassUtil.getObject("view.login.LoginSkin"));
			userNameTextInput=createUI(TextInput,"userNameInput");
			passwordTextInput=createUI(TextInput,"passwordInput");
			submitButton=createUI(Button,"loginBtn");
			
			sortChildIndex();
			
			submitButton.addEventListener(MouseEvent.CLICK, submitButton_clickHandler);
        }

        protected function submitButton_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new LoginEvent(LoginEvent.LOGIN_EVENT,userNameTextInput.text,passwordTextInput.text));
        }
    }
}