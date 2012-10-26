package view.shangCheng.shangChengView
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	
	public class BuyPromptComponent extends Component
	{
		public static const OK_EVENT:String="okEvent";
		public static const NO_EVENT:String="noEvent";
		
		public var okButton:Button;
		
		public var noButton:Button;
		
		public var infoLabel:Label;
		
		public function BuyPromptComponent()
		{
			super(ClassUtil.getObject("view.allView.promViewSkin"));
			
			infoLabel=createUI(Label,"infoLabel");
			okButton=createUI(Button,"ok_btn");
			noButton=createUI(Button,"no_btn");
			
			sortChildIndex();
			
			okButton.addEventListener(MouseEvent.CLICK,okButton_clickHandler);
			noButton.addEventListener(MouseEvent.CLICK,noButton_clickHandler);
		}

		protected function okButton_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event(OK_EVENT));
		}
		
		protected function noButton_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event(NO_EVENT));
		}
	}
}