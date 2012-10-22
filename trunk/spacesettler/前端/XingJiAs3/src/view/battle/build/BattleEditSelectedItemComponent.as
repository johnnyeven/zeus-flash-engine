package view.battle.build
{
	import com.zn.utils.ClassUtil;
	
	import ui.components.Label;
	import ui.core.Component;
	
	import vo.battle.BattleBuildVO;
	
	public class BattleEditSelectedItemComponent extends Component
	{
		public var attackLabel:Label;
		public var naiJiuLabel:Label;
		public var nameLabel:Label;
		public var infoLabel:Label;
		
		public var label1:Label;
		public var label2:Label;
		
		private var _buildVO:BattleBuildVO;
		
		public function BattleEditSelectedItemComponent(showMoreInfo:Boolean=true)
		{
			super(ClassUtil.getObject("battle.BattleEditSelectedItemSkin"));
			attackLabel=createUI(Label,"attackLabel");
			naiJiuLabel=createUI(Label,"naiJiuLabel");
			nameLabel=createUI(Label,"nameLabel");
			infoLabel=createUI(Label,"infoLabel");
			
			label1=createUI(Label,"label1");
			label2=createUI(Label,"label2");			
			
			sortChildIndex();
			
			buttonMode=true;
			
			if(!showMoreInfo)
				label1.visible=label2.visible=nameLabel.visible=naiJiuLabel.visible=attackLabel.visible=false;
			else
				infoLabel.visible=false;
		}
		
		
		public function get buildVO():BattleBuildVO
		{
			return _buildVO;
		}

		public function set buildVO(value:BattleBuildVO):void
		{
			_buildVO = value;
			
			attackLabel.text=buildVO.attack+"";
			naiJiuLabel.text=buildVO.endurance+"";
			nameLabel.text=buildVO.name;
		}
		
		public function set info(value:String):void
		{
			infoLabel.text=value;
		}
	}
}