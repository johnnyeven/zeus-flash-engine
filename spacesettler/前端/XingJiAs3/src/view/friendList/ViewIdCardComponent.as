package view.friendList
{
	import ui.core.Component;
	import com.zn.utils.ClassUtil;
	
	/**
	 *查看军官证
	 * @author lw
	 *
	 */
    public class ViewIdCardComponent extends Component
    {
		
		
        public function ViewIdCardComponent()
        {
            super(ClassUtil.getObject("view.friendList.ViewIdCardSkin"));
        }
    }
}