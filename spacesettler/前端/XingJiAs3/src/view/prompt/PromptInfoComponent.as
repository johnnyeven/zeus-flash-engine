package view.prompt
{
    import com.zn.utils.ClassUtil;
    
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextFieldAutoSize;
    
    import ui.components.Button;
    import ui.components.Label;
    import ui.core.Component;

    /**
     *提示信息
     * @author zn
     *
     */
    public class PromptInfoComponent extends Component
    {
        public var label:Label;
		public var okButton:Button;
		
        private var _text:String;

        public function PromptInfoComponent()
        {
            super(ClassUtil.getObject("res.PromptInfoSkin"));
            label = createUI(Label, "label");
            label.align = TextFieldAutoSize.CENTER;

			okButton=createUI(Button,"okButton");
			
            sortChildIndex();
			okButton.addEventListener(MouseEvent.CLICK,okButton_clickHandler);
        }
		
        public function get text():String
        {
            return _text;
        }

        public function set text(value:String):void
        {
            _text = value;
            label.text = value;
        }
		
		protected function okButton_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event(Event.CLOSE));
		}
    }
}
