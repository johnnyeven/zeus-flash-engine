package view.friendList
{
	import com.greensock.TweenLite;
	import com.zn.utils.ClassUtil;
	
	import events.friendList.FriendListEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.friendList.FriendProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.VScrollBar;
	import ui.components.Window;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	import ui.utils.DisposeUtil;
	
	/**
	 *好友列表
	 * @author lw
	 *
	 */
    public class FriendListComponent extends Window
    {
		public var vScrollBar:VScrollBar; //拖动条
		public var reNewBtn:Button;
		public var playerBtn:Button;
		public var closeBtn:Button;
		
		private var container:Container;
		private var friendProxy:FriendProxy;
		
		//当前选中元件
		private var _currentSelected:FriendItem;
		private var currentCount:int = 0;
		
		public var shangSprite:Component;
		public var deletBtnUP:Button;
		public var checkBtnUP:Button;
		public var chatBtnUP:Button;
		
		public var xiaSprite:Component;
		public var deletBtnDown:Button;
		public var checkBtnDown:Button;
		public var chatBtnDown:Button;
		
		public var maskSprite:Sprite;
		
        public function FriendListComponent()
        {
            super(ClassUtil.getObject("view.friendList.FriendListSkin"));
			friendProxy = ApplicationFacade.getProxy(FriendProxy);
			
			container = new Container(null);
			container.contentWidth = 325;
			container.contentHeight = 450;
			container.layout = new HTileLayout(container);
			container.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			container.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			container.x = 12;
			container.y = 40;
			addChild(container);
			
			vScrollBar = createUI(VScrollBar, "vScrollBar");
			vScrollBar.viewport = container;
			vScrollBar.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			vScrollBar.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			vScrollBar.alpahaTweenlite(0);
			
			reNewBtn = createUI(Button,"reNewBtn");
			playerBtn = createUI(Button,"playerBtn");
			closeBtn  = createUI(Button,"closeBtn");
			shangSprite = createUI(Component,"shangSprite");
			deletBtnUP =shangSprite.createUI(Button,"deletBtnUP");
			checkBtnUP =shangSprite.createUI(Button,"checkBtnUP");
			chatBtnUP =shangSprite.createUI(Button,"chatBtnUP");
			
			xiaSprite = createUI(Component,"xiaSprite");
			deletBtnDown = xiaSprite.createUI(Button,"deletBtnDown");
			checkBtnDown = xiaSprite.createUI(Button,"checkBtnDown");
			chatBtnDown = xiaSprite.createUI(Button,"chatBtnDown");
	
			maskSprite = getSkin("maskSprite");
			shangSprite.visible = false;
			xiaSprite.visible = false;
			
			sortChildIndex();
			
			removeCWList();
			cwList.push(BindingUtils.bindSetter(itemVOListChange,friendProxy,"friendArr"));
			
			//销毁sprite
			shangSprite.addEventListener(MouseEvent.CLICK,shangSprite_clickHandler);
			xiaSprite.addEventListener(MouseEvent.CLICK,xiaSprite_clickHandler);
			shangSprite.buttonMode = true;
			xiaSprite.buttonMode = true;
			
			reNewBtn.addEventListener(MouseEvent.CLICK,reNewBtn_clickHandler);
			playerBtn.addEventListener(MouseEvent.CLICK,playerBtn_clickHandler);
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtn_clickHand);
        }
		
		private function itemVOListChange(value:*):void
		{
			while (container.num > 0)
				DisposeUtil.dispose(container.removeAt(0));
			
			var arr:Array = value as Array;
			for (var i:int = 0; i < arr.length; i++)
			{
				var friendItem:FriendItem = new FriendItem();
				
				friendItem.data = arr[i];
				friendItem.addEventListener(MouseEvent.CLICK, friendItem_clickHandler);
				friendItem.dyData = i;
				
				container.add(friendItem);
			}
			
			container.layout.update();
			
			vScrollBar.update();
		}
		
		private function friendItem_clickHandler(event:MouseEvent):void
		{
			currentCount = (event.currentTarget as FriendItem).dyData;
			currentSelected = (event.currentTarget as FriendItem);
		}
		
		protected function mouseOutHandler(event:MouseEvent):void
		{
			vScrollBar.alpahaTweenlite(0);
		}
		
		protected function mouseOverHandler(event:MouseEvent):void
		{
			vScrollBar.alpahaTweenlite(1);
		}
		
		private function closeBtn_clickHand(event:MouseEvent):void
		{
			dispatchEvent(new FriendListEvent(FriendListEvent.CLOSE_FRIEND_LIST_EVENT));
		}
		private function playerBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new FriendListEvent(FriendListEvent.SEARCH_PLATER_EVENT));
		}
		
		private function reNewBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new FriendListEvent(FriendListEvent.RENEW_FRIENF_LIST_EVENT));
		}

		public function get currentSelected():FriendItem
		{
			return _currentSelected;
		}

		public function set currentSelected(value:FriendItem):void
		{
			if(currentSelected)
			{
				currentSelected.topSprite.visible = false;
				currentSelected.buttonSprite.visible = false;
				TweenLite.to(shangSprite,0.5,{x:0,y:-330});
				TweenLite.to(xiaSprite,0.5,{x:0,y:500});
				shangSprite.visible = false;
				xiaSprite.visible = false;
			}
			_currentSelected = value;
			if(currentCount<1)
			{
				currentSelected.buttonSprite.visible = true;
				xiaSprite.visible = true;
				xiaSprite.mask = maskSprite;
				TweenLite.to(xiaSprite,0.5,{x:0,y:currentSelected.y+currentSelected.height});
			}
			else
			{
				currentSelected.topSprite.visible = true;
				shangSprite.visible = true;
				shangSprite.mask = maskSprite;
				TweenLite.to(shangSprite,0.5,{x:0,y:currentSelected.y-330});
			}
		}
		
		private function shangSprite_clickHandler(event:MouseEvent):void
		{
			if(shangSprite.visible == true)
			{
				_currentSelected.buttonSprite.visible = false;
				_currentSelected.topSprite.visible = false;
				dispatchEvent(new Event("destoryshangSprite"));
			}
		}
		
		private function xiaSprite_clickHandler(event:MouseEvent):void
		{
			if( xiaSprite.visible == true)
			{
				_currentSelected.buttonSprite.visible = false;
				_currentSelected.topSprite.visible = false;
				dispatchEvent(new Event("destoryxiaSprite"));
			}
		}

	}
}