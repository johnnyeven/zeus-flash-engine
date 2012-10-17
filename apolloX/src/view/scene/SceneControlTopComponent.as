package view.scene
{
	import flash.display.DisplayObjectContainer;
	
	import utils.liteui.component.Label;
	import utils.liteui.core.Component;
	
	public class SceneControlTopComponent extends Component
	{
		public var lblNickName: Label;
		public var lblMilitaryRank: Label;
		
		public function SceneControlTopComponent(_skin:DisplayObjectContainer=null)
		{
			super(_skin);
			
			lblNickName = getUI(Label, "txtNickName") as Label;
			lblMilitaryRank = getUI(Label, "txtRank") as Label;
			
			sortChildIndex();
		}
	}
}