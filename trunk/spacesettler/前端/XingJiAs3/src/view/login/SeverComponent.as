package view.login
{
	import com.greensock.TweenLite;
	import com.zn.utils.StringUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import proxy.login.LoginProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.components.TextInput;
	import ui.core.Component;
	
	import vo.ServerItemVO;
	
	/**
	 *服务器列表
	 * @author lw
	 */
	public class SeverComponent extends Component
	{
		private var loginProxy:LoginProxy;
		
		/**
		 *服务器列表条
		 */	
		public var serverBar:Component;
		
		public var barServerName:Label;
		
		/**
		 *选择服务器列表块
		 */
		public var listComponent:Component;
		/**
		 *服务器信息条
		 */
		public var bar_0:BarComponent;
		public var bar_1:BarComponent;
		public var bar_2:BarComponent;
		public var bar_3:BarComponent;
		private var barList:Array = [];
		private var serverBG:Component;
		
		private var turnLeftBtn:Button;
		private var turnRightBtn:Button;
		
		private var isShow:Boolean = false;
		private var _mask:Sprite;
		
		/**
		 *每页数量 
		 */		
		private var _pageCount:int = 4;
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
		
		public function SeverComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			
			loginProxy = ApplicationFacade.getProxy(LoginProxy);
			
			serverBar = createUI(Component,"serverBar");
			sortChildIndex();
			serverBar.buttonMode = true;
			barServerName = serverBar.createUI(Label,"serverName");
			if(LoginProxy.selectedServerVO)
			{
			   barServerName.text = LoginProxy.selectedServerVO.server_name+"("+LoginProxy.selectedServerVO.server_language+",ID:"+LoginProxy.selectedServerVO.account_server_id+")";
			}
			
			listComponent = createUI(Component,"list");

			serverBG = listComponent.createUI(Component,"serverBG");
			//翻页按钮
			turnLeftBtn = listComponent.createUI(Button,"turnLeftBtn");
			turnRightBtn = listComponent.createUI(Button,"turnRightBtn");
			turnLeftBtn.visible = false;
			turnRightBtn.visible = false;
			
			bar_0 = listComponent.createUI(BarComponent,"bar_0");
			bar_1 = listComponent.createUI(BarComponent,"bar_1");
			bar_2 = listComponent.createUI(BarComponent,"bar_2");
			bar_3 = listComponent.createUI(BarComponent,"bar_3");
			listComponent.sortChildIndex();
			barList.push(bar_0,bar_1,bar_2,bar_3);
			for(var i:int = 0;i<barList.length;i++)
			{
				(barList[i] as BarComponent).visible = false;
				(barList[i] as BarComponent).buttonMode = true;
				(barList[i] as BarComponent).addEventListener(MouseEvent.CLICK,barComponent_clickHandler);
			}
			
			data(loginProxy.serverVOList);
			
			//服务器列表的遮罩
			_mask = new Sprite();
			_mask.graphics.beginFill(0,1);
			_mask.graphics.drawRect(0,0,640,231);
			_mask.graphics.endFill();
			_mask.x = 213;
			_mask.y = 64;
			addChild(_mask);
			listComponent.mask = _mask;
			
			serverBar.addEventListener(MouseEvent.CLICK,serverBar_clickHandler);
			
		}
		
		private function serverBar_clickHandler(event:MouseEvent):void
		{
			if(isShow)
			{

				isShow = false;
				TweenLite.to(listComponent,1,{y:-170});
			}
			else
			{

				isShow = true;
				TweenLite.to(listComponent,0.5,{y:64});
			}
		}
		
		private function data(arr:Array):void
		{
			//翻页处理
			buttonShow();
			//数据改变
			dataChange(arr);
		}
		
		private function barComponent_clickHandler(event:MouseEvent):void
		{
			var data:ServerItemVO = (event.target as BarComponent).data;
			if(data)
			{
				barServerName.text = data.server_name +"("+data.server_language+",ID:"+data.account_server_id+")"; 
			}
			if(isShow)
			{
				isShow = false;
				TweenLite.to(listComponent,1,{y:-170});
			}
			
//			(event.target as BarComponent).removeEventListener(MouseEvent.CLICK,barComponent_clickHandler);
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
			dataChange(loginProxy.serverVOList);
		}
		
		private function turnLeftBtn_clickHandler(event:MouseEvent):void
		{
			_currentPageIndex--;
			dataChange(loginProxy.serverVOList);
		}
		
		private function dataChange(data:Array):void
		{
			_dataArray = data.slice(startIndex,endIndex);
			//数据处理
			setData(_dataArray);
		}
		
		private function setData(dataArr:Array):void
		{
			for(var j:int = 0;j<barList.length;j++)
			{
				(barList[i] as BarComponent).visible = false;
				(barList[i] as BarComponent).buttonMode = true;
				(barList[i] as BarComponent).addEventListener(MouseEvent.CLICK,barComponent_clickHandler);
			}
			
			if(dataArr.length < 4)
			{
				serverBG.height = dataArr.length*58;
			}			
			for(var i:int = 0;i<dataArr.length;i++)
			{
				(barList[i] as BarComponent).data = dataArr[i] as ServerItemVO;
				if((barList[i] as BarComponent).data)
				{
					(barList[i] as BarComponent).visible = true;
				}
				else
				{
					(barList[i] as BarComponent).visible = false;
				}
			}
		}

		/**
		 *最大页数 
		 */
		public function get maxPage():int
		{
			_maxPage = Math.ceil(loginProxy.serverVOList.length/_pageCount);
			_maxPage = Math.max(1,_maxPage);
			return _maxPage;
		}

		public function get startIndex():int
		{
			_startIndex = Math.max(0,(_currentPageIndex-1)*_pageCount);
			return _startIndex;
		}

		public function get endIndex():int
		{
			_endIndex = Math.min(_currentPageIndex*_pageCount,loginProxy.serverVOList.length);
			return _endIndex;
		}


	}
}