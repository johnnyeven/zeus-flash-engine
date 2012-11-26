package view.mainView
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	
	import ui.components.Label;
	import ui.core.Component;

	/**
	 * 私聊消息数目提示
	 * @author lw
	 * 
	 */	
	public class PrivateChatCountTipsComponent extends Component
	{
		public var privateCountSprivate1:Component;
		public var sprivate1Label:Label;
//		public var privateCountSprivate2:Component;
//		public var sprivate2Label:Label;
		
		private var _privateCount:int;
		public function PrivateChatCountTipsComponent()
		{
			super(ClassUtil.getObject("mainView.chat.PrivateChatTipsSkin"));
			privateCountSprivate1 = createUI(Component,"privateCountSprivate1");
			sprivate1Label = privateCountSprivate1.createUI(Label,"privateCountLabel1");
			privateCountSprivate1.sortChildIndex();
			
//			privateCountSprivate2 = createUI(Component,"privateCountSprivate2");
//			sprivate2Label = privateCountSprivate2.createUI(Label,"privateCountLabel1");
//			privateCountSprivate2.sortChildIndex();
			sortChildIndex();
			
		}
		
		

		public function get privateCount():int
		{
			return _privateCount;
		}

		public function set privateCount(value:int):void
		{
			_privateCount = value;
			
			sprivate1Label.text = _privateCount +"";
		}

	}
}