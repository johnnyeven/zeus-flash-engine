package view.allView
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import ui.components.Label;
	import ui.core.Component;
	
	import vo.plantioid.FortsInforVO;
	
	public class BoxComponent extends Component
	{
		public var topSprite:Sprite;
		
		public var buttonSprite:Sprite;
		
		public var pointXText:Label;
		
		public var pointYText:Label;
		
		private var _data:FortsInforVO;
		
		public function BoxComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			
			topSprite = getSkin("topSprite");
			buttonSprite = getSkin("buttonSprite");
			pointXText = createUI(Label,"pointXText");
			pointYText = createUI(Label,"pointYText");
			
			sortChildIndex();
			
			pointXText.text = pointYText.text = "";
		}

		public function set data(myFortsInforVO:FortsInforVO):void
		{
			_data = myFortsInforVO;
			pointXText.text =  "X:"+myFortsInforVO.x +"";
			pointYText.text = "Y:"+myFortsInforVO.y +"";
		}
		
		public function get data():FortsInforVO
		{
			return _data;
		}
	}
}