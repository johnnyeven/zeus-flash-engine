package view.scienceResearch
{
	import com.zn.utils.ClassUtil;
	
	import enum.BuildTypeEnum;
	
	import events.scienceResearch.ScienceResearchEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.core.Component;
	
	import vo.scienceResearch.PopuItemVO;
	import vo.scienceResearch.ScienceResearchVO;
	
	public class ItemPopu extends Component
	{
		public var nameImage:LoaderImage;
		public var needLabel:Label;
		public var upBtn:Button;
		
		private var _data:PopuItemVO;
		
		public function ItemPopu()
		{
			super(ClassUtil.getObject("view.scienceResearch.PopuItem"));
			
			nameImage = createUI(LoaderImage,"nameImage");
			needLabel = createUI(Label,"needLabel");
			upBtn = createUI(Button,"upBtn");
			
			sortChildIndex();
			
			upBtn.addEventListener(MouseEvent.CLICK,upBtn_clickHandler);
		}

		public function get data():PopuItemVO
		{
			return _data;
		}

		public function set data(value:PopuItemVO):void
		{
			_data = value;
			
			if(value.type == 1)
			{
				nameImage.source = BuildTypeEnum.getSmallImageByBuildType(value.type);
				needLabel.text = "基地中心:"+_data.currentLevel+"/"+_data.needCondition+"";
			}
			else if(value.type == 3)
			{
				nameImage.source = BuildTypeEnum.getSmallImageByBuildType(value.type);
				needLabel.text = "科技中心:"+_data.currentLevel+"/"+_data.needCondition+"";
			}

		}
		
		private function upBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new ScienceResearchEvent(ScienceResearchEvent.POPU_UP_EVENT,data.type,true,true));
		}

	}
}