package view.friendList
{
	import com.greensock.TweenLite;
	import com.zn.utils.ClassUtil;
	
	import events.friendList.FriendListEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
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
		
		public var friendShangComponent:FriendShangComponent;
		
		public var friendXiaComponent:FriendXiaComponent;
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
		//是否是从邮件中选择的好友列表
		private var _isSendEmail:Boolean = false;
		
        public function FriendListComponent()
        {
            super(ClassUtil.getObject("view.friendList.FriendListSkin"));
			friendProxy = ApplicationFacade.getProxy(FriendProxy);
			
			container = new Container(null);
			container.contentWidth = 325;
			container.contentHeight = 400;
			container.layout = new HTileLayout(container);
			container.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			container.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			container.x = 12;
			container.y = 80;
			addChild(container);
			
			vScrollBar = createUI(VScrollBar, "vScrollBar");
			addChild(vScrollBar);
			vScrollBar.viewport = container;
			vScrollBar.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			vScrollBar.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			container.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			container.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
//			vScrollBar.alpahaTweenlite(0);
			
			reNewBtn = createUI(Button,"reNewBtn");
			playerBtn = createUI(Button,"playerBtn");
			closeBtn  = createUI(Button,"closeBtn");
			
			sortChildIndex();
			
			removeCWList();
			cwList.push(BindingUtils.bindSetter(itemVOListChange,friendProxy,"friendArr"));
			
			
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
				friendItem.buttonMode = true;
				friendItem.addEventListener(MouseEvent.CLICK, friendItem_clickHandler);
				friendItem.dyData = i;
				
				container.add(friendItem);
			}
			
			container.layout.update();
			
			vScrollBar.update();
		}
		
		private function friendItem_clickHandler(event:MouseEvent):void
		{
			if(isSendEmail == true)
			{
				event.stopImmediatePropagation();
				dispatchEvent(new FriendListEvent(FriendListEvent.SEND_DATA_TO_EMAIL_EVENT,(event.currentTarget as FriendItem).data,true));
			}
			else
			{
				currentCount = (event.currentTarget as FriendItem).dyData;
				currentSelected = (event.currentTarget as FriendItem);
			}
			
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
			if(friendXiaComponent || friendShangComponent)
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
				friendXiaComponent = new FriendXiaComponent();
				friendXiaComponent.data = currentSelected.data;
				friendXiaComponent.x = 0;
				friendXiaComponent.y = this.height;
				this.addChild(xiaBiaoSprivate);
				this.addChild(friendXiaComponent);
				xiaBiaoSprivate.x = 70;
				xiaBiaoSprivate.y = point.y + _currentSelected.height/2;
				TweenLite.to(friendXiaComponent,0.5,{x:0,y:xiaBiaoSprivate.y + xiaBiaoSprivate.height});
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
				friendShangComponent = new FriendShangComponent();
				friendShangComponent.data = currentSelected.data;
				friendShangComponent.x = 0;
				friendShangComponent.y = 0;
				this.addChild(shangBiaoSprivate);
				this.addChild(friendShangComponent);
				shangBiaoSprivate.x = 70;
				shangBiaoSprivate.y = point.y - shangBiaoSprivate.height-_currentSelected.height/2;
				TweenLite.to(friendShangComponent,0.5,{x:0,y:shangBiaoSprivate.y-shangBiaoSprivate.height-10});
			}
		}
		
		public function xiaRemove_clickHandler(event:MouseEvent):void
		{
			    this.removeChild(shangSprite);
				this.removeChild(xiaSprite);
				this.removeChild(xiaBiaoSprivate);
				this.removeChild(friendXiaComponent);
				friendXiaComponent = null;
			
		}
		
		public function shangRemove_clickHandler(event:MouseEvent):void
		{

				this.removeChild(shangSprite);
				this.removeChild(xiaSprite);
				this.removeChild(shangBiaoSprivate);
				this.removeChild(friendShangComponent);
				friendShangComponent = null;
	    }
		
		public function get isSendEmail():Boolean
		{
			return _isSendEmail;
		}

		public function set isSendEmail(value:Boolean):void
		{
			_isSendEmail = value;
			if(isSendEmail == true)
			{
				reNewBtn.visible = false;
				playerBtn.visible = false;
			}
			else
			{
				reNewBtn.visible = true;
				playerBtn.visible = true;
			}
		}


	}
}