package view.scienceResearch
{
	import com.zn.utils.ClassUtil;
	
	import events.scienceResearch.ScienceResearchEvent;
	
	import flash.events.MouseEvent;
	import flash.utils.clearInterval;
	
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
		
		private var itemArr:Array=[];
		private var length:int=0;
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
			if(length!=arr.length)
			{
				length=arr.length;
				while(container.num)
					DisposeUtil.dispose(container.removeAt(0));
				var scienceResearchItem:ScienceResearchItem;
				for(var i:int =0;i<arr.length;i++)
				{
					scienceResearchItem = new ScienceResearchItem();
					scienceResearchItem.data = arr[i] as ScienceResearchVO;
					container.add(scienceResearchItem);
					itemArr[i]=scienceResearchItem;
				}
				container.layout.update();
				vScrollBar.viewport = container;
			}else
			{
				for(var j:int=0;j<length;j++)
				{
					var itemVo:ScienceResearchVO=arr[j] as ScienceResearchVO;
					for(var k:int=0;k<length;k++)
					{
						var item:ScienceResearchItem=itemArr[k] as ScienceResearchItem;
						if(itemVo.science_type==item.data.science_type)
						{
							item.data=itemVo;
						}
					}
				}
				
			}
			
		}
		
		protected function closeBtn_clickHAndler(event:MouseEvent):void
		{
		  dispatchEvent(new ScienceResearchEvent(ScienceResearchEvent.CLOSE_EVENT,0));
		}
		
		public function searchContainer(str:String,callBack:Function):void
		{ 
			var invertID:int=interval(function():void
			{
				for(var i:int=0;i<container.num;i++)
				{
					var item:ScienceResearchItem=container.getAt(i) as ScienceResearchItem;
					if(item.data.scienceName==str)
					{
						if(callBack!=null)
						{
							clearInterval(invertID);
							callBack(item);
						}
						break;
					}
				}
			},1000);
		}
		
		
	}
}