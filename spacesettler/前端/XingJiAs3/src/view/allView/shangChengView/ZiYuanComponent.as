package view.allView.shangChengView
{
	import com.zn.utils.ClassUtil;
	
	import events.allView.ShopEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import ui.components.Button;
	import ui.components.TextInput;
	import ui.core.Component;
	
	public class ZiYuanComponent extends Component
	{
		/**
		 *氚气的兑换输入框 
		 */		
		public var chuanQiText:TextField;
		
		/**
		 * 水晶的兑换输入框 
		 */		
		public var shuiJingText:TextField;
		
		/**
		 * 暗物质的兑换输入框 
		 */		
		public var anWuZhiText:TextField;
		
		/**
		 *氚气兑换确认按钮 
		 */		
		public var chuanQiBtn:Button;
		
		/**
		 * 水晶兑换确认按钮 
		 */		
		public var shuiJingBtn:Button;
		
		/**
		 * 暗物质兑换确认按钮 
		 */		
		public var anWuZhiBtn:Button;
		
		public function ZiYuanComponent()
		{
			super(ClassUtil.getObject("view.allView.ZiYuanSkin"));
			
			chuanQiText=getSkin("chuanqi_tf");
			shuiJingText=getSkin("shuijing_tf");
			anWuZhiText=getSkin("anwuzhi_tf");
			
			chuanQiText.mouseEnabled=true;
			shuiJingText.mouseEnabled=true;
			anWuZhiText.mouseEnabled=true;
			
			chuanQiBtn=createUI(Button,"chuanqi_btn");
			shuiJingBtn=createUI(Button,"shuijing_btn");
			anWuZhiBtn=createUI(Button,"anwuzhi_btn");
			
			sortChildIndex();
			
			chuanQiBtn.addEventListener(MouseEvent.CLICK,chuanQi_ClickHandler);
			shuiJingBtn.addEventListener(MouseEvent.CLICK,shuiJing_ClickHandler);
			anWuZhiBtn.addEventListener(MouseEvent.CLICK,anWuZhi_ClickHandler);
		}
		
		protected function shuiJing_ClickHandler(event:MouseEvent):void
		{
			if(int(shuiJingText.text)>0)
			{
				dispatchEvent(new ShopEvent(ShopEvent.BUY_RESOURCE,true,false,int(shuiJingText.text),"crystal"));
			}
		}
		
		protected function anWuZhi_ClickHandler(event:MouseEvent):void
		{
			if(int(anWuZhiText.text)>0)
			{
				dispatchEvent(new ShopEvent(ShopEvent.BUY_RESOURCE,true,false,int(anWuZhiText.text),"broken_crystal"));
			}
		}
		
		protected function chuanQi_ClickHandler(event:MouseEvent):void
		{
			if(int(chuanQiText.text)>0)
			{
				dispatchEvent(new ShopEvent(ShopEvent.BUY_RESOURCE,true,false,int(chuanQiText.text),"tritium"));
			}
		}
	}
}