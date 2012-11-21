package view.friendList
{
	import com.greensock.TweenLite;
	import com.zn.utils.ClassUtil;
	
	import events.friendList.FriendListEvent;
	
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
	 *显示敌人列表
	 * @param lw
	 *
	 */
    public class EnemyListComponent extends Window
    {
		public var vScrollBar:VScrollBar; //拖动条
		public var reNewBtn:Button;
		public var enemyBtn:Button;
		public var closeBtn:Button;
		
		private var container:Container;
		private var friendProxy:FriendProxy;
		
		//当前选中元件
		private var _currentSelected:EnemyItem;
		private var currentCount:int = 0;
		public var enemyShangComponent:EnemyShangComponent;
		
		public var enemyXiaComponent:EnemyXiaComponent;
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
        public function EnemyListComponent()
        {
            super(ClassUtil.getObject("view.friendList.EnemyListSkin"));
			friendProxy = ApplicationFacade.getProxy(FriendProxy);
			
			container = new Container(null);
			container.contentWidth = 325;
			container.contentHeight = 380;
			container.layout = new HTileLayout(container);
			container.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			container.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			container.x = 12;
			container.y = 80;
			addChild(container);
			
			vScrollBar = createUI(VScrollBar, "vScrollBar");
			vScrollBar.viewport = container;
			vScrollBar.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			vScrollBar.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			vScrollBar.alpahaTweenlite(0);
			
			reNewBtn = createUI(Button,"reNewBtn");
			enemyBtn = createUI(Button,"enemyBtn");
			closeBtn  = createUI(Button,"closeBtn");
		
			sortChildIndex();
			
			removeCWList();
			cwList.push(BindingUtils.bindSetter(itemVOListChange,friendProxy,"enemyArr"));
			
			reNewBtn.addEventListener(MouseEvent.CLICK,reNewBtn_clickHandler);
			enemyBtn.addEventListener(MouseEvent.CLICK,enemyBtn_clickHandler);
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtn_clickHand);
			
        }
		
		private function itemVOListChange(value:*):void
		{
			while (container.num > 0)
				DisposeUtil.dispose(container.removeAt(0));
			
			var arr:Array = value as Array;
			for (var i:int = 0; i < arr.length; i++)
			{
				var enemyItem:EnemyItem = new EnemyItem();
				
				enemyItem.data = arr[i];
				enemyItem.addEventListener(MouseEvent.CLICK, enemyItem_clickHandler);
				enemyItem.dyData = i;
				
				container.add(enemyItem);
			}
			
			container.layout.update();
			
			vScrollBar.update();
		}
		
		private function enemyItem_clickHandler(event:MouseEvent):void
		{
			currentCount = (event.currentTarget as EnemyItem).dyData;
			currentSelected = (event.currentTarget as EnemyItem);
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
			dispatchEvent(new FriendListEvent(FriendListEvent.CLOSE_ENEMY_LIST_EVENT));
		}
		private function enemyBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new FriendListEvent(FriendListEvent.SEARCH_PLATER_EVENT));
		}
		
		private function reNewBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new FriendListEvent(FriendListEvent.RENEW_FRIENF_LIST_EVENT));
		}
		
		public function get currentSelected():EnemyItem
		{
			return _currentSelected;
		}
		
		public function set currentSelected(value:EnemyItem):void
		{
			if(enemyXiaComponent || enemyShangComponent)
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
				enemyXiaComponent = new EnemyXiaComponent();
				enemyXiaComponent.data = currentSelected.data;
				enemyXiaComponent.x = 0;
				enemyXiaComponent.y = this.height;
				this.addChild(xiaBiaoSprivate);
				this.addChild(enemyXiaComponent);
				xiaBiaoSprivate.x = 70;
				xiaBiaoSprivate.y = point.y + _currentSelected.height/2;
				TweenLite.to(enemyXiaComponent,0.5,{x:0,y:xiaBiaoSprivate.y + xiaBiaoSprivate.height});
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
				enemyShangComponent = new EnemyShangComponent();
				enemyShangComponent.data = currentSelected.data;
				enemyShangComponent.x = 0;
				enemyShangComponent.y = 0;
				this.addChild(shangBiaoSprivate);
				this.addChild(enemyShangComponent);
				shangBiaoSprivate.x = 70;
				shangBiaoSprivate.y = point.y - shangBiaoSprivate.height-_currentSelected.height/2;
				TweenLite.to(enemyShangComponent,0.5,{x:0,y:shangBiaoSprivate.y-shangBiaoSprivate.height-10});
			}
		}
		
		public function xiaRemove_clickHandler(event:MouseEvent):void
		{
			this.removeChild(shangSprite);
			this.removeChild(xiaSprite);
			this.removeChild(xiaBiaoSprivate);
			this.removeChild(enemyXiaComponent);
			enemyXiaComponent = null;
			
		}
		
		public function shangRemove_clickHandler(event:MouseEvent):void
		{
			
			this.removeChild(shangSprite);
			this.removeChild(xiaSprite);
			this.removeChild(shangBiaoSprivate);
			this.removeChild(enemyShangComponent);
			enemyShangComponent = null;
		}
    }
}