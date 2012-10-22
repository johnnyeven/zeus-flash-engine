package view.battle.bottomView
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	
	import ui.components.Label;
	import ui.core.Component;
	
	import vo.battle.BattleBuildVO;
	
	/**
	 * 战场底部界面一项
	 * @author zn
	 * 
	 */	
	public class BottomViewItemComponent extends Component
	{
		public var nameLabel:Label;
		public var anWuZhiLabel:Label;
		public var chuanQiLabel:Label;
		public var shuiJinLabel:Label;
		
		public function BottomViewItemComponent(info:BattleBuildVO=null)
		{
			super(ClassUtil.getObject("battle.BattleBottomViewItemSkin"));
			
			nameLabel=createUI(Label,"nameLabel");
			anWuZhiLabel=createUI(Label,"anNengLabel");
			chuanQiLabel=createUI(Label,"chuanQingLabel");
			shuiJinLabel=createUI(Label,"shuiJinLabel");
			
			sortChildIndex();
			
			nameLabel.text="";
			anWuZhiLabel.text="";
			chuanQiLabel.text="";
			shuiJinLabel.text="";
			if(info)
			{
				nameLabel.text=info.name;
				anWuZhiLabel.text=info.broken_crystal+"";
				chuanQiLabel.text=info.tritium+"";
				shuiJinLabel.text=info.crystal+"";
			}
		}
		
	}
}