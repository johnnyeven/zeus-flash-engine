package view.buildingView
{
	import events.buildingView.BuildEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.core.Component;
	
	/**
	 * 信息界面
	 * 
	 */
	public class InfoViewComponent extends Component
	{
		public var backButton:Button;//返回按钮
		
		public function InfoViewComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			backButton=createUI(Button,"back_button");
			
			sortChildIndex();
			
			backButton.addEventListener(MouseEvent.CLICK,backButton_clickHandler);
		}
		
		protected function backButton_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event(BuildEvent.BACK_EVENT));			
		}
	}
}