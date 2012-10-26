package view.email
{
	import com.zn.utils.ClassUtil;
	
	import enum.email.EmailTypeEnum;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.core.Component;
	
	import vo.email.SourceItemVO;
	
	public class SourceItem extends Component
	{
		public var noSelectedBtn:Button;
		public var selectedBtn:Button;
		public var sourceImage:LoaderImage;
		public var sourceCountLabel:Label;
		
		
		private var _data:SourceItemVO;
		public function SourceItem()
		{
			super(ClassUtil.getObject("view.email.SourceItemSkin"));
			
			noSelectedBtn = createUI(Button,"noSelectedBtn");
			selectedBtn = createUI(Button,"selectedBtn");
			sourceImage = createUI(LoaderImage,"sourceImage");
			sourceCountLabel = createUI(Label,"sourceCountLabel");
			sortChildIndex();
			
			noSelectedBtn.visible = true;
			selectedBtn.visible = false;
//			noSelectedBtn.addEventListener(MouseEvent.CLICK,noSelectedBtn_clickHAndler);
		}

		public function get data():SourceItemVO
		{
			return _data;
		}

		public function set data(value:SourceItemVO):void
		{
			_data = value;
			if(_data)
			{
				sourceImage.source = EmailTypeEnum.getSourceImageByEmailType(_data.attachment_type);
				sourceCountLabel.text = _data.mySourceCount +"";
			}
		}
		
		private function noSelectedBtn_clickHAndler(event:MouseEvent):void
		{
			noSelectedBtn.visible = false;
			selectedBtn
		}

	}
}