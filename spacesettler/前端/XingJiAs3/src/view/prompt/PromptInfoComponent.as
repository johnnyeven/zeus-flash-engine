package view.prompt
{
    import com.zn.utils.ClassUtil;

    import flash.display.DisplayObjectContainer;
    import flash.text.TextFieldAutoSize;

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

        private var _text:String;

        public function PromptInfoComponent()
        {
            super(ClassUtil.getObject("res.PromptInfoSkin"));
            label = createUI(Label, "label");
            label.align = TextFieldAutoSize.CENTER;

            sortChildIndex();

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
    }
}
