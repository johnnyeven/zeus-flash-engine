package view.login
{
	import com.zn.utils.ClassUtil;
	
	import events.login.RegistEvent;
	
	import flash.events.MouseEvent;
	
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
		public var userNameTextInput:TextInput;
		
		public var passwordTextInput:TextInput;
		
		public var passwordAgainInput:TextInput;
		
		public var nextBtn:Button;
		
		public var returnBtn:Button;
		
		public var serverList:Component;
		
		public var serverBar:Component;
		
		public var barServerName:TextInput;
		
		public var listComponent:Component;
		
        public function RegistComponent()
        {
            super(ClassUtil.getObject("view.login.RegistSkin"));
			userNameTextInput=createUI(TextInput,"userNameInput");
			passwordTextInput=createUI(TextInput,"passwordInput");
			passwordAgainInput=createUI(TextInput,"passwordAgainInput");
			nextBtn=createUI(Button,"nextBtn");
			returnBtn=createUI(Button,"returnBtn");
			
			serverList=createUI(Component,"serverList");
			serverBar=serverList.createUI(Component,"serverBar");
			barServerName=serverBar.createUI(TextInput,"serverName");
			
			listComponent=serverList.createUI(Component,"list");
			
			sortChildIndex();
			
			nextBtn.addEventListener(MouseEvent.CLICK,nextBtn_clickHandler);
			returnBtn.addEventListener(MouseEvent.CLICK,returnBtn_clickHandler);
        }
		
		protected function returnBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new RegistEvent(RegistEvent.BACK_EVENT));
		}
		
		protected function nextBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new RegistEvent(RegistEvent.NEXT_EVENT,barServerName.text,userNameTextInput.text,passwordTextInput.text,passwordAgainInput.text));
		}
	}
}