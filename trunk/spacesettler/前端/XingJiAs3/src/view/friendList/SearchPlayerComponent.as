package view.friendList
{
	import com.greensock.TweenLite;
	import com.zn.utils.ClassUtil;
	
	import events.friendList.FriendListEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.friendList.FriendProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.TextInput;
	import ui.components.VScrollBar;
	import ui.components.Window;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	import ui.utils.DisposeUtil;
	
	/**
	 *搜索玩家
	 * @author lw
	 *
	 */
    public class SearchPlayerComponent extends Window
    {
		public var closeBtn:Button;
		
		public var searchBtn:Button;
		
		public var playerNameTxt:TextField;
		
		public var vScrollBar:VScrollBar; //拖动条
		
		public var xiaSprite:Component;
		public var buttonSprite:Component;
		public var noCheckBtn:Button;
		public var addFriendBtn:Button;
		//已经加为了好友的查看
		public var hasCheckBtn:Button;
		
		public var maskSprite:Sprite;
		
		private var container:Container;
		private var friendProxy:FriendProxy;
		
		//当前选中元件
		private var _currentSelected:FriendItem;
		private var currentCount:int = 0;
		
        public function SearchPlayerComponent()
        {
            super(ClassUtil.getObject("view.friendList.SearchPlayerSkin"));
			friendProxy = ApplicationFacade.getProxy(FriendProxy);
			
			container = new Container(null);
			container.contentWidth = 325;
			container.contentHeight = 450;
			container.layout = new HTileLayout(container);
			container.x = 12;
			container.y = 40;
			addChild(container);
			
			vScrollBar = createUI(VScrollBar, "vScrollBar");
			vScrollBar.viewport = container;
			closeBtn = createUI(Button,"closeBtn");
			searchBtn = createUI(Button,"searchBtn");
			playerNameTxt = getSkin("playerNameTxt");
			playerNameTxt.mouseEnabled = true;
			
			xiaSprite = createUI(Component,"xiaSprite");
			buttonSprite = xiaSprite.createUI(Component,"buttonSprite");
			noCheckBtn = buttonSprite.createUI(Button,"noCheckBtn");
			addFriendBtn = buttonSprite.createUI(Button,"addFriendBtn");
			buttonSprite.sortChildIndex();
			hasCheckBtn = xiaSprite.createUI(Button,"hasCheckBtn");
			xiaSprite.sortChildIndex();
			
			maskSprite = getSkin("maskSprite");
			xiaSprite.visible = false;
			xiaSprite.addEventListener(MouseEvent.CLICK,xiaSprite_clickHandler);
			xiaSprite.buttonMode = true;
			sortChildIndex();
			
			removeCWList();
			cwList.push(BindingUtils.bindSetter(itemVOListChange,friendProxy,"searchPlayerList"));
			
			closeBtn.addEventListener(MouseEvent.CLICK,close_handler);
			searchBtn.addEventListener(MouseEvent.CLICK,searchBtn_clickHandler);
			//查看军官证
			noCheckBtn.addEventListener(MouseEvent.CLICK,checkBtn_clickHandler);
			hasCheckBtn.addEventListener(MouseEvent.CLICK,checkBtn_clickHandler);
			//添加好友
			addFriendBtn.addEventListener(MouseEvent.CLICK,addFriendBtn_clickHandler);
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
		
		private function xiaSprite_clickHandler(event:MouseEvent):void
		{
			if( xiaSprite.visible == true)
			{
				_currentSelected.buttonSprite.visible = false;
				_currentSelected.topSprite.visible = false;
				dispatchEvent(new Event("search_destoryxiaSprite"));
			}
		}
		
		protected function searchBtn_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			dispatchEvent(new FriendListEvent(FriendListEvent.SEARCH_PLATER_EVENT,playerNameTxt.text));
		}
		
		private function close_handler(event:MouseEvent):void
		{
			dispatchEvent(new FriendListEvent(FriendListEvent.CLOSE_SEARCH_PLAYER_EVENT));
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
				TweenLite.to(xiaSprite,0.5,{x:0,y:500});
				xiaSprite.visible = false;
			}
			_currentSelected = value;
			if(currentCount<1)
			{
				currentSelected.buttonSprite.visible = true;
				//根据此变量控制不同的按钮显示
				if(_currentSelected.data.isMyFriend == false)
				{
					buttonSprite.visible = true;
					hasCheckBtn.visible = false;
				}
				else
				{
					buttonSprite.visible = false;
					hasCheckBtn.visible = true;
				}
				xiaSprite.visible = true;
				xiaSprite.mask = maskSprite;
				TweenLite.to(xiaSprite,0.5,{x:0,y:currentSelected.y+currentSelected.height});
				
			}
			else
			{
				currentSelected.topSprite.visible = true;
			}
		}
		
		private function checkBtn_clickHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			dispatchEvent(new FriendListEvent(FriendListEvent.SEARCH_CHECK_PLAYER_ID_CARD_EVENT,currentSelected.data,true));
		}
		
		private function addFriendBtn_clickHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			dispatchEvent(new FriendListEvent(FriendListEvent.SEARCH_ADD_FRIEND_EVENT,currentSelected.data,true));
		}

    }
}