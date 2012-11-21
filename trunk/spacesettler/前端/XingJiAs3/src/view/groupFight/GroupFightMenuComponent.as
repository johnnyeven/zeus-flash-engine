package view.groupFight
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.DateFormatter;
	
	import events.groupFight.GroupFightEvent;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import proxy.groupFight.GroupFightProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	
	import vo.groupFight.MyArmiesVo;
	
    public class GroupFightMenuComponent extends Component
    {
		public var timeLable:Label;
		public var numLable:Label;
		
		public var shuaXinBtn:Button;
		public var jiDiBtn:Button;

		private var groupFightproxy:GroupFightProxy;
		private var _timer:Timer;
		private var timeNum:int;
        public function GroupFightMenuComponent()
        {
            super(ClassUtil.getObject("view.GroupFightMenuSkin"));
			
			timeLable=createUI(Label,"timeLable");
			numLable=createUI(Label,"numLable");
			
			shuaXinBtn=createUI(Button,"shuaXinBtn");
			jiDiBtn=createUI(Button,"jiDiBtn");
			
			sortChildIndex();
			_timer=new Timer(1000);
			
			shuaXinBtn.addEventListener(MouseEvent.CLICK,shuaXinHandler);
			jiDiBtn.addEventListener(MouseEvent.CLICK,jiDiHandler);
        }
		
		protected function shuaXinHandler(event:MouseEvent):void
		{
			dispatchEvent(new GroupFightEvent(GroupFightEvent.SHUAXIN_EVENT));
		}
		
		protected function jiDiHandler(event:MouseEvent):void
		{
			dispatchEvent(new GroupFightEvent(GroupFightEvent.JIDI_EVENT));
		}
		
		public function upData(num:int):void
		{
			groupFightproxy=ApplicationFacade.getProxy(GroupFightProxy);
			numLable.text="X"+num.toString();
			timeNum=groupFightproxy.star5000.remainTime/1000;
			timeLable.text=DateFormatter.formatterTime(timeNum);
			_timer.start();
			_timer.addEventListener(TimerEvent.TIMER,timerHandler);
			
		}
		
		public override function dispose():void
		{
			super.dispose();
			timerStop();
		}
		
		private function timerStop():void
		{
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER,timerHandler);
			_timer=null;
		}
		
		protected function timerHandler(event:TimerEvent):void
		{
			timeNum--
			if(timeNum>0)
			{
				timeLable.text=DateFormatter.formatterTime(timeNum);
			}else
			{
				timerStop()
			}
		}
    }
}