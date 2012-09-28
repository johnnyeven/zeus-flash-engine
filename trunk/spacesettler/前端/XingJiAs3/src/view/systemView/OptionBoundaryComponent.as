package view.systemView
{
	import com.zn.utils.ClassUtil;
	
	import events.system.SystemEvent;
	
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.CheckBox;
	import ui.core.Component;
	
    public class OptionBoundaryComponent extends Component
    {
		/**
		 *返回按钮 
		 */		
		public var fanHuiBtn:Button;
			
		/**
		 *音乐开关 
		 */		
		public var checkBox1:CheckBox;
		
		/**
		 *音效开关 
		 */		
		public var checkBox2:CheckBox;

		private var _ischeck1:Boolean=true;//确定是否有音乐 为真则音乐开着的
		private var _ischeck2:Boolean=true;//确定是否有音效 为真则音效开着的
        public function OptionBoundaryComponent()
        {
            super(ClassUtil.getObject("view.systemView.OptionBoundarySkin"));
			
			fanHuiBtn=createUI(Button,"fanhui_btn");
			checkBox1=createUI(CheckBox,"checkbox_1");
			checkBox2=createUI(CheckBox,"checkbox_2");
			
			checkBox1.selected=_ischeck1;
			checkBox2.selected=_ischeck2;
			
			sortChildIndex();
			
			fanHuiBtn.addEventListener(MouseEvent.CLICK,doCloseHandler);
			checkBox1.addEventListener(MouseEvent.CLICK,checkBox1_clickHandler);
			checkBox2.addEventListener(MouseEvent.CLICK,checkBox2_clickHandler);
			
        }
		
		protected function checkBox1_clickHandler(event:MouseEvent):void
		{
			if(_ischeck1)
			{
				//TODO :GX关闭音乐
			}else
			{
				//TODO :GX打开音乐
			}
			_ischeck1=!_ischeck1;
			checkBox1.selected=_ischeck1;
		}
		
		protected function checkBox2_clickHandler(event:MouseEvent):void
		{
			if(_ischeck2)
			{
				//TODO :GX关闭音效
			}else
			{
				//TODO :GX打开音效	
			}
			_ischeck2=!_ischeck2;
			checkBox2.selected=_ischeck2;
		}
		
		protected function doCloseHandler(event:MouseEvent):void
		{
			dispatchEvent(new SystemEvent(SystemEvent.CLOSE));
		}
    }
}