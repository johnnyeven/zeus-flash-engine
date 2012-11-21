package view.group
{
	import com.zn.utils.ClassUtil;
	
	import events.group.GroupExamineEvent;
	import events.group.GroupShowAndCloseEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.VScrollBar;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	import ui.utils.DisposeUtil;
	
	import vo.group.GroupAuditListVo;
	import vo.group.GroupMemberListVo;
	
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
		public var tishi_mc:Sprite;
		
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
			tishi_mc=getSkin("tishi_mc");
			
			sortChildIndex();
			
			container=new Container(null);
			container.contentWidth=itemSp.width;
			container.contentHeight=itemSp.height;			
			container.layout=new HTileLayout(container);
			container.x=0;
			container.y=0;
			itemSp.addChild(container);
			
			fanHuiBtn.addEventListener(MouseEvent.CLICK,closeHandler);
			allAllowBtn.addEventListener(MouseEvent.CLICK,allAllowBtn_Handler);
			allNotAllow.addEventListener(MouseEvent.CLICK,allNotAllow_Handler);
        }
		
		protected function allNotAllow_Handler(event:MouseEvent):void
		{
			dispatchEvent(new GroupExamineEvent(GroupExamineEvent.ALL_REFUSE));
		}
		
		protected function allAllowBtn_Handler(event:MouseEvent):void
		{
			dispatchEvent(new GroupExamineEvent(GroupExamineEvent.ALL_ALLOW));
		}
		
		protected function closeHandler(event:MouseEvent):void
		{
			dispatchEvent(new GroupShowAndCloseEvent(GroupShowAndCloseEvent.CLOSE));
		}
		
		private function clearContainer():void
		{
			while (container.num > 0)
				DisposeUtil.dispose(container.removeAt(0));
		}
		
		public function upData(ListArr:Array):void
		{
			clearContainer();
			
			if(ListArr==null||ListArr.length==0)
			{
				isNomal();
			}else
			{
				hasMember();
			}
			
			for(var i:int=0;i<ListArr.length;i++)
			{
				var memberVo:GroupAuditListVo=ListArr[i] as GroupAuditListVo;
				var item:GroupItem_3Component=new GroupItem_3Component();
				item.userName.text=memberVo.nickname;
				item.paiMing.text=memberVo.prestige_rank.toString();
				item.currtentVo=memberVo;
				item.junXian.text=memberVo.military_rank.toString();
				if(memberVo.vip_level>0)
					item.myVipShow(memberVo.vip_level);
				item.tongGuoBtn.addEventListener(MouseEvent.CLICK,tongGuoHandler);
				item.juJueBtn.addEventListener(MouseEvent.CLICK,juJueHandler);
				
				container.add(item);
			}
			
			container.layout.update();
			vsBar.viewport=container;
			
		}
		
		protected function juJueHandler(event:MouseEvent):void
		{
			var item:GroupItem_3Component=event.target.parent as GroupItem_3Component;
			dispatchEvent(new GroupExamineEvent(GroupExamineEvent.REFUSE,item.currtentVo.player_id,item.currtentVo.id));
		}
		
		protected function tongGuoHandler(event:MouseEvent):void
		{
			var item:GroupItem_3Component=event.target.parent as GroupItem_3Component;
			dispatchEvent(new GroupExamineEvent(GroupExamineEvent.ALLOW,item.currtentVo.player_id,item.currtentVo.id));
		}
		
		public function isNomal():void
		{
			itemSp.visible=false;
			tishi_mc.visible=true;
		}
		
		public function hasMember():void
		{
			itemSp.visible=true;
			tishi_mc.visible=false;
		}
    }
}