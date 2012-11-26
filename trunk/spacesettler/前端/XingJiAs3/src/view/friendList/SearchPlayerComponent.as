package view.friendList
{
	import com.greensock.TweenLite;
	import com.zn.utils.ClassUtil;
	
	import events.friendList.FriendListEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
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
		
		private var container:Container;
		private var friendProxy:FriendProxy;
		
		//当前选中元件
		private var _currentSelected:FriendItem;
		private var currentCount:int = 0;
		
		public var researchShangComponent:ResearchShangComponent;
		
		public var researchXiaComponent:ResearchXiaComponent;
		/**
		 * 上标
		 */		
		private var shangBiaoSprivate:Sprite;
		/**
		 * 下标
		 */		
		private var xiaBiaoSprivate:Sprite;
		/**
		 *聊天框上遮罩 
		 */		
		private var shangSprite:Sprite;
		/**
		 *聊天框下遮罩 
		 */		
		private var xiaSprite:Sprite;
		
        public function SearchPlayerComponent()
        {
            super(ClassUtil.getObject("view.friendList.SearchPlayerSkin"));
			friendProxy = ApplicationFacade.getProxy(FriendProxy);
			
			container = new Container(null);
			container.contentWidth = 325;
			container.contentHeight = 380;
			container.layout = new HTileLayout(container);
			container.x = 12;
			container.y = 85;
			addChild(container);
			
			vScrollBar = createUI(VScrollBar, "vScrollBar");
			vScrollBar.viewport = container;
			addChild(vScrollBar);
			vScrollBar.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			vScrollBar.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			container.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			container.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			closeBtn = createUI(Button,"closeBtn");
			searchBtn = createUI(Button,"searchBtn");
			playerNameTxt = getSkin("playerNameTxt");
			playerNameTxt.mouseEnabled = true;
			playerNameTxt.addEventListener(MouseEvent.CLICK,playerNameTxt_clickHandler);
			sortChildIndex();
			
			removeCWList();
			cwList.push(BindingUtils.bindSetter(itemVOListChange,friendProxy,"searchPlayerList"));
			
			closeBtn.addEventListener(MouseEvent.CLICK,close_handler);
			searchBtn.addEventListener(MouseEvent.CLICK,searchBtn_clickHandler);
			addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
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
		
		protected function keyDownHandler(event:KeyboardEvent):void
		{
			if(event.keyCode==Keyboard.ENTER)
				searchBtn_clickHandler(null);
		}
		
		protected function searchBtn_clickHandler(event:MouseEvent):void
		{
			
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
			if(researchXiaComponent || researchShangComponent)
				return;
			_currentSelected = value;
			//将选中元件的坐标原点转化为全局坐标
			var point:Point = new Point();
			point = _currentSelected.localToGlobal(point);
			if(currentCount<1)
			{
				//聊天框上遮罩
				shangSprite = new Sprite();
				shangSprite.graphics.beginFill(0,0.5);
				shangSprite.graphics.drawRect(0,0,this.width,(point.y-_currentSelected.height/2));
				shangSprite.graphics.endFill();
				shangSprite.x = 0;
				shangSprite.y = 0;
				shangSprite.mouseEnabled = true;
				this.addChild(shangSprite);
				shangSprite.addEventListener(MouseEvent.CLICK,xiaRemove_clickHandler);
				//聊天框下遮罩
				xiaSprite = new Sprite();
				xiaSprite.graphics.beginFill(0,0.5);
				xiaSprite.graphics.drawRect(0,0,this.width,(this.height - point.y - _currentSelected.height/2-10));
				xiaSprite.graphics.endFill();
				xiaSprite.x = 0;
				xiaSprite.y = point.y + _currentSelected.height/2;
				xiaSprite.mouseEnabled = true;
				this.addChild(xiaSprite);
				xiaSprite.addEventListener(MouseEvent.CLICK,xiaRemove_clickHandler);
				
				xiaBiaoSprivate = ClassUtil.getObject("xiaBiaoSprivate") as Sprite;
				researchXiaComponent = new ResearchXiaComponent();
				researchXiaComponent.data = currentSelected.data;
				researchXiaComponent.x = 0;
				researchXiaComponent.y = this.height;
				this.addChild(xiaBiaoSprivate);
				this.addChild(researchXiaComponent);
				xiaBiaoSprivate.x = 70;
				xiaBiaoSprivate.y = point.y + _currentSelected.height/2;
				TweenLite.to(researchXiaComponent,0.5,{x:0,y:xiaBiaoSprivate.y + xiaBiaoSprivate.height});
			}
			else
			{
				//聊天框上遮罩
				shangSprite = new Sprite();
				shangSprite.graphics.beginFill(0,0.5);
				shangSprite.graphics.drawRect(0,0,this.width,(point.y-_currentSelected.height/2));
				shangSprite.graphics.endFill();
				shangSprite.x = 0;
				shangSprite.y = 0;
				shangSprite.mouseEnabled = true;
				this.addChild(shangSprite);
				shangSprite.addEventListener(MouseEvent.CLICK,shangRemove_clickHandler);
				//聊天框下遮罩
				xiaSprite = new Sprite();
				xiaSprite.graphics.beginFill(0,0.5);
				xiaSprite.graphics.drawRect(0,0,this.width,(this.height - point.y - _currentSelected.height/2-10));
				xiaSprite.graphics.endFill();
				xiaSprite.x = 0;
				xiaSprite.y = point.y + _currentSelected.height/2;
				xiaSprite.mouseEnabled = true;
				this.addChild(xiaSprite);
				xiaSprite.addEventListener(MouseEvent.CLICK,shangRemove_clickHandler);
				
				shangBiaoSprivate = ClassUtil.getObject("shangBiaoSprivate") as Sprite;
				researchShangComponent = new ResearchShangComponent();
				researchShangComponent.data = currentSelected.data;
				researchShangComponent.x = 0;
				researchShangComponent.y = 0;
				this.addChild(shangBiaoSprivate);
				this.addChild(researchShangComponent);
				shangBiaoSprivate.x = 70;
				shangBiaoSprivate.y = point.y - shangBiaoSprivate.height-_currentSelected.height/2;
				TweenLite.to(researchShangComponent,0.5,{x:0,y:shangBiaoSprivate.y-shangBiaoSprivate.height-10});
			}
		}
		
		public function xiaRemove_clickHandler(event:MouseEvent):void
		{
			this.removeChild(shangSprite);
			this.removeChild(xiaSprite);
			this.removeChild(xiaBiaoSprivate);
			this.removeChild(researchXiaComponent);
			researchXiaComponent = null;
			
		}
		
		public function shangRemove_clickHandler(event:MouseEvent):void
		{
			
			this.removeChild(shangSprite);
			this.removeChild(xiaSprite);
			this.removeChild(shangBiaoSprivate);
			this.removeChild(researchShangComponent);
			researchShangComponent = null;
		}
		
		private function playerNameTxt_clickHandler(evemt:MouseEvent):void
		{
			playerNameTxt.text = "";
		}
		
		protected function mouseOutHandler(event:MouseEvent):void
		{
			vScrollBar.alpahaTweenlite(0);
		}
		
		protected function mouseOverHandler(event:MouseEvent):void
		{
			vScrollBar.alpahaTweenlite(1);
		}
    }
}