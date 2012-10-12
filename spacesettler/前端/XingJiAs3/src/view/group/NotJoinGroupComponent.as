package view.group
{
	import com.zn.utils.ClassUtil;
	
	import events.group.GroupEvent;
	import events.group.GroupShowAndCloseEvent;
	
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import proxy.group.GroupProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.VScrollBar;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	
	import vo.group.GroupListVo;
	
    public class NotJoinGroupComponent extends Component
    {
		/**
		 *创建按钮 
		 */		
		public var foundBtn:Button;
		
		/**
		 *关闭按钮 
		 */		
		public var closeBtn:Button;
		public var vsBar:VScrollBar;
		
		public var itemSp:Sprite;
		
		/**
		 *军团名输入框 
		 */		
		public var groupText:TextField;

		private var container:Container;
		private var _groupProxy:GroupProxy;
		private var _arr:Array=[];
        public function NotJoinGroupComponent()
        {
            super(ClassUtil.getObject("view.group.NotJoinGroupSkin"));
			
			_groupProxy=ApplicationFacade.getProxy(GroupProxy);
			
			foundBtn=createUI(Button,"chuangjian_btn");
			closeBtn=createUI(Button,"close_btn");
			vsBar=createUI(VScrollBar,"vs_bar");
			
			itemSp=getSkin("item_sp");
			groupText=getSkin("juntuan_tf");
			
			sortChildIndex();	
			
			groupText.mouseEnabled=true;
			groupText.addEventListener(FocusEvent.FOCUS_IN,groupTextInHandler);
			
			
			container=new Container(null);
			container.contentWidth=itemSp.width;
			container.contentHeight=itemSp.height;			
			container.layout=new HTileLayout(container);
			container.x=0;
			container.y=0;
			
			addContainer();
			
			itemSp.addChild(container);
			vsBar.viewport=container;
			
			closeBtn.addEventListener(MouseEvent.CLICK,closeClickHandler);
			foundBtn.addEventListener(MouseEvent.CLICK,foundClickHandler);
        }
				
		protected function groupTextInHandler(event:FocusEvent):void
		{
			groupText.text="";
		}
		
		protected function foundClickHandler(event:MouseEvent):void
		{
			dispatchEvent(new GroupEvent(GroupEvent.CREAT_GROUP,groupText.text));
		}
		
		protected function closeClickHandler(event:MouseEvent):void
		{
			dispatchEvent(new GroupShowAndCloseEvent(GroupShowAndCloseEvent.CLOSE));
		}
		
		private function addContainer():void
		{
			var length:int=_groupProxy.groupArr.length;
			for(var i:int=0;i<length;i++)
			{
				var grouplistvo:GroupListVo=_groupProxy.groupArr[i] as  GroupListVo;
				var item:GroupItem_1Component=new GroupItem_1Component();
				item.paiMing.text=grouplistvo.rank.toString();
				if(grouplistvo.rank==1)
				{
					item.first();
				}else if(grouplistvo.rank==2)
				{
					item.second();
				}else if(grouplistvo.rank==3)
				{
					item.thirdly();
				}else
				{
					item.normal();
				}
				item.huiZhang.text=grouplistvo.username;
				item.peopleNum.text=grouplistvo.peopleNum.toString()+"/50";
				item.groupName.text=grouplistvo.groupname;
				if(grouplistvo.vipLevel>0)
				{
					item.vip.visible=true;
				}else
				{
					item.vip.visible=false;
				}
				container.add(item);	
				
				_arr.push(item);
				item.addEventListener(MouseEvent.CLICK,clickHandler);
			}
			container.layout.update();
		}
		
		protected function clickHandler(event:MouseEvent):void
		{
			var item:GroupItem_1Component=event.currentTarget as GroupItem_1Component;
			for(var i:int=0;i<_arr.length;i++)
			{
				if(_arr[i]==item)
				{
					var grouplistvo:GroupListVo=_groupProxy.groupArr[i] as  GroupListVo;
					dispatchEvent(new GroupEvent(GroupEvent.APPLYJOIN_GROUP,grouplistvo.groupname,grouplistvo.id));
				}
			}
		}
	}
}