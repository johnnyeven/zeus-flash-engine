package view.showBag
{
	import com.zn.utils.ClassUtil;
	
	import events.showBag.ShowBagEvent;
	
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.packageView.PackageViewProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.VScrollBar;
	import ui.components.Window;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	import ui.utils.DisposeUtil;
	
	import view.cangKu.CangKuGridComponent;
	
	/**
	 *展示武器界面
	 * @author lw
	 *
	 */
    public class ShowBagComponent extends Window
    {
		public var vScrollBar:VScrollBar; //拖动条
		
		public var closeBtn:Button; //关闭按钮
		
		public var gridComp:CangKuGridComponent; //格子
		
		private var container:Container;
		
        public function ShowBagComponent()
        {
            super(ClassUtil.getObject("view.showBag.ShowBagSkin"));
			var packageViewProxy:PackageViewProxy = ApplicationFacade.getProxy(PackageViewProxy);
			
			closeBtn = createUI(Button, "close_button");
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
			
			sortChildIndex();
			
			addChild(vScrollBar);
			removeCWList();
			cwList.push(BindingUtils.bindSetter(itemVOListChange, packageViewProxy, "itemVOList"));
			
			closeBtn.addEventListener(MouseEvent.CLICK,clickHandler);
        }
		
		protected function mouseOutHandler(event:MouseEvent):void
		{
			vScrollBar.alpahaTweenlite(0);
		}
		
		protected function mouseOverHandler(event:MouseEvent):void
		{
			vScrollBar.alpahaTweenlite(1);
		}
		
		private function removeAllItem():void
		{
			while (container.num > 0)
				DisposeUtil.dispose(container.removeAt(0));
		}
		
		public function itemVOListChange(value:Array):void
		{
			removeAllItem();
			
			for (var i:int = 0; i < value.length; i++)
			{
				gridComp = new CangKuGridComponent();
				if (value[i] != null)
				{
					gridComp.info = value[i];
					gridComp.addEventListener(MouseEvent.CLICK, grid_clickHandler);
				}
				gridComp.dyData = i;
				
				container.add(gridComp);
			}
			
			container.layout.update();
			
			vScrollBar.update();
		}
		
		private function grid_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new ShowBagEvent(ShowBagEvent.SHOW_DATA_EVENT,(event.currentTarget as CangKuGridComponent).info));
		}
		
		private function clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new ShowBagEvent(ShowBagEvent.CLOSE_EVENT,null));
		}

    }
}