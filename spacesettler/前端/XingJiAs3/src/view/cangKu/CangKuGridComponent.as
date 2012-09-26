package view.cangKu
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	
	import ui.components.Button;
	import ui.components.LoaderImage;
	import ui.core.Component;
	
	public class CangKuGridComponent extends Component
	{
		public var image:LoaderImage;
		public var grid:Button;
		
		public function CangKuGridComponent()
		{
			super(ClassUtil.getObject("grid_skin"));
			image=createUI(LoaderImage,"image");
			grid=createUI(Button,"grid_button");
			
			sortChildIndex();
		}
		
		public function set imgSource(str:String):void
		{
			image.source=str;
		}
	}
}