package view.plantioid.topInfo
{
    import flash.display.DisplayObjectContainer;
    import flash.text.TextField;

    import ui.core.Component;

    /**
     *跳转输入
     * @author zn
     *
     */
    public class JumpInputComponent extends Component
    {
        public var yTF:TextField;

        public var xTF:TextField;

        public function JumpInputComponent(skin:DisplayObjectContainer)
        {
            super(skin);

            yTF = getSkin("yTF");
            xTF = getSkin("xTF");

            yTF.restrict = xTF.restrict = "0-9";
			
            sortChildIndex();
        }
    }
}
