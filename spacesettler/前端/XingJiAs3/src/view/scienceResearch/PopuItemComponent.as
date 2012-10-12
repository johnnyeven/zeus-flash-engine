package view.scienceResearch
{
	import com.zn.utils.ClassUtil;
	
	import events.scienceResearch.ScienceResearchEvent;
	
	import flash.events.MouseEvent;
	
	import proxy.BuildProxy;
	import proxy.scienceResearch.ScienceResearchProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.Window;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	import ui.utils.DisposeUtil;
	
	import vo.scienceResearch.PopuItemVO;
	import vo.scienceResearch.ScienceResearchVO;
	
	/**
	 *科研弹出框
	 * @author lw
	 *
	 */
    public class PopuItemComponent extends Window
    {
		public var closeBtn:Button;
		
		private var container:Container;
		private var scienceResearchProxy:ScienceResearchProxy;
		private var buildProxy:BuildProxy;
		
        public function PopuItemComponent()
        {
            super(ClassUtil.getObject("view.scienceResearch.PopuItemSkin"));
			
			scienceResearchProxy = ApplicationFacade.getProxy(ScienceResearchProxy);
			buildProxy = ApplicationFacade.getProxy(BuildProxy);
			
			closeBtn = createUI(Button,"closeBtn");
			
			sortChildIndex();
			
			container = new Container(null);
			container.contentWidth = 285;
			container.contentHeight =200;
			container.layout = new HTileLayout(container);
			container.x = 15;
			container.y = 43;
			addChild(container);
			
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtn_clickHAndler);
        }
		
		public function data(scienceResearchVO:ScienceResearchVO):void
		{
			while(container.num)
				DisposeUtil.dispose(container.removeAt(0));
			var arr:Array = [];
			var popuItemVO:PopuItemVO;
			if(scienceResearchVO.command_center_level >buildProxy.getBuild(1).level)
			{
				popuItemVO = new PopuItemVO();
				popuItemVO.type = 1;
				popuItemVO.currentLevel = buildProxy.getBuild(1).level;
				popuItemVO.needCondition = scienceResearchVO.command_center_level;
				arr.push(popuItemVO);
			}
			if(scienceResearchVO.academy_level >buildProxy.getBuild(3).level)
			{
				popuItemVO = new PopuItemVO();
				popuItemVO.type = 3;
				popuItemVO.currentLevel = buildProxy.getBuild(3).level;
				popuItemVO.needCondition = scienceResearchVO.academy_level;
				arr.push(popuItemVO);
			}
			
			var itemPopu:ItemPopu;
			for(var i:int = 0;i<arr.length;i++)
			{
				itemPopu = new ItemPopu();
				itemPopu.data = arr[i] as PopuItemVO;
				container.add(itemPopu);
			}
			container.layout.update();
		}
		
		private function closeBtn_clickHAndler(event:MouseEvent):void
		{
			dispatchEvent(new ScienceResearchEvent(ScienceResearchEvent.POPU_CLOSE_EVENT,0));
		}
    }
}