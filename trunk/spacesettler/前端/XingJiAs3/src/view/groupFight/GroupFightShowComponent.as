package view.groupFight
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.ClassUtil;
	import com.zn.utils.DateFormatter;
	
	import enum.groupFightEnum.GroupFightEnum;
	
	import flash.events.MouseEvent;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.components.Label;
	import ui.components.VScrollBar;
	import ui.core.Component;
	import ui.layouts.VLayout;
	
	import vo.groupFight.LossReportVo;
	
	/**
	 *军团战上方信息显示 
	 * @author Administrator
	 * 
	 */	
    public class GroupFightShowComponent extends Component
    {
		
		public static const DISTANCE_COUNT:int=4;
		
		/**
		 * 收缩的窗口 
		 */		
		public var mc1:Component;
		
		/**
		 * 展开的窗口
		 */		
		public var mc2:Component;
		public var upBtn:Button;
		public var downBtn:Button;
		
//		public var container1:Container;
//		public var vsBar1:VScrollBar;
		
		public var container2:Container;
		public var vsBar2:VScrollBar;
		

		
        public function GroupFightShowComponent()
        {
            super(ClassUtil.getObject("view.GroupFightShowSkin"));
			
			mc1=createUI(Component,"mc1");
			mc2=createUI(Component,"mc2");
			downBtn=createUI(Button,"downBtn");
			upBtn=createUI(Button,"upBtn");
			
//			container1=mc1.createUI(Container,"container1");
//			vsBar1=mc1.createUI(VScrollBar,"vsBar1");
			
			container2=mc2.createUI(Container,"container2");
			vsBar2=mc2.createUI(VScrollBar,"vsBar2");
			
			sortChildIndex();
			mc1.sortChildIndex();
			mc2.sortChildIndex();
			
//			vsBar2.height=container2.height;
//			container1.layout = new VLayout(container1);
			container2.layout = new VLayout(container2);
			
			isMax();
			upBtn.addEventListener(MouseEvent.CLICK,upClickHandler);
			downBtn.addEventListener(MouseEvent.CLICK,downClickHandler);
			vsBar2.addEventListener(MouseEvent.MOUSE_DOWN,downHandler);
			vsBar2.addEventListener(MouseEvent.MOUSE_UP,upHandler);
        }
		
		protected function upHandler(event:MouseEvent):void
		{
			GroupFightComponent.MOUSE_ENABLED=true;
		}
		
		protected function downHandler(event:MouseEvent):void
		{
			GroupFightComponent.MOUSE_ENABLED=false;
		}
		
		public function upData(lossReportVo:LossReportVo):void
		{
			if(lossReportVo)
			{
				var item:GroupFightItemComponent=new GroupFightItemComponent();
				item.myNumTf.text=MultilanguageManager.getString("tishi")+lossReportVo.send_warships.toString()+MultilanguageManager.getString("tishi1")+
					GroupFightEnum.CURRTENT_TO_STARVO.name+MultilanguageManager.getString("tishi2")+lossReportVo.lost_warships_1.toString()+
					MultilanguageManager.getString("tishi3")+lossReportVo.lost_warships.toString()+MultilanguageManager.getString("tishi4");
				item.timeTf.text=DateFormatter.formatterTime((new Date).time);
				if(lossReportVo.left_warships_1==0)
					item.myNumTf.text+=MultilanguageManager.getString("tishi5")
				addContainer(item,container2);
			}
			vsBar2.height=container2.height;
			vsBar2.viewport=container2;
		}
		
		
		protected function downClickHandler(event:MouseEvent):void
		{
			isMax();
		}
		
		protected function upClickHandler(event:MouseEvent):void
		{
			isMin();
		}
		
		public function isMin():void
		{
			mc1.visible=true;
			mc2.visible=false;
			vsBar2.visible=false;
//			vsBar1.visible=true;
			upBtn.visible=false;
			downBtn.visible=true;
//			vsBar1.viewport=container1;
		}
		
		private function addContainer(itemLabel:GroupFightItemComponent,container:Container):void
		{
			container.add(itemLabel);
			container.layout.update();
			container.layout.vGap = DISTANCE_COUNT;
		}
		
		public function isMax():void
		{
			mc1.visible=false;
//			vsBar1.visible=false;
			vsBar2.visible=true;
			mc2.visible=true;
			upBtn.visible=true;
			downBtn.visible=false;
			vsBar2.viewport=container2;
		}
    }
}