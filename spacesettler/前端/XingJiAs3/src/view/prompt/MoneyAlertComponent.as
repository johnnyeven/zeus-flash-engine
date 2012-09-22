package view.prompt
{
    import com.zn.utils.ClassUtil;
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    import ui.components.Button;
    import ui.components.Label;
    import ui.core.Component;

    /**
     *RMB提示框
     * @author zn
     *
     */
    public class MoneyAlertComponent extends Component
    {
		public static const OK_EVENT:String="okEvent";
		public static const NO_EVENT:String="noEvent";
		
        public var countTF:Label;

        public var okButton:Button;

        public var noButton:Button;

        public var infoTF:Label;

        public var bg:Sprite;

        public function MoneyAlertComponent()
        {
            super(ClassUtil.getObject("res.MoneyAlertSkin"));

            countTF = createUI(Label, "countTF");
            okButton = createUI(Button, "okButton");
            noButton = createUI(Button, "noButton");
            infoTF = createUI(Label, "infoTF");

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
	}
}
