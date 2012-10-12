package view.scienceResearch
{
	import com.zn.utils.ClassUtil;
	
	import events.scienceResearch.ScienceResearchEvent;
	
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.scienceResearch.ScienceResearchProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.VScrollBar;
	import ui.components.Window;
	import ui.core.Component;
	import ui.layouts.HTileLayout;
	import ui.utils.DisposeUtil;
	
	import vo.scienceResearch.ScienceResearchVO;
	
	/**
	 *科研
	 * @author lw
	 *
	 */
    public class ScienceResearchComponent extends Window
    {
		public var closeBtn:Button;
		
		private var container:Container;
		public var vScrollBar:VScrollBar;
		
		private var scienceResearchProxy:ScienceResearchProxy;
		
        public function ScienceResearchComponent()
        {
            super(ClassUtil.getObject("view.scienceResearch.ScienceResearchSkin"));
			
			scienceResearchProxy = ApplicationFacade.getProxy(ScienceResearchProxy);
			
			closeBtn = createUI(Button,"closeBtn");
			vScrollBar = createUI(VScrollBar,"vScrollBar");
			sortChildIndex();
			
			container = new Container(null);
			container.contentWidth = 330;
			container.contentHeight =400;
			container.layout = new HTileLayout(container);
			container.x = 3;
			container.y = 57;
			addChild(container);
			
			removeCWList();
			cwList.push(BindingUtils.bindSetter(function():void
			{
				setData(scienceResearchProxy.reaearchList);
			},scienceResearchProxy,"reaearchList"));
			
			
			
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtn_clickHAndler);
        }
		
		private function setData(arr:Array):void
		{
			while(container.num)
				DisposeUtil.dispose(container.removeAt(0));
			
			var scienceResearchItem:ScienceResearchItem;
			for(var i:int =0;i<arr.length;i++)
			{
				scienceResearchItem = new ScienceResearchItem();
				scienceResearchItem.data = arr[i] as ScienceResearchVO;
				container.add(scienceResearchItem);
			}
			container.layout.update();
			vScrollBar.viewport = container;
		}
		
		protected function closeBtn_clickHAndler(event:MouseEvent):void
		{
		  dispatchEvent(new ScienceResearchEvent(ScienceResearchEvent.CLOSE_EVENT,0));
		}
	}
}