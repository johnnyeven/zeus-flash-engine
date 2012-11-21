package view.giftBag
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	
	import ui.components.Label;
	import ui.core.Component;
	
	public class GiftDetileInfoComponent extends Component
	{
		public var infoLabel:Label;
		
		public function GiftDetileInfoComponent()
		{
			super(ClassUtil.getObject("view.giftdetileInfo"));
			infoLabel=createUI(Label,"info");
			sortChildIndex();
		}
		
		public function set text(value:String):void
		{
			infoLabel.text=value;
		}
	}
}