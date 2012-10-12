package view.group
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.Sprite;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.VScrollBar;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	
	/**
	 * 审核成员
	 * @author Administrator
	 * 
	 */	
    public class GroupAuditComponent extends Component
    {
		public var allAllowBtn:Button;
		public var allNotAllow:Button;
		public var fanHuiBtn:Button;
		
		public var vsBar:VScrollBar;
		
		public var itemSp:Sprite;

		private var container:Container;
        public function GroupAuditComponent()
        {
            super(ClassUtil.getObject("view.group.GroupAuditSkin"));
			allAllowBtn=createUI(Button,"quanbutongguo_btn");
			allNotAllow=createUI(Button,"quanbujujue_btn");
			fanHuiBtn=createUI(Button,"fanhui_btn");
			vsBar=createUI(VScrollBar,"vs_bar");
			
			itemSp=getSkin("sprite");
			
			sortChildIndex();
			
			container=new Container(null);
			container.contentWidth=itemSp.width;
			container.contentHeight=itemSp.height;			
			container.layout=new HTileLayout(container);
			container.x=0;
			container.y=0;
			itemSp.addChild(container);
			vsBar.viewport=container;
        }
    }
}