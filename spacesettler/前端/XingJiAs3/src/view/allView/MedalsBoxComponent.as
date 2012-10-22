package view.allView
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.core.Component;
	
	import vo.allView.AllViewVO;
	
	public class MedalsBoxComponent extends Component
	{
		public var medalsImg:LoaderImage;
		public var numLabel:Label;
		
		private var _medalsInfo:Object;
		public function MedalsBoxComponent()
		{
			super(ClassUtil.getObject("view.allView.XunZhangSkin"));
			
			medalsImg = createUI(LoaderImage,"medals_img");
			numLabel=createUI(Label,"num_tf");
			
			sortChildIndex();
		}
		
		public function setValue(str:String,count:int):void
		{
			clear();
			medalsImg.source=str;
			numLabel.text="×"+count;
			if(count==0)
				numLabel.visible=false;
		}

		private function clear():void
		{
			_medalsInfo=null;
			medalsImg.source="";
			numLabel.text="";
		}
	}
}