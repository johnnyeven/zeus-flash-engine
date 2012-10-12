package view.group
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.Sprite;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	
	/**
	 *审核成员的ITEM  
	 * @author Administrator
	 * 
	 */	
    public class GroupItem_3Component extends Component
    {
		/**
		 *通过按钮 
		 */		
		public var tongGuoBtn:Button;
		
		/**
		 *拒绝按钮 
		 */		
		public var juJueBtn:Button;
		
		/**
		 *军衔 
		 */		
		public var junXian:Label;
		
		/**
		 *用戶名 
		 */		
		public var userName:Label;
		
		/**
		 *排名 
		 */		
		public var paiMing:Label;
		
		public var vip:Sprite;

		public var back:Sprite;		
			
        public function GroupItem_3Component()
        {
            super(ClassUtil.getObject("view.group.GroupItem_3"));
			
			paiMing=createUI(Label,"paiming_tf");
			junXian=createUI(Label,"junxian_tf");
			userName=createUI(Label,"username_tf");
			
			tongGuoBtn=createUI(Button,"tongguo_btn");
			juJueBtn=createUI(Button,"jujue_btn");
			vip=getSkin("vip_mc");
			back=getSkin("back_mc");
			back.visible=false;			
			vip.visible=false;
			
			sortChildIndex();
        }
    }
}