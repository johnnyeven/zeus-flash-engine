package view.allView.shangChengView
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	
	import ui.components.Button;
	import ui.core.Component;
	
	public class TuZhiComponent extends Component
	{
		/**
		 * 图纸标题
		 */
		public var titleText:TextField;
		
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
		public function TuZhiComponent()
		{
			super(ClassUtil.getObject("view.allView.TuZhiSkin"));
			
			exchangeBtn=createUI(Button,"exchange_btn");
			giveBtn=createUI(Button,"give_btn");
			
			moneyText=getSkin("money_tf");
			titleText=getSkin("title_tf");
			
			sortChildIndex();
		}
		
		
	}
}