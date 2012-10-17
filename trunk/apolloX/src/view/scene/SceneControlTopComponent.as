package view.scene
{
	import flash.display.DisplayObjectContainer;
	
	import utils.liteui.component.Label;
	import utils.liteui.core.Component;
	
	public class SceneControlTopComponent extends Component
	{
		public var lblNickName: Label;
		
		public function SceneControlTopComponent(_skin:DisplayObjectContainer=null)
		{
			super(_skin);
			
			lblNickName = getUI(Label, "txtNickName") as Label;
		}
	}
}