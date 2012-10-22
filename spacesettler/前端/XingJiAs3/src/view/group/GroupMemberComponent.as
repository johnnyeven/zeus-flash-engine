package view.group
{
	import com.zn.utils.ClassUtil;
	
	import events.group.GroupEvent;
	import events.group.GroupShowAndCloseEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import proxy.group.GroupProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.VScrollBar;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	import ui.utils.DisposeUtil;
	
	import vo.group.GroupMemberListVo;
	
	/**
	 *查看成员 
	 * @author Administrator
	 * 
	 */	
    public class GroupMemberComponent extends Component
    {
				
		/**
		 *退出按钮 
		 */		
		public var tuiChuBtn:Button;
		
		/**
		 *返回按钮 
		 */		
		public var fanHuiBtn:Button;
		
		/**
		 *拖动条 
		 */		
		public var vsBar:VScrollBar;
		
		public var itemSp:Sprite;

		private var container:Container;
		private var groupProxy:GroupProxy;
		private var userProxy:UserInfoProxy;
		
		private var _currentItem:GroupItem_2Component;

        public function GroupMemberComponent()
        {
            super(ClassUtil.getObject("view.group.GroupMemberSkin"));
			
			groupProxy=ApplicationFacade.getProxy(GroupProxy);
			userProxy=ApplicationFacade.getProxy(UserInfoProxy);
			
			tuiChuBtn=createUI(Button,"tuichu_btn");
			fanHuiBtn=createUI(Button,"fanhui_btn");
			vsBar=createUI(VScrollBar,"vs_bar");
			
			itemSp=getSkin("item_sp");
			
			sortChildIndex();
			
			_currentItem=new GroupItem_2Component();
			container=new Container(null);
			container.contentWidth=itemSp.width;
			container.contentHeight=itemSp.height;			
			container.layout=new HTileLayout(container);
			container.x=0;
			container.y=0;
			itemSp.addChild(container);
			
			changeContainer();
			vsBar.viewport=container;
			
			fanHuiBtn.addEventListener(MouseEvent.CLICK,doCloseHandler)
        }
		
		private function clearContainer():void
		{
			while (container.num > 0)
				DisposeUtil.dispose(container.removeAt(0));
		}
		
		private function changeContainer():void
		{
			clearContainer();
			
			if(groupProxy.groupInfoVo.username==userProxy.userInfoVO.nickname)
			{
				isGroupLeader();
			}else
			{
				notGroupLeader();
			}
			
			for(var i:int=0;i<groupProxy.memberArr.length;i++)
			{
				var memberVo:GroupMemberListVo=groupProxy.memberArr[i] as GroupMemberListVo;
				var item:GroupItem_2Component=new GroupItem_2Component();
				item.contribution.text=memberVo.donate_dark_matter.toString();
				item.controlledNum.text=memberVo.controlledNum.toString();
				item.job.text=memberVo.job;
				item.paiMing.text=memberVo.rank.toString();
				item.userName.text=memberVo.username;
				item.currtentVo=memberVo;
				if(memberVo.vipLevel>0)
				{
					item.vip.visible=true;
				}else
				{
					item.vip.visible=false;
					
				}
				
				container.add(item);
				item.addEventListener(MouseEvent.CLICK,doClickHandler);
			}
			
			container.layout.update();
		}
		
		protected function doClickHandler(event:MouseEvent):void
		{
			currentItem=event.currentTarget as GroupItem_2Component;
		}
		
		protected function doCloseHandler(event:MouseEvent):void
		{
			dispatchEvent(new GroupShowAndCloseEvent(GroupShowAndCloseEvent.CLOSE));
		}
		
		public function isGroupLeader():void
		{
			tuiChuBtn.visible=false;
			tuiChuBtn.mouseEnabled=false;
			
		}
		
		public function notGroupLeader():void
		{
			tuiChuBtn.visible=true;
			tuiChuBtn.mouseEnabled=true;
			
			tuiChuBtn.addEventListener(MouseEvent.CLICK,doTuiChuHandler);
		}			
		
		protected function doTuiChuHandler(event:MouseEvent):void
		{
			dispatchEvent(new GroupEvent(GroupEvent.QUITE_GROUP,null,groupProxy.groupInfoVo.id));
		}
		
		public function get currentItem():GroupItem_2Component
		{
			return _currentItem;
		}
		
		public function set currentItem(value:GroupItem_2Component):void
		{
			_currentItem.back.visible=false;
			
			_currentItem = value;
			_currentItem.back.visible=true
		}

	}
}