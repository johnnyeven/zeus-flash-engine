package view.battle.fightView
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import ui.components.Label;
	import ui.components.ProgressBar;
	import ui.core.Component;
	
	public class BattleNameItemComponent extends Component
	{
		public var vipNameComp:Component;
		public var vipNameLabel:Label;
		public var nameComp:Component;
		public var nameLabel:Label;
		public var progressBar:ProgressBar;
		
		public function BattleNameItemComponent()
		{
			super(ClassUtil.getObject("battle.namePanelSkin"));
			
			vipNameComp=createUI(Component,"vipnamesp");
			nameComp=createUI(Component,"namesp");
			progressBar=createUI(ProgressBar,"progressBar");
			
			vipNameLabel=vipNameComp.createUI(Label,"nameLabel");
			vipNameLabel.sortChildIndex();
			nameLabel=nameComp.createUI(Label,"nameLabel");
			nameLabel.sortChildIndex();
			
			sortChildIndex();
		}
		
		public function setValue(isVip:Boolean,str:String):void
		{
			vipNameComp.visible=false;
			nameComp.visible=false;
			vipNameLabel.text="";
			nameLabel.text="";
			progressBar.percent=100;
			if(isVip)
			{
				vipNameComp.visible=true;
				vipNameLabel.text=str;
			}
			else
			{
				nameComp.visible=true;
				nameLabel.text=str;
			}
		}
		
		public function set PH(value:Number):void
		{
			progressBar.percent=value;
		}
	}
}