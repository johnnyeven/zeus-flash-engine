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

            sortChildIndex();
			
			yTF.restrict = xTF.restrict = "0-9";
			yTF.mouseEnabled=xTF.mouseEnabled=true;
        }

		public function get enterX():int
		{
			return int(xTF.text);
		}

		public function set enterX(value:int):void
		{
			xTF.text=value+"";
		}

		public function get enterY():int
		{
			return int(yTF.text);
		}

		public function set enterY(value:int):void
		{
			yTF.text=value+"";
		}
    }
}
