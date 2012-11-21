package view.group
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.Sprite;
	
	import ui.components.Label;
	import ui.core.Component;
	
	import vo.group.GroupMemberListVo;
	
	/**
	 *查看团员 管理成员的ITEM  
	 * @author Administrator
	 * 
	 */	
    public class GroupItem_2Component extends Component
    {
		public var vip1:Sprite;
		public var vip2:Sprite;
		public var vip3:Sprite;
		
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

		public var back:Sprite;		
		public var currtentVo:GroupMemberListVo;
		private var _data:GroupMemberListVo;
		
        public function GroupItem_2Component()
        {
            super(ClassUtil.getObject("view.group.GroupItem_2"));
			
			controlledNum=createUI(Label,"kekongshu_tf");
			contribution=createUI(Label,"gongxian_tf");
			paiMing=createUI(Label,"paiming_tf");
			job=createUI(Label,"zhiwu_tf");
			userName=createUI(Label,"username_tf");
			
			back=getSkin("back_mc");
			back.visible=false;
			vip1=getSkin("vip1");
			vip2=getSkin("vip2");
			vip3=getSkin("vip3");
			vip1.visible=vip2.visible=vip3.visible=false;
			
			sortChildIndex();
        }
		
		public function myVipShow(level:int):void
		{
			if(level==1)
			{
				vip1.visible=true;
			}
			if(level==2)
			{
				vip2.visible=true;
			}
			if(level==3)
			{
				vip3.visible=true;
			}
		}

		public function get data():GroupMemberListVo
		{
			return _data;
		}

		public function set data(value:GroupMemberListVo):void
		{
			_data = value;
		}

    }
}