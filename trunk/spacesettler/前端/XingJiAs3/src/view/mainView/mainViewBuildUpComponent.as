package view.mainView
{
	import com.zn.utils.ClassUtil;
	
	import flash.display.DisplayObjectContainer;
	
	import ui.core.Component;
	
	import view.mainView.mainViewNumberComponent;
	
    public class mainViewBuildUpComponent extends Component
    {
		public var numComp1:mainViewNumberComponent;
		public var numComp2:mainViewNumberComponent;
		
		private var skin:DisplayObjectContainer;
        public function mainViewBuildUpComponent(levle:int)
        {
			if(levle<10)
				skin=(ClassUtil.getObject("view.mainViewBuildUpComponentSkin1"));
			else
				skin=(ClassUtil.getObject("view.mainViewBuildUpComponentSkin"));
			
			super(skin);
			numComp1=createUI(mainViewNumberComponent,"numComp1");
			numComp2=createUI(mainViewNumberComponent,"numComp2");
			
			sortChildIndex();
        }
		
		public function set level(level:int):void
		{
			if(level>0&&level<10)
			{
				numComp1.showNum(0);
				numComp1.visible=false;
				numComp2.showNum(level);
				
			}else if(level>=10&&level<20)
			{
				numComp1.showNum(1);
				numComp2.showNum(level-10);
				
			}else if(level>=20&&level<30)
			{
				numComp1.showNum(2);
				numComp2.showNum(level-20);
				
			}else if(level>=30&&level<30)
			{
				numComp1.showNum(3);
				numComp2.showNum(level-30);
				
			}else if(level>=40)
			{
				numComp1.showNum(4);
				numComp2.showNum(level-40);
			}
				
		}
    }
}