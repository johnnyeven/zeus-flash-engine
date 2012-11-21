package view.groupFight
{
	import com.zn.utils.ClassUtil;
	
	import ui.components.Label;
	import ui.core.Component;
	
    public class GroupFightItemComponent extends Component
    {
		public var myNumTf:Label;
		public var timeTf:Label;

		
        public function GroupFightItemComponent()
        {
            super(ClassUtil.getObject("view.GroupFightItemSkin"));
			myNumTf=createUI(Label,"myNumTf");
			timeTf=createUI(Label,"timeTf");
			
			sortChildIndex();
        }
    }
}