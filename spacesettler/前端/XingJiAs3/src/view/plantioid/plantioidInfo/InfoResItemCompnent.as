package view.plantioid.plantioidInfo
{
    import flash.display.DisplayObjectContainer;
    
    import ui.components.Label;
    import ui.components.LoaderImage;
    import ui.core.Component;

    /**
     *星球信息资源项
     * @author zn
     *
     */
    public class InfoResItemCompnent extends Component
    {
        public var canLangLabel:Label;

        public var image:LoaderImage;

        public function InfoResItemCompnent(skin:DisplayObjectContainer)
        {
            super(skin);
			
			canLangLabel=createUI(Label,"canLangLabel");
			image=createUI(LoaderImage,"image");
			
			sortChildIndex();
			
        }
    }
}
