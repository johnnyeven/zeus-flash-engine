package view.giftBag
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.core.Component;
	
	public class GiftDetileItemComponent extends Component
	{
		public var iconImg:LoaderImage;
		public var infoLabel:Label;
		
		public function GiftDetileItemComponent()
		{
			super(ClassUtil.getObject("view.giftdetileInfoItem"));
			
			iconImg=createUI(LoaderImage,"img");
			infoLabel=createUI(Label,"infoLabel");
			sortChildIndex();
			
			iconImg.isScale=true;
		}
		
		public function set imgSource(value:String):void
		{
			iconImg.source=value;
		}
		
		public function set infoTxt(value:String):void
		{
			infoLabel.text=value;
		}
	}
}