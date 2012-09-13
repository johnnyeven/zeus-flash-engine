package view.mainView
{
    import com.zn.utils.ClassUtil;
    
    import ui.core.Component;


    /**
     *游戏主界面
     * @author Administrator
     *
     */
    public class MainViewComponent extends Component
    {
        public function MainViewComponent()
        {
            super(ClassUtil.getObject("view.mainView.MainViewComponentSkin"));
        }
    }
}
