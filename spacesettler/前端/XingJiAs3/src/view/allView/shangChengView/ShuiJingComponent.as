package view.allView.shangChengView
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	
	import ui.components.Button;
	import ui.core.Component;
	
	public class ShuiJingComponent extends Component
	{
		
		/**
		 *需要多少水晶币的text 
		 */		
		public var moneyText:TextField;
		
		/**
		 * 兑换按钮
		 */		
		public var exchangeBtn:Button;
		
		/**
		 * 赠送按钮
		 */		
		public var giveBtn:Button;
		
		public function ShuiJingComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			
			moneyText=getSkin("num_tf");
			exchangeBtn=createUI(Button,"exchange_btn");
			giveBtn=createUI(Button,"give_btn");
			
			sortChildIndex();
		}
		
		public function set money(text:String):void
		{
			moneyText.text=text;
		}
	}
}