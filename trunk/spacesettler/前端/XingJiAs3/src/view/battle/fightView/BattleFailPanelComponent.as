package view.battle.fightView
{
	import com.zn.utils.ClassUtil;
	
	import events.battle.fight.FightPanelEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import proxy.plantioid.PlantioidProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	/**
	 * 战斗失败
	 * @author lw
	 * 
	 */	
	public class BattleFailPanelComponent extends Component
	{
		public var nameLabel:Label;
		public var closeBtn:Button;
//		private var plantioidProxy:PlantioidProxy;
		public function BattleFailPanelComponent()
		{
			super(ClassUtil.getObject("battle.BattleFailPanelSkin"));
//			plantioidProxy = ApplicationFacade.getProxy(PlantioidProxy);
			nameLabel=createUI(Label,"yaoSaiName_tf");
			closeBtn=createUI(Button,"close_btn");
			sortChildIndex();
			
			nameLabel.text="攻占"+PlantioidProxy.selectedVO.fort_name+"要塞失败.";
			
			closeBtn.addEventListener(MouseEvent.CLICK,closeHandler)
		}
		
		protected function closeHandler(event:MouseEvent):void
		{
			dispatchEvent(new FightPanelEvent(FightPanelEvent.CLOSE_EVENT));
		}
	}
}