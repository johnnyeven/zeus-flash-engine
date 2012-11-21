package view.groupFight
{
	import com.zn.utils.ClassUtil;
	
	import ui.components.Button;
	import ui.core.Component;
	
	/**
	 *查看按钮 当点击时才会触发 
	 * @author Administrator
	 * 
	 */	
    public class GroupFightBtnComponent extends Component
    {
		public var chaKanBtn:Button;
		
        public function GroupFightBtnComponent()
        {
            super(ClassUtil.getObject("view.GroupFightBtnSkin"));
			
			chaKanBtn=createUI(Button,"chaKanBtn");
			
			sortChildIndex();
        }
    }
}