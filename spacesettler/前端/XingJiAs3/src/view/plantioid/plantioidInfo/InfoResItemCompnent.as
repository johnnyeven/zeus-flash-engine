package view.plantioid.plantioidInfo
{
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.StringUtil;
    
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
		
		public function setItemVO(url:String,num:int):void
		{
			image.source=url;
			canLangLabel.text=StringUtil.formatString("{0}/{1}",num,MultilanguageManager.getString("timeXiaoShi"));
		}
    }
}
