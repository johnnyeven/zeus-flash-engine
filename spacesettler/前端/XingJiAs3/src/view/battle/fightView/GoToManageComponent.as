package view.battle.fightView
{
	import com.zn.utils.ClassUtil;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.core.Component;
	
	/**
	 *提示是否对星球进行管理
	 * @author lw
	 *
	 */
    public class GoToManageComponent extends Component
    {
		public var manageBtn:Button;
		public var exitBtn:Button;
		
        public function GoToManageComponent()
        {
            super(ClassUtil.getObject("battle.GoToManageSkin"));
			manageBtn = createUI(Button,"manageBtn");
			exitBtn = createUI(Button,"exitBtn");
			sortChildIndex();
			
			manageBtn.addEventListener(MouseEvent.CLICK,manageBtn_clickHandler);
			exitBtn.addEventListener(MouseEvent.CLICK,exitBtn_clickHandler);
        }
		
		protected function exitBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event("gotoExit"));
		}
		
		protected function manageBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event("gotoManage"));
		}
	}
}