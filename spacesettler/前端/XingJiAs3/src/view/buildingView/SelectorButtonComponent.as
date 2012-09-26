package view.buildingView
{
    import com.zn.utils.ClassUtil;

    import flash.display.Sprite;
    import flash.text.TextField;

    import ui.components.Button;
    import ui.components.Label;

    public class SelectorButtonComponent extends Button
    {
        public var tf:Label;

        public var infoSp:Sprite;

        public function SelectorButtonComponent()
        {
            super(ClassUtil.getObject("Build_Button"));

            tf = createUI(Label, "tf");
            infoSp = getSkin("infoSp");
            infoSp.visible = false;
            sortChildIndex();
        }

        public function set text(value:String):void
        {
            tf.text = value;
        }
    }
}
