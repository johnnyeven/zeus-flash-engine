package view.systemView
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.URLFunc;
	
	import events.system.SystemEvent;
	
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.core.Component;
	
    public class SystemComponent extends Component
    {
		/**
		 *1官方网站按钮 
		 */		
		public var officialBtn:Button;
		
		/**
		 * 2选项按钮
		 */		
		public var optionBtn:Button;
		
		/**
		 * 3帮助按钮
		 */		
		public var helpBtn:Button;
		
		/**
		 *4 我的账号按钮
		 */		
		public var accountNumberBtn:Button;
		
		/**
		 *5 登出按钮
		 */		
		public var logOutBtn:Button;
		
		/**
		 *6 攻略按钮
		 */		
		public var strategyBtn:Button;
		
		/**
		 *7关闭按钮 
		 */		
		public var closeBtn:Button

		
        public function SystemComponent()
        {
            super(ClassUtil.getObject("view.systemView.systemSkin"));
			
			officialBtn=createUI(Button,"guanfang_btn");
			optionBtn=createUI(Button,"xuanxiang_btn");
			helpBtn=createUI(Button,"bangzhu_btn");
			accountNumberBtn=createUI(Button,"zhanghao_btn");
			logOutBtn=createUI(Button,"dengchu_btn");
			strategyBtn=createUI(Button,"gonglue_btn");
			closeBtn=createUI(Button,"close_btn");
			
			//URLFunc.openHTML(传人要链接的地址）
			
			officialBtn.addEventListener(MouseEvent.CLICK,officialBtn_clickHandler);
			optionBtn.addEventListener(MouseEvent.CLICK,optionBtn_clickHandler);
			helpBtn.addEventListener(MouseEvent.CLICK,helpBtn_clickHandler);
			accountNumberBtn.addEventListener(MouseEvent.CLICK,accountNumberBtn_clickHandler);
			logOutBtn.addEventListener(MouseEvent.CLICK,logOutBtn_clickHandler);
			strategyBtn.addEventListener(MouseEvent.CLICK,strategyBtn_clickHandler);
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtn_clickHandler);
			sortChildIndex();
        }
		
		protected function officialBtn_clickHandler(event:MouseEvent):void
		{
			URLFunc.openHTML("");
			//TODO :GX
		}
		
		protected function optionBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new SystemEvent(SystemEvent.SHOW_OPTIONBOUNDARY));
			
		}
		
		protected function helpBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new SystemEvent(SystemEvent.SHOW_HELPBOUNDARY));
			
		}
		
		protected function accountNumberBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new SystemEvent(SystemEvent.SHOW_ACCOUNTNUMBERBOUNDARY));
			
		}
		
		protected function logOutBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new SystemEvent(SystemEvent.LOGIN_OUT));			
		}
		
		protected function strategyBtn_clickHandler(event:MouseEvent):void
		{
			URLFunc.openHTML("");
			//TODO :GX
		}
		
		protected function closeBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new SystemEvent(SystemEvent.CLOSE_ALL));
		}
	}
}