package view.battle.fightView
{
	import com.zn.utils.ClassUtil;
	
	import ui.components.Label;
	import ui.core.Component;
	
	/**
	 * 时间或其他紧急提示
	 * @author rl
	 * 
	 */	
    public class BattleTiShiPanelComponent extends Component
    {
		public var tiShiLable:Label;

		
        public function BattleTiShiPanelComponent()
        {
            super(ClassUtil.getObject("battle.BattleTiShiPanelSkin"));
			
			tiShiLable=createUI(Label,"tiShiLable");
			
			sortChildIndex();
        }
    }
}