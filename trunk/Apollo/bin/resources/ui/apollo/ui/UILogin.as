package apollo.ui {
	
	import apollo.ui.assets.UILoginTop;
	import flash.display.MovieClip;
	
	
	public class UILogin extends MovieClip
	{
		//public var uiLoginTop: UILoginTop;
		
		public function UILogin() {
			// constructor code
		}
		
		public function setBtnStartListener(_function): void
		{
			uiLoginTop.setBtnStartListener(_function);
		}
	}
	
}
