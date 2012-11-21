package view.battle.fightView
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.core.Component;
	/**
	 * 战斗胜利奖励图纸条目
	 * @author lw
	 * 
	 */	
	public class BattleVictoryRepiceComponent extends Component
	{
		public var iconImg:LoaderImage;
		public var nameLabel:Label;
		public var descripLabel:Label;
		
		public function BattleVictoryRepiceComponent()
		{
			super(ClassUtil.getObject("battle.BattleRepiceRectSkin"));
			
			iconImg=createUI(LoaderImage,"tuZhi_img");
			nameLabel=createUI(Label,"name_tf");
			descripLabel=createUI(Label,"descrip_tf");
			sortChildIndex();
			
		}
	}
}