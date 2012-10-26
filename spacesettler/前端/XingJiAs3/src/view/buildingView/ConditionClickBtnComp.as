package view.buildingView
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	
	public class ConditionClickBtnComp extends Button
	{
		public var btnLabel:Label;
		
		public function ConditionClickBtnComp()
		{
			super(ClassUtil.getObject("ConditionCompButton"));
			btnLabel=createUI(Label,"btnLabel");
			
			sortChildIndex();
		}
		
		public function set text(value:String):void
		{
			btnLabel.text = value;
		}
		public function get text():String
		{
			return btnLabel.text;
		}
	}
}