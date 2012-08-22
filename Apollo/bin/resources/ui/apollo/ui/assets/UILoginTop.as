package apollo.ui.assets {
	
	import flash.display.MovieClip;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntPoint;
	import org.aswing.JButton;
	
	
	public class UILoginTop extends MovieClip
	{
		
		private var btnStart: JButton;
		
		public function UILoginTop() {
			// constructor code
			super();
			
			btnStart = new JButton();
			btnStart.setLocation(new IntPoint(420, 230));
			btnStart.setSize(new IntDimension(119, 37));
			btnStart.setText("开始");
			
			addChild(btnStart);
		}
		
		public function setBtnStartListener(_function: Function): void
		{
			btnStart.addActionListener(_function);
		}
	}
	
}
