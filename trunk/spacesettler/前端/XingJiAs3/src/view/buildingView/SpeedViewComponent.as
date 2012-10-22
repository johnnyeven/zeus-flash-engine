package view.buildingView
{
	import events.buildingView.AddViewEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.core.Component;
	
	/**
	 * 提示信息界面
	 * 
	 */
	public class SpeedViewComponent extends Component
	{
		public var infoMC:MovieClip;//提示信息栏
		public var closeButton:Button;//关闭按钮
		public var okButton:Button;//确定按钮
		
		public function SpeedViewComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			
			//closeButton=createUI(Button,"close_button");
			//okButton=createUI(Button,"ok_button");
			//infoMC=getSkin("info_MC");
			
			sortChildIndex();
			
			//closeButton.addEventListener(MouseEvent.CLICK,closeButton_clickHandler);
			//okButton.addEventListener(MouseEvent.CLICK,okButton_clickHandler);
		}
		
		protected function closeButton_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new AddViewEvent(AddViewEvent.CLOSE_EVENT));
		}
		
		protected function okButton_clickHandler(event:MouseEvent):void
		{
			
		}
	}
}