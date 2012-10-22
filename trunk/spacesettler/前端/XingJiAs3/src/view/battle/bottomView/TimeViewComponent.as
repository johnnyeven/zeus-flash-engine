package view.battle.bottomView
{
	import events.battle.TimeViewEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import ui.components.Label;
	import ui.core.Component;
	
	/**
	 * 时间面板
	 * @author zn
	 * 
	 */
	public class TimeViewComponent extends Component
	{
		public var TOTALTIME:int=300;
		
		public var timeLabel:Label;
		
		public var timer:Timer;
		
		public function TimeViewComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			
			timeLabel=createUI(Label,"timeLabel");
			
			sortChildIndex();
			
			timer=new Timer(1000,TOTALTIME);
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
		}
		
		protected function timerHandler(event:TimerEvent):void
		{
			
			TOTALTIME--;
			var min:int=0;
			var second:int=0;
			min=TOTALTIME/60;
			second=TOTALTIME%60;
			timeLabel.text=min+":"+second;
			
			if(TOTALTIME==0)
			{
				stopTimer();
			}
		}
		
		private function stopTimer():void
		{
			timer.stop();
			dispatchEvent(new TimeViewEvent(TimeViewEvent.TIMEOVER_EVENT));
		}
	}
}