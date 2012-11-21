package view.group
{
	import com.greensock.TweenLite;
	import com.zn.utils.ClassUtil;
	
	import events.group.GroupEvent;
	import events.group.GroupShowAndCloseEvent;
	
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import proxy.group.GroupProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.VScrollBar;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	import ui.utils.DisposeUtil;
	
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
		public var mcUp:Component;
		public var menuLine:Sprite;
		
		/**
		 *军团名输入框 
		 */		
		public var groupText:TextField;
		
		public var shenqing_btn:Button;

		private var container:Container;
		private var _groupProxy:GroupProxy;
		private var _arr:Array=[];
		private var menuMask:Sprite;
		private var id:String;
		
		private var _currtentItem:GroupItem_1Component;
        public function NotJoinGroupComponent()
        {
            super(ClassUtil.getObject("view.group.NotJoinGroupSkin"));
			
			_groupProxy=ApplicationFacade.getProxy(GroupProxy);
			_currtentItem=new GroupItem_1Component();
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
					item.myVipShow(grouplistvo.vipLevel);
				
				container.add(item);	
				
				_arr.push(item);
				item.addEventListener(MouseEvent.CLICK,clickHandler);
			}
			container.layout.update();
		}
		
		protected function clickHandler(event:MouseEvent):void
		{
			var item:GroupItem_1Component=event.currentTarget as GroupItem_1Component;
			currtentItem=item;
			var point:Point=new Point(0,item.height*0.5);
			point = item.localToGlobal(point);
			point = globalToLocal(point);
			
			menuMask = new Sprite();
			menuMask.graphics.beginFill(0, 0.5);
			menuMask.graphics.drawRect(0, 0, this.width, this.height);
			menuMask.graphics.endFill();
			addChild(menuMask);
			
			DisposeUtil.dispose(mcUp);
			
			mcUp = new Component(ClassUtil.getObject("view.group.GroupPopSkin"))
			menuLine = ClassUtil.getObject("view.group.GroupPopLineSkin");
			shenqing_btn=mcUp.createUI(Button, "shenqing_btn");
			mcUp.sortChildIndex();
			
			for(var i:int=0;i<_arr.length;i++)
			{
				if(_arr[i]==item)
				{
					var grouplistvo:GroupListVo=_groupProxy.groupArr[i] as  GroupListVo;
//					dispatchEvent(new GroupEvent(GroupEvent.APPLYJOIN_GROUP,grouplistvo.groupname,grouplistvo.id));
					id=grouplistvo.id;
				}
			}
			menuLine.x = point.x;
			menuLine.y = point.y;
			menuMask.addChild(mcUp);
			menuMask.addChild(menuLine);
			move();
			shenqing_btn.addEventListener(MouseEvent.CLICK,shenqingBtn_ClickHandler)
			menuMask.addEventListener(MouseEvent.CLICK, remove_clickHandler);
		}
		
		public function move():void
		{
			var rect:Rectangle=menuLine.getRect(menuLine);			
			TweenLite.to(mcUp, 0.5, { y: menuLine.y + rect.top -mcUp.height- 2 });
		}
		
		protected function shenqingBtn_ClickHandler(event:MouseEvent):void
		{
			dispatchEvent(new GroupEvent(GroupEvent.APPLYJOIN_GROUP,null,id));
		}
		
		protected function remove_clickHandler(event:MouseEvent):void
		{
			this.removeChild(menuMask);
			menuMask = null;
		}

		public function get currtentItem():GroupItem_1Component
		{
			return _currtentItem;
		}

		public function set currtentItem(value:GroupItem_1Component):void
		{
			if(_currtentItem)
				_currtentItem.isNotClick();
			
			_currtentItem = value;
			_currtentItem.isClick();
		}

	}
}