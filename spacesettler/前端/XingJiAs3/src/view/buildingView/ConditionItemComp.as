package view.buildingView
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.core.Component;
	
	public class ConditionItemComp extends Component
	{
		public var iconImg:LoaderImage;
		public var content:Label;
		public var btnsp:Sprite;
		public var conditionBtn:ConditionClickBtnComp;
		public function ConditionItemComp()
		{
			super(ClassUtil.getObject("view.mainView.ConditionItemComp"));
			iconImg=createUI(LoaderImage,"image");
			iconImg.isScale=true;
			content=createUI(Label,"textLabel");
			btnsp=getSkin("btnsp");
			
			sortChildIndex();
			
			conditionBtn=new ConditionClickBtnComp();
			btnsp.addChild(conditionBtn);
		}
		
		public function set imgSource(value:String):void
		{
			iconImg.source=value;
		}
		
		public function set text(value:String):void
		{
			content.text=value;
		}
		
		public function set labelOfBtn(value:String):void
		{
			conditionBtn.text=value;
		}
		
		public function get labelOfBtn():String
		{
			return conditionBtn.text;
		}
	}
}