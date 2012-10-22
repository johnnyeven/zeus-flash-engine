package view.friendList
{
	import com.zn.utils.ClassUtil;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Window;
	import ui.core.Component;
	
	/**
	 *查看军官证
	 * @author lw
	 *
	 */
    public class ViewIdCardComponent extends Window
    {
		public var closeBtn:Button;
		
        public function ViewIdCardComponent()
        {
            super(ClassUtil.getObject("view.friendList.ViewIdCardSkin"));
			
			closeBtn = createUI(Button,"closeBtn");
			sortChildIndex();
			
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtnHAndler);
        }
		
		protected function closeBtnHAndler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			dispatchEvent(new Event("closeIDCardComponent"));
		}
	}
}