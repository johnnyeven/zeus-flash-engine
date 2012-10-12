package view.shangCheng.shangChengView
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	
	public class TuZhiComponent extends Component
	{
		/**
		 * 图纸标题
		 */
		public var titleText:Label;
		
		/**
		 *需要多少水晶币的text 
		 */		
		public var moneyText:Label;
		
		/**
		 * 兑换按钮
		 */		
		public var exchangeBtn:Button;
		
		/**
		 * 赠送按钮
		 */		
		public var giveBtn:Button;
		public function TuZhiComponent()
		{
			super(ClassUtil.getObject("view.allView.TuZhiSkin"));
			
			exchangeBtn=createUI(Button,"exchange_btn");
			giveBtn=createUI(Button,"give_btn");
			
			moneyText=createUI(Label,"money_tf");
			titleText=createUI(Label,"title_tf");
			
			sortChildIndex();
		}
		
		
	}
}