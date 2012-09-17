package view.login
{
	import com.zn.utils.ClassUtil;
	
	import events.login.StartLoginEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.sendToURL;
	
	import ui.components.Button;
	import ui.core.Component;
	
	/**
	 *开始
	 * @author lw
	 *
	 */
    public class StartComponent extends Component
    {
		public var startBtn:Button;
		
		public var zhangHaoLogin:Button;
		
		public var registBtn:Button;

		public var upDoorComp:Component;
		
		public var downDoorComp:Component;
		
        public function StartComponent()
        {
            super(ClassUtil.getObject("view.login.StartSkin"));
			
			upDoorComp=createUI(Component,"upDoor");
			startBtn=upDoorComp.createUI(Button,"startBtn");
			upDoorComp.sortChildIndex();
			
			downDoorComp=createUI(Component,"downDoor");
			zhangHaoLogin=downDoorComp.createUI(Button,"zhangHaoLoginBtn");
			registBtn=downDoorComp.createUI(Button,"registBtn");
			downDoorComp.sortChildIndex();
			
			sortChildIndex();
			
			startBtn.addEventListener(MouseEvent.CLICK,srartBtn_clickHandler);
			zhangHaoLogin.addEventListener(MouseEvent.CLICK,zhangHaoLogin_clickHandler);
			registBtn.addEventListener(MouseEvent.CLICK,registBtn_clickHandler);
			
        }
		
		protected function srartBtn_clickHandler(event:MouseEvent):void
		{
             dispatchEvent(new StartLoginEvent(StartLoginEvent.START_LIGIN_EVENT));
		}
		
		protected function registBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new StartLoginEvent(StartLoginEvent.REGIST_EVENT));
		}
		
		protected function zhangHaoLogin_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new StartLoginEvent(StartLoginEvent.ACCOUNT_EVENT));
		}
	}
}