package view.plantioid.plantioidInfo
{
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    
    import ui.components.Button;
    import ui.components.Label;
    import ui.core.Component;

    /**
     *星球信息
     * @author zn
     *
     */
    public class InfoComponent extends Component
    {
        public var canLiangItem_1:InfoResItemCompnent;

        public var canLiangItem_0:InfoResItemCompnent;

        public var areaLabel:Label;

        public var techLabel:Label;

        public var attackLabel:Label;

        public var stateLabel:Label;

        public var nameLabel:Label;

        public var pointLabel:Label;

        public var titleLabel:Label;

        public var bg2:Sprite;

        public var bg1:Sprite;
		
		public var managerBtn:Button;
		public var forceAttackBtn:Button;
		public var attackBtn:Button;

        public function InfoComponent(skin:DisplayObjectContainer)
        {
            super(skin);

            canLiangItem_1 = createUI(InfoResItemCompnent, "canLiangItem_1");
            canLiangItem_0 = createUI(InfoResItemCompnent, "canLiangItem_0");

            areaLabel = createUI(Label, "areaLabel");
            techLabel = createUI(Label, "techLabel");
            attackLabel = createUI(Label, "attackLabel");
            stateLabel = createUI(Label, "stateLabel");
            nameLabel = createUI(Label, "nameLabel");
            pointLabel = createUI(Label, "pointLabel");
            titleLabel = createUI(Label, "titleLabel");

            bg2 = getSkin("bg2");
            bg1 = getSkin("bg1");

			managerBtn=createUI(Button,"managerBtn");
			forceAttackBtn=createUI(Button,"forceAttackBtn");
			attackBtn=createUI(Button,"attackBtn");
			
            sortChildIndex();

        }
    }
}
