package view.battle.fightView
{
	import com.zn.utils.ClassUtil;
	
	import enum.ResEnum;
	
	import flash.display.DisplayObjectContainer;
	
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.core.Component;
	
	import vo.battle.fight.FightVictoryRewardVO;
	
	/**
	 * 战斗胜利奖励资源条目
	 * @author lw
	 * 
	 */	
	public class BattleVictorySourceItem extends Component
	{
		public var ziYuan_img:LoaderImage;
		public var info_tf:Label;
		
		private var _data:FightVictoryRewardVO;
		public function BattleVictorySourceItem()
		{
			super(ClassUtil.getObject("battle.BattleSourceRectSkin"));
			
			ziYuan_img=createUI(LoaderImage,"ziYuan_img");
			info_tf=createUI(Label,"info_tf");
			sortChildIndex();
		}

		public function get data():FightVictoryRewardVO
		{
			return _data;
		}

		public function set data(value:FightVictoryRewardVO):void
		{
			_data = value;
		}

	}
}