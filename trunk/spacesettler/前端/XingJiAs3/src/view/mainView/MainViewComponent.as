package view.mainView
{
    import com.zn.utils.ClassUtil;
    
    import flash.display.Sprite;
    
    import ui.core.Component;


    /**
     *游戏主界面
     * @author Administrator
     *
     */
    public class MainViewComponent extends Component
    {
		public var chatComp:ChatViewComponent;	
		
		public var topComp:TopViewComponent;
		
		public var controlComp:ControlViewComponent;
		
		public var prompComp:PromptViewComponent;		
		
        public function MainViewComponent()
        {
            super(ClassUtil.getObject("view.mainView.MainViewComponentSkin"));
			topComp=createUI(TopViewComponent,"top_mc_skin");
			chatComp=createUI(ChatViewComponent,"liaotian_mc_skin");
			controlComp=createUI(ControlViewComponent,"anniu_mc_skin");
			prompComp=createUI(PromptViewComponent,"tishi_mc");			
			
			sortChildIndex();//重新排序
        }
    }
}
