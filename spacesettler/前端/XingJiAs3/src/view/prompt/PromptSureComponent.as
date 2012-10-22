package view.prompt
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	
	public class PromptSureComponent extends Component
	{		
		public static const OK_EVENT:String="okEvent";
		public static const NO_EVENT:String="noEvent";
		
		public var showTF:Label;
		
		public var okButton:Button;
		
		public var noButton:Button;
		
		public var infoTF:Label;
		
		public var bg:Sprite;
		
		private var _tital:String;
		
		private var _content:String;
		
		public function PromptSureComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			
			showTF = createUI(Label, "show_lable");
			okButton = createUI(Button, "sure_btn");
			noButton = createUI(Button, "close_btn");
			infoTF = createUI(Label, "lable");
			
			sortChildIndex();
			
			okButton.addEventListener(MouseEvent.CLICK,okButton_clickHandler);
			noButton.addEventListener(MouseEvent.CLICK,noButton_clickHandler);
		}

		protected function noButton_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event(NO_EVENT));
		}
		
		protected function okButton_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event(OK_EVENT));
		}
		
		public function get content():String
		{
			return _content;
		}

		public function set content(value:String):void
		{
			_content = value;
			showTF.text=_content;
		}
		
		public function get tital():String
		{
			return _tital;
		}

		public function set tital(value:String):void
		{
			_tital = value;
			infoTF.text=_tital;
		}
	}
}