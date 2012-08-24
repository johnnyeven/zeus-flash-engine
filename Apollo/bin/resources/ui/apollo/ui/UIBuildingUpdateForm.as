package apollo.ui {
	
	import flash.display.MovieClip;
	
	import apollo.ui.form.UIBuildingUpdate;
	
	public class UIBuildingUpdateForm extends MovieClip
	{
		private var panel: UIBuildingUpdate;
		
		public function UIBuildingUpdateForm()
		{
			// constructor code
			super();
			panel = new UIBuildingUpdate();
			addChild(panel);
		}
		
		public function setTitle(value: String): void
		{
			panel.getLblTitle().setText(value);
		}
	}
	
}
