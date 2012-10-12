package view.group
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.Sprite;
	
	import ui.components.Label;
	import ui.core.Component;
	
	/**
	 *查看团员 管理成员的ITEM  
	 * @author Administrator
	 * 
	 */	
    public class GroupItem_2Component extends Component
    {
		/**
		 *可控数量 
		 */		
		public var controlledNum:Label;
		
		/**
		 *贡献值 
		 */		
		public var contribution:Label;
		
		/**
		 *排名 
		 */		
		public var paiMing:Label;
		
		/**
		 *职务 
		 */		
		public var job:Label;
		
		/**
		 *用户名 
		 */		
		public var userName:Label;
		
		/**
		 *vip 
		 */		
		public var vip:Sprite;

		public var back:Sprite;		
		
        public function GroupItem_2Component()
        {
            super(ClassUtil.getObject("view.group.GroupItem_2"));
			
			controlledNum=createUI(Label,"kekongshu_tf");
			contribution=createUI(Label,"gongxian_tf");
			paiMing=createUI(Label,"paiming_tf");
			job=createUI(Label,"zhiwu_tf");
			userName=createUI(Label,"username_tf");
			
			vip=getSkin("vip_mc");
			back=getSkin("back_mc");
			back.visible=false;
			vip.visible=false;
			
			sortChildIndex();
        }
    }
}