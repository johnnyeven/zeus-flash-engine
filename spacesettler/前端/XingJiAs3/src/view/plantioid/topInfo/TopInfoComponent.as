package view.plantioid.topInfo
{
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    
    import ui.components.Button;
    import ui.components.Label;
    import ui.core.Component;

    /**
     *顶部信息
     * @author zn
     *
     */
    public class TopInfoComponent extends Component
    {
        public var pointYLabel:Label;

        public var pointXLabel:Label;

        public var jumpInputComp:JumpInputComponent;

        public var currentAreaSp:Sprite;

        public var jumpBtn:Button;

        public var MyXinXinBtn:Button;

        public function TopInfoComponent(skin:DisplayObjectContainer)
        {
            super(skin);
			
			pointYLabel=createUI(Label,"pointYLabel");
			pointXLabel=createUI(Label,"pointXLabel");
			
			jumpInputComp=createUI(JumpInputComponent,"jumpInputComp");
			
			jumpBtn=createUI(Button,"jumpBtn");
			MyXinXinBtn=createUI(Button,"MyXinXinBtn");
			
			currentAreaSp=getSkin("currentAreaSp");
			
			sortChildIndex();
        }
    }
}
