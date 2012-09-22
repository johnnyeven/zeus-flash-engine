package view.buildingView
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import ui.components.Button;
	
	public class SelectorButtonComponent extends Button
	{
		public var tf:TextField;
		public var infoSp:Sprite;
		public function SelectorButtonComponent()
		{
			super(ClassUtil.getObject("Build_Button"));
			
			tf=getSkin("tf");
			infoSp=getSkin("infoSp");
			infoSp.visible=false;
			sortChildIndex();
		}
		
		public function set text(value:String):void
		{
			tf.text=value;
		}
	}
}