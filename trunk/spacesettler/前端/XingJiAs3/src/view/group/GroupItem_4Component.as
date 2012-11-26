package view.group
{
	import com.zn.utils.ClassUtil;
	
	import ui.components.Label;
	import ui.core.Component;
	
    public class GroupItem_4Component extends Component
    {
		/**
		 *团员获得水晶数量 
		 */		
		public var numLable:Label;
		
		/**
		 *团员名字 
		 */		
		public var nameLable:Label;

		
        public function GroupItem_4Component()
        {
            super(ClassUtil.getObject("view.group.GroupItem_4"));
			
			numLable=createUI(Label,"numLable");
			nameLable=createUI(Label,"nameLable"); 
			
			sortChildIndex();
        }
    }
}