package view.battle.fightView
{
	import com.zn.utils.ClassUtil;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	
	/**
	 * 战斗中的复活界面
	 * @author gx
	 * 
	 */	
    public class BattleRevivePanelComponent extends Component
    {
		public static const OK_EVENT:String="OK_EVENT";
		public static const NO_EVENT:String="NO_EVENT";
		
		public var buy_btn:Button;
		public var giveUp_btn:Button;
		public var cost_tf:Label;
		public var name_tf:Label;

		
        public function BattleRevivePanelComponent()
        {
            super(ClassUtil.getObject("battle.BattleRevivePanelSkin"));
			
			buy_btn=createUI(Button,"buy_btn");
			giveUp_btn=createUI(Button,"giveUp_btn");
			cost_tf=createUI(Label,"cost_tf");
			name_tf=createUI(Label,"name_tf");
			
			sortChildIndex();
			
			giveUp_btn.addEventListener(MouseEvent.CLICK,noHandler);
			buy_btn.addEventListener(MouseEvent.CLICK,okHandler);
        }
		
		protected function okHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event(OK_EVENT));
		}
		
		protected function noHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event(NO_EVENT));			
		}
	}
}