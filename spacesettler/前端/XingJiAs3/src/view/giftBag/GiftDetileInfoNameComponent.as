package view.giftBag
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	
	import ui.components.Label;
	import ui.core.Component;
	
	public class GiftDetileInfoNameComponent extends Component
	{
		public var nameLabel:Label;
		
		public function GiftDetileInfoNameComponent()
		{
			super(ClassUtil.getObject("view.giftdetileInfoItemName"));
			
			nameLabel=createUI(Label,"nameLabel");
			sortChildIndex();
		}
		
		public function set nameTxt(value:String):void
		{
			nameLabel.text=value;
		}
	}
}