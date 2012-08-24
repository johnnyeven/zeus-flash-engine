package apollo.ui {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import apollo.ui.form.UIBuildingUpdate;
	
	public class UIBuildingUpdateForm extends MovieClip
	{
		private var container: Sprite;
		private var panel: UIBuildingUpdate;
		private var btnSubmitListener: Function;
		
		public function UIBuildingUpdateForm()
		{
			// constructor code
			super();
			panel = new UIBuildingUpdate();
			container = new Sprite();
			container.addChild(panel);
			container.alpha = 0;
			addChild(container);
			
			addEventListener(Event.ADDED, onReadyToRender);
		}
		
		public function setBtnSubmitListener(value: Function): void
		{
			btnSubmitListener = value;
			panel.getBtnSubmit().addActionListener(btnSubmitListener);
		}
		
		private function onReadyToRender(evt: Event): void
		{
			removeEventListener(Event.ADDED, onReadyToRender);
			addEventListener(Event.ENTER_FRAME, onRender);
		}
		
		private function onRender(evt: Event): void
		{
			container.alpha += .05;
			if (container.alpha >= 1)
			{
				removeEventListener(Event.ENTER_FRAME, onRender);
			}
		}
		
		public function setTitle(value: String): void
		{
			panel.getLblTitle().setText(value);
		}
	}
	
}
