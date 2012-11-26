package view.allView
{
	import com.greensock.TweenLite;
	import com.zn.utils.BitmapUtil;
	import com.zn.utils.ClassUtil;
	
	import events.allView.AllViewEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.allView.AllViewProxy;
	
	import ui.components.Button;
	import ui.components.Window;
	import ui.core.Component;
	
	import vo.plantioid.FortsInforVO;
	
	/**
	 *行星要塞 
	 * @author lw
	 * 
	 */	
    public class XingXingComponent extends Window
    {
		public static var IS_MINE:Boolean;
		
		private var allViewProxy:AllViewProxy;
		
		public var closeBtn:Button;
		
		//星星元件
		public var fort_0:BoxComponent;
		public var fort_1:BoxComponent;
		public var fort_2:BoxComponent;
		public var fort_3:BoxComponent;
		public var fort_4:BoxComponent;
		public var fort_5:BoxComponent;
		public var fort_6:BoxComponent;
		public var fort_7:BoxComponent;
		public var fort_8:BoxComponent;
		public var fort_9:BoxComponent;
		public var fort_10:BoxComponent;
		public var fort_11:BoxComponent;
		
		private var boxComponentList:Array = [];
		
		/**
		 *每页数量 
		 */		
		private var _pageCount:int = 12;
		/**
		 *当前页数 
		 */		
		private var _currentPageIndex:int =1;
		private var _maxPage:int;
		private var _startIndex:int;
		private var _endIndex:int;
		/**
		 *每页数据 
		 */		
		private var _dataArray:Array = [];
		
		public var turnLeftBtn:Button;
		public var turnRightBtn:Button;
		
		public var shangSprite:Component;
		public var checkBtnUP:Button;
		public var mangeBtnUP:Button;
		public var attackBtnUP:Button;
		
		public var xiaSprite:Component;
		public var checkBtnDown:Button;
		public var manageBtnDown:Button;
		public var attackBtnDown:Button;
		public var maskSprite:Sprite;
		//当前选中元件
		private var _currentSelected:BoxComponent;
		private var currentCount:int = 0;
        public function XingXingComponent()
        {
            super(ClassUtil.getObject("view.allView.XingXingSkin"));
			
			allViewProxy = ApplicationFacade.getProxy(AllViewProxy);
			
			closeBtn = createUI(Button,"closeBtn");
			
			//星星元件
			fort_0 = createUI(BoxComponent,"fort_0");
			fort_1 = createUI(BoxComponent,"fort_1");
			fort_2 = createUI(BoxComponent,"fort_2");
			fort_3 = createUI(BoxComponent,"fort_3");
			fort_4 = createUI(BoxComponent,"fort_4");
			fort_5 = createUI(BoxComponent,"fort_5");
			fort_6 = createUI(BoxComponent,"fort_6");
			fort_7 = createUI(BoxComponent,"fort_7");
			fort_8 = createUI(BoxComponent,"fort_8");
			fort_9 = createUI(BoxComponent,"fort_9");
			fort_10 = createUI(BoxComponent,"fort_10");
			fort_11 = createUI(BoxComponent,"fort_11");
			boxComponentList.push(fort_0,fort_1,fort_2,fort_3,fort_4,fort_5,fort_6,fort_7,fort_8,fort_9,fort_10,fort_11);
			for(var i:int = 0;i<boxComponentList.length;i++)
			{
				(boxComponentList[i]  as BoxComponent).visible = false;
				(boxComponentList[i]  as BoxComponent).topSprite.visible = false;
				(boxComponentList[i]  as BoxComponent).buttonSprite.visible = false;
				(boxComponentList[i]  as BoxComponent).buttonMode = true;
				(boxComponentList[i]  as BoxComponent).dyData=i;
				(boxComponentList[i]  as BoxComponent).addEventListener(MouseEvent.CLICK,boxComponent_clickHandler);
			}
			
			//翻页按钮
			turnLeftBtn = createUI(Button,"turnLeftBtn");
			turnRightBtn = createUI(Button,"turnRightBtn");
			turnLeftBtn.visible = false;
			turnRightBtn.visible  = false;
			
			shangSprite = createUI(Component,"shangSprite");
			checkBtnUP = shangSprite.createUI(Button,"checkBtnUP");
			mangeBtnUP = shangSprite.createUI(Button,"mangeBtnUP");
			attackBtnUP = shangSprite.createUI(Button,"attackBtnUP");
			shangSprite.sortChildIndex();
			
			xiaSprite = createUI(Component,"xiaSprite");
			checkBtnDown = xiaSprite.createUI(Button,"checkBtnDown");
			manageBtnDown = xiaSprite.createUI(Button,"manageBtnDown");
			attackBtnDown = xiaSprite.createUI(Button,"attackBtnDown");
			xiaSprite.sortChildIndex();
			
			maskSprite = getSkin("maskSprite");
			shangSprite.visible = false;
			xiaSprite.visible = false;
			
			sortChildIndex();
			
			cwList.push(BindingUtils.bindSetter(data,allViewProxy,"myFortsList"));
//			data(allViewProxy.myFortsList);
			if(IS_MINE)
			{
				attackBtnUP.visible=false;
				attackBtnDown.visible=false;
			}
			else
			{
				mangeBtnUP.visible=false;
				manageBtnDown.visible=false;				
			}
			
			closeBtn.addEventListener(MouseEvent.CLICK,closedBtn_clickHandler);
			//销毁sprite
			shangSprite.addEventListener(MouseEvent.CLICK,shangSprite_clickHandler);
			xiaSprite.addEventListener(MouseEvent.CLICK,xiaSprite_clickHandler);
			shangSprite.buttonMode = true;
			xiaSprite.buttonMode = true;
			checkBtnUP.addEventListener(MouseEvent.CLICK,checkBtn_clickHandler);
			mangeBtnUP.addEventListener(MouseEvent.CLICK,mangeBtn_clickHandler);
			attackBtnUP.addEventListener(MouseEvent.CLICK,attackBtn_clickHandler);
			
			checkBtnDown.addEventListener(MouseEvent.CLICK,checkBtn_clickHandler);
			manageBtnDown.addEventListener(MouseEvent.CLICK,mangeBtn_clickHandler);
			attackBtnDown.addEventListener(MouseEvent.CLICK,attackBtn_clickHandler);
			
			
        }
		
		private function boxComponent_clickHandler(event:MouseEvent):void
		{
			currentCount = (event.currentTarget as BoxComponent).dyData;
			currentSelected = (event.currentTarget as BoxComponent);
		}
		
		private function data(value:Array):void
		{
			var arr:Array=value;
			maxPage();
			startIndex();
			endIndex();
			//翻页处理
			buttonShow();
			//数据改变
			dataChange(arr);
		}
		
		private function buttonShow():void
		{
			if(_maxPage > 1 && _currentPageIndex <_maxPage)
			{
				turnRightBtn.visible = true;
				turnRightBtn.addEventListener(MouseEvent.CLICK,turnRightBtn_clickHandler);
			}
			else
			{
				turnRightBtn.visible = false;
				turnRightBtn.removeEventListener(MouseEvent.CLICK,turnRightBtn_clickHandler);
			}
			if(_maxPage>1 && _currentPageIndex > 1)
			{
				turnLeftBtn.visible = true;
				turnLeftBtn.addEventListener(MouseEvent.CLICK,turnLeftBtn_clickHandler);
			}
			else
			{
				turnLeftBtn.visible = false;
				turnLeftBtn.removeEventListener(MouseEvent.CLICK,turnLeftBtn_clickHandler);
			}
		}
		
		private function turnRightBtn_clickHandler(event:MouseEvent):void
		{
			_currentPageIndex++;
			data(allViewProxy.myFortsList);
		}
		
		private function turnLeftBtn_clickHandler(event:MouseEvent):void
		{
			_currentPageIndex--;
			data(allViewProxy.myFortsList);
		}
		
		private function dataChange(data:Array):void
		{
			_dataArray = data.slice(_startIndex,_endIndex);
			//数据处理
			setData(_dataArray);
		}
		
		private function setData(dataArr:Array):void
		{
			for(var j:int = 0;j<boxComponentList.length;j++)
			{
				(boxComponentList[j] as BoxComponent).visible = false;
				(boxComponentList[j] as BoxComponent).topSprite.visible = false;
				(boxComponentList[j] as BoxComponent).buttonSprite.visible = false;
				(boxComponentList[j] as BoxComponent).buttonMode = true;
				(boxComponentList[j] as BoxComponent).addEventListener(MouseEvent.CLICK,boxComponent_clickHandler);
			}
					
			for(var i:int = 0;i<dataArr.length;i++)
			{
				(boxComponentList[i] as BoxComponent).data = dataArr[i] as FortsInforVO;
				if((boxComponentList[i] as BoxComponent).data)
				{
					(boxComponentList[i] as BoxComponent).visible = true;
				}
				else
				{
					(boxComponentList[i] as BoxComponent).visible = false;
				}
			}
		}
		
		/**
		 *最大页数 
		 */
		private function maxPage():int
		{
			_maxPage = Math.ceil(allViewProxy.myFortsList.length/_pageCount);
			_maxPage = Math.max(1,_maxPage);
			return _maxPage;
		}
		
		private function startIndex():int
		{
			_startIndex = Math.max(0,(_currentPageIndex-1)*_pageCount);
			return _startIndex;
		}
		
		
		private function endIndex():int
		{
			_endIndex = Math.min(_currentPageIndex*_pageCount,allViewProxy.myFortsList.length);
			return _endIndex;
		}

		private function closedBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new AllViewEvent(AllViewEvent.CLOSED_XINGXING_EVENT));
		}

		public function get currentSelected():BoxComponent
		{
			return _currentSelected;
		}

		public function set currentSelected(value:BoxComponent):void
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
			if(currentCount<3)
			{
				currentSelected.buttonSprite.visible = true;
				xiaSprite.visible = true;
				xiaSprite.mask = maskSprite;
				TweenLite.to(xiaSprite,0.5,{x:0,y:currentSelected.y+currentSelected.height});
			}
			else
			{
				currentSelected.topSprite.visible = true;
//				currentSelected.data
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
		
		private function checkBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new AllViewXingXingEvent(AllViewXingXingEvent.CHECK_EVENT,_currentSelected.data));
		}
		
		private function mangeBtn_clickHandler(event:MouseEvent):void
		{
			
			dispatchEvent(new AllViewXingXingEvent(AllViewXingXingEvent.MANAGER_EVENT,_currentSelected.data));
		}
		
		private function attackBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new AllViewXingXingEvent(AllViewXingXingEvent.ATTACK_EVENT,_currentSelected.data));
		}

    }
}