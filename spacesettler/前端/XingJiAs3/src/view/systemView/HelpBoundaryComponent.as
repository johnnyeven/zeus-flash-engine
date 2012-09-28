package view.systemView
{
	import com.zn.utils.ClassUtil;
	
	import events.system.SystemEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.VScrollBar;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	
    public class HelpBoundaryComponent extends Component
    {	
		/**
		 *返回按钮 
		 */		
		public var fanHuiBtn:Button;
		
		/**
		 *容器 
		 */		
		public var sprite:Sprite;
		
		/**
		 *拖動條 
		 */		
		public var vsBar:VScrollBar;
		
		private var container:Container;
        public function HelpBoundaryComponent()
        {
            super(ClassUtil.getObject("view.systemView.HelpBoundarySkin"));
			
			fanHuiBtn=createUI(Button,"fanhui_btn");
			vsBar=createUI(VScrollBar,"vs_bar");
			
			sprite=getSkin("sprite");	
			sortChildIndex();
			
			container=new Container(null);
			container.x=0;
			container.y=0;
			container.contentWidth=322;
			container.contentHeight=465;
			sprite.addChild(container);
			
			container.add(ClassUtil.getObject("helpWord"));
			
			vsBar.viewport=container;
			fanHuiBtn.addEventListener(MouseEvent.CLICK,doCloseHandler);
			vsBar.addEventListener(MouseEvent.ROLL_OVER,mouseOverHandler);
			vsBar.addEventListener(MouseEvent.ROLL_OUT,mouseOutHandler);
			container.addEventListener(MouseEvent.ROLL_OVER,mouseOverHandler);
			container.addEventListener(MouseEvent.ROLL_OUT,mouseOutHandler);
        }
		
		protected function mouseOutHandler(event:MouseEvent):void
		{
			vsBar.alpahaTweenlite(0);
		}
		
		protected function mouseOverHandler(event:MouseEvent):void
		{
			vsBar.alpahaTweenlite(1);
		}
		
		protected function doCloseHandler(event:MouseEvent):void
		{
			dispatchEvent(new SystemEvent(SystemEvent.CLOSE));
		}
	}
}