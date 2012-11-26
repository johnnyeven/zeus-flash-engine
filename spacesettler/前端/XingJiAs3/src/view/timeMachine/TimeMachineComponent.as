package view.timeMachine
{
	import com.zn.utils.ClassUtil;
	
	import events.timeMachine.TimeMachineEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.timeMachine.TimeMachineProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.Label;
	import ui.components.VScrollBar;
	import ui.components.Window;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	import ui.utils.DisposeUtil;
	
	import vo.timeMachine.TimeMachineVO;
	
	/**
	 *时间机器
	 * @author lw
	 *
	 */
    public class TimeMachineComponent extends Window
    {
		public var totalCrystalCountTxt:Label;
		
		public var allSpeedBtn:Button;
		
		public var closeBtn:Button;
		
		public var timeMachineInforBtn:Button;
		
		public var noItemLabel:Label;
		
		private var container:Container;
		public var vscrollBar:VScrollBar;
		
		private var totalCrystal:int;
//		private var itemArr:Array=[];
		private var isNumOne:Boolean=true;
//		private var notClearArr:Array;
		private var num:int;
        public function TimeMachineComponent()
        {
            super(ClassUtil.getObject("view.timeMachine.TimeMachine"));
			var timeMachineProxy:TimeMachineProxy = ApplicationFacade.getProxy(TimeMachineProxy);
			
			totalCrystalCountTxt = createUI(Label,"totalCrystalCountTxt");
			noItemLabel = createUI(Label,"noLabel");
			allSpeedBtn = createUI(Button,"allSpeedBtn");
			closeBtn = createUI(Button,"closeBtn");
			timeMachineInforBtn = createUI(Button,"timeMachineInforBtn");
			vscrollBar = createUI(VScrollBar,"vscrollBar");
			sortChildIndex();
			noItemLabel.visible=false;
			mouseChildren = mouseEnabled = true;
			totalCrystalCountTxt.text = "";
			
			
			removeCWList();
			
			var userInforProxy:UserInfoProxy = ApplicationFacade.getProxy(UserInfoProxy);
//			cwList.push(BindingUtils.bindProperty(totalCrystalCountTxt,"text",userInforProxy,["userInfoVO","dark_crystal"]));
			cwList.push(BindingUtils.bindSetter(totalCrystalCountTxtChange,userInforProxy,["userInfoVO","dark_crystal"]));
			container = new Container(null);
			container.contentWidth = 330;
			container.contentHeight =370;
			container.layout = new HTileLayout(container);
			container.x = 4;
			container.y = 100;
			addChild(container);
			
			removeCWList();
//			cwList.push(BindingUtils.bindSetter(setData,timeMachineProxy,"timeMachineList"));
			cwList.push(BindingUtils.bindSetter(dataChange,timeMachineProxy,"timeMachineList"));
//			setData(timeMachineProxy.timeMachineList);
			allSpeedBtn.addEventListener(MouseEvent.CLICK,allSpeedBtn_clickHandler);
			closeBtn.addEventListener(MouseEvent.CLICK,closedBtn_clickHandler);
			timeMachineInforBtn.addEventListener(MouseEvent.CLICK,timeMachineInforBtn_clickHAndler);
			
        }
		
		private function dataChange(value:*):void
		{
			setData(value as Array);
		}
		
		private function clearCantainer():void
		{
			while(container.num>0)
				DisposeUtil.dispose(container.removeAt(0));
		}
		
		private function totalCrystalCountTxtChange(value:*):void
		{
			totalCrystalCountTxt.text = value;
		}
		
		private function setData(arr:Array):void
		{
			totalCrystal=0;
			num=arr.length;
			if(arr.length <= 0)
			{
				clearCantainer();
				allSpeedBtn.mouseEnabled = false;
				noItemLabel.visible=true;
			}
			else
			{
				allSpeedBtn.mouseEnabled = true;
			}
			if(arr.length>0)
			{
//				totalCrystal = (arr[arr.length-1] as TimeMachineVO).totalCrystal;
				for(var n:int=0;n<arr.length;n++)
				{
					totalCrystal+=(arr[n] as TimeMachineVO).totalCrystal;
				}
			}
			
			
			
			var newArr:Array = [];
			var timeMachineVO:TimeMachineVO;
			for each(timeMachineVO in arr)
			{
				if(timeMachineVO.remainTime >=10000)
				{
					newArr.push(timeMachineVO);
				}
			}
			if(isNumOne)
			{
				isNumOne=false;
				while(container.num)
					DisposeUtil.dispose(container.removeAt(0));
				var timeMachineItem:TimeMachineItem;
				for(var i:int =0;i<newArr.length;i++)
				{
					timeMachineItem = new TimeMachineItem();
					timeMachineItem.data = newArr[i] as TimeMachineVO;
					timeMachineItem.addEventListener(MouseEvent.CLICK,speedClickHandler);
					container.add(timeMachineItem);
				}
			}	
			container.layout.update();
			vscrollBar.viewport = container;
		}
		
		private function speedClickHandler(event:MouseEvent):void
		{
			var item:TimeMachineItem=(event.currentTarget) as TimeMachineItem
			var count:int = item.data.crystalCount;
			dispatchEvent(new TimeMachineEvent(TimeMachineEvent.SPEED_EVENT,item.data.building_type,count,true,true,item));
		}
		
		public function clearContainer(obj:DisplayObjectContainer,money:int):void
		{
			DisposeUtil.dispose(obj);
			container.layout.update();
			vscrollBar.viewport = container;
		}
		
		private function allSpeedBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new TimeMachineEvent(TimeMachineEvent.ALL_SPEED_EVENT,container.num,totalCrystal));
		}
		
		private function closedBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new TimeMachineEvent(TimeMachineEvent.CLOSE_EVENT,0,0));
		}
		
		private function timeMachineInforBtn_clickHAndler(event:MouseEvent):void
		{
			dispatchEvent(new TimeMachineEvent(TimeMachineEvent.SHOW_INFOR_COMPONENT_EVENT,0,0));
		}
    }
}