package view.scienceResearch
{
	import com.zn.utils.ClassUtil;
	
	import enum.BuildTypeEnum;
	import enum.science.ScienceEnum;
	
	import events.scienceResearch.ScienceResearchEvent;
	
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.components.Window;
	import ui.core.Component;
	
	/**
	 *科技描述 
	 * @author lw
	 * 
	 */	
    public class InforComponent extends Window
    {
		
		private var _scienceType:int;
		
		public var scienceNameLabel:Label;
		
		public var inforLabel:Label;
		
		public var closeBtn:Button;
		
        public function InforComponent()
        {
            super(ClassUtil.getObject("view.scienceResearch.InforSkin"));
			
			scienceNameLabel = createUI(Label,"scienceNameLabel");
			inforLabel = createUI(Label,"inforLabel");
			closeBtn = createUI(Button,"closeBtn");
			
			sortChildIndex();
			
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtn_clickHAndler);
        }
		
		public function get scienceType():int
		{
			return _scienceType;
		}

		public function set scienceType(value:int):void
		{
			_scienceType = value;
			scienceNameLabel.text = ScienceEnum.getResearchNameByResearchType(_scienceType);
			inforLabel.text = ScienceEnum.getInforByResearchType(_scienceType);
		}
		
		protected function closeBtn_clickHAndler(event:MouseEvent):void
		{
			dispatchEvent(new ScienceResearchEvent(ScienceResearchEvent.CLOSE_INFOR_EVENT,0));
		}

    }
}