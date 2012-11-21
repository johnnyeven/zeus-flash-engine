package view.group
{
	import com.zn.utils.ClassUtil;
	
	import events.email.EmailEvent;
	import events.group.GroupEvent;
	import events.group.GroupShowAndCloseEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import proxy.group.GroupProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.Label;
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
		/**
		 *从邮件中选择的军团成员信息显示
		 */	
		public var emailArmyGroupInforSprivate:Component;
		public var playerNameLabel:Label;
		public var okBtn:Button;
		public var itemSp:Sprite;

		private var container:Container;
		private var groupProxy:GroupProxy;
		private var userProxy:UserInfoProxy;
		
		private var _currentItem:GroupItem_2Component;
		/**
		 * 是否是从邮件中选择的军团成员列表
		 */		
		private var _isSendEmailGroup:Boolean = false;
		/**
		 * 选中条目的数据
		 */		
		private var selectedItemData:GroupMemberListVo;

        public function GroupMemberComponent()
        {
            super(ClassUtil.getObject("view.group.GroupMemberSkin"));
			
			groupProxy=ApplicationFacade.getProxy(GroupProxy);
			userProxy=ApplicationFacade.getProxy(UserInfoProxy);
			
			tuiChuBtn=createUI(Button,"tuichu_btn");
			fanHuiBtn=createUI(Button,"fanhui_btn");
			vsBar=createUI(VScrollBar,"vs_bar");
			
			itemSp=getSkin("item_sp");
			emailArmyGroupInforSprivate = createUI(Component,"emailArmyGroupInforSprivate");
			playerNameLabel = emailArmyGroupInforSprivate.createUI(Label,"playerNameLabel");
			playerNameLabel.text = "";
			okBtn = emailArmyGroupInforSprivate.createUI(Button,"okBtn");
			emailArmyGroupInforSprivate.sortChildIndex();
			
			sortChildIndex();
			
			//初始化组件
			emailArmyGroupInforSprivate.visible = false;
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
					item.myVipShow(memberVo.vipLevel);
				
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
			if(_isSendEmailGroup == true)
			{
				if(_currentItem.currtentVo.player_id == userProxy.userInfoVO.player_id)
				{
					dispatchEvent(new Event("notSelectedOwn"));
					return;
				}
				//选择团友发送邮件
				selectedItemData = _currentItem.currtentVo;
				playerNameLabel.text = _currentItem.currtentVo.username;
				okBtn.addEventListener(MouseEvent.CLICK,okBtn_clickHandler);
			}
			else
			{
				//查看军官证
				dispatchEvent(new GroupEvent(GroupEvent.CHENK_ID_CARD_BY_ARMY_GROUP_EVENT,null,_currentItem.currtentVo.player_id));
			}
		}
		
		public function get isSendEmailGroup():Boolean
		{
			return _isSendEmailGroup;
		}
		
		public function set isSendEmailGroup(value:Boolean):void
		{
			_isSendEmailGroup = value;
			if(_isSendEmailGroup == true)
			{
//				tuiChuBtn.visible = false;
				emailArmyGroupInforSprivate.visible = true;
			}
			else
			{
//				tuiChuBtn.visible = true;
				emailArmyGroupInforSprivate.visible = false;
			}
			
		}
		
		private function okBtn_clickHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			dispatchEvent(new EmailEvent(EmailEvent.SEND_ARMY_GROUP_INFOR_TO_EMAIL_EVENT,selectedItemData,true));
		}
	}
}