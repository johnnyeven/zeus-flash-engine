package view.allView
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.ClassUtil;
	
	import enum.ResEnum;
	
	import events.allView.AllViewEvent;
	
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.allView.AllViewProxy;
	import proxy.content.ContentProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.components.VScrollBar;
	import ui.components.Window;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	import ui.layouts.VTileLayout;
	import ui.utils.DisposeUtil;
	
	/**
	 * 荣誉
	 * @author lw
	 * 
	 */	
    public class RongYuComponent extends Window
    {
		public var closedBtn:Button;
		
		public var medalImg:LoaderImage;
		public var numLabel:Label;
		
		private var _allViewProxy:AllViewProxy;
		
		private var _container:Container;
		private var _vScrollBar:VScrollBar;
		
        public function RongYuComponent()
        {
            super(ClassUtil.getObject("view.allView.RongYuSkin"));
			_allViewProxy=ApplicationFacade.getProxy(AllViewProxy);
			medalImg=createUI(LoaderImage,"medal_image");
			numLabel=createUI(Label,"num_tf");
			closedBtn = createUI(Button,"closedBtn");
			
			medalImg.source=getMedalImgStr(_allViewProxy.allViewVO.startCountTxt);
			if(_allViewProxy.allViewVO)
				numLabel.text="["+MultilanguageManager.getString("numOfYaoSai")+"×"+_allViewProxy.allViewVO.startCountTxt+"]";
			
			_container = new Container(null);
			addContainerValue();
			
			_vScrollBar = createUI(VScrollBar, "vScrollBar");
			_vScrollBar.viewport = _container;
			_vScrollBar.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			_vScrollBar.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			_vScrollBar.alpahaTweenlite(0);
			
			_vScrollBar.update();
			
			sortChildIndex();
			
			addChild(_vScrollBar);
			
			
			closedBtn.addEventListener(MouseEvent.CLICK,closedBtn_clickHandler);
			
        }
		
		private function removeAllItem():void
		{
			while (_container.num > 0)
				DisposeUtil.dispose(_container.removeAt(0));
		}
		
		private function addContainerValue():void
		{
			removeAllItem();
			_container.contentWidth = 342;
			_container.contentHeight = 225;
			_container.layout = new HTileLayout(_container);
			_container.x = 5;
			_container.y = 255;
			addChild(_container);
			_container.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			_container.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			
			var medalsArr:Array=_allViewProxy.medals;
			for(var i:int=0;i<medalsArr.length;i++)//medalsArr.length
			{
				var medalsBox:MedalsBoxComponent=new MedalsBoxComponent();
				if(medalsArr[i]!=null)
				{
					if(medalsArr[i].type!=3)
						medalsBox.setValue(getMedalsImgsSource(medalsArr[i].type,medalsArr[i].level),0);
					else
						medalsBox.setValue(getMedalsImgsSource(medalsArr[i].type,medalsArr[i].level),getNum(medalsArr[i].destroy_warship));//getMedalsImgsSource(medalsArr[i].type,medalsArr[i].level)
				}
				
				_container.add(medalsBox);
			}
			
			_container.layout.update();
		}
		
		private function getMedalImgStr(count:int):String
		{
			var str:String="";
			var type:int;
			var level:int;
			if(count<20)
			{
				str="";
			}
			if(count>=20 && count<100)
			{
				type=2;
				level=1;
				str=ResEnum.medalsImgURL+type+"_"+level+".png";				
			}
			if(count>=100 && count<200)
			{
				type=2;
				level=2;
				str=ResEnum.medalsImgURL+type+"_"+level+".png";
			}
			if(count>=200 && count<500)
			{
				type=2;
				level=3;
				str=ResEnum.medalsImgURL+type+"_"+level+".png";	
			}
			if(count>=500 && count<1000)
			{
				type=2;
				level=4;
				str=ResEnum.medalsImgURL+type+"_"+level+".png";	
			}
			if(count>=1000)
			{
				type=2;
				level=5;
				str=ResEnum.medalsImgURL+type+"_"+level+".png";
			}
			
			return str;
		}
		
		public function getMedalsImgsSource(type:int,level:int):String
		{
			var str:String=ResEnum.medalsImgURL+type+"_"+level+".png";
			return str;
		}
		
		private function getNum(count:Number):int
		{
			var num:int;
			num=count/10000;
			
			return num;
		}
		
		private function closedBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new AllViewEvent(AllViewEvent.CLOSED_RONGYU_EVENT));
		}
		
		protected function mouseOutHandler(event:MouseEvent):void
		{
			_vScrollBar.alpahaTweenlite(0);
		}
		
		protected function mouseOverHandler(event:MouseEvent):void
		{
			_vScrollBar.alpahaTweenlite(1);
		}
    }
}