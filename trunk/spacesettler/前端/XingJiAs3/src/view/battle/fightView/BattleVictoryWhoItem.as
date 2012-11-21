package view.battle.fightView
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	
	import ui.components.Label;
	import ui.core.Component;
	
	/**
	 * 战斗胜利要塞归属权条目
	 * @author lw
	 * 
	 */	
	public class BattleVictoryWhoItem extends Component
	{
		public var info_tf:Label;
		public function BattleVictoryWhoItem()
		{
			super(ClassUtil.getObject("battle.WhoItemSkin"));
			info_tf = createUI(Label,"info_tf");
			sortChildIndex();
		}
	}
}