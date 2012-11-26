package view.battle.build
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.zn.utils.ClassUtil;
	import com.zn.utils.DateFormatter;
	
	import enum.battle.BattleBuildStateEnum;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import ui.components.Label;
	import ui.components.ProgressBar;
	import ui.core.Component;
	
	import vo.battle.BattleBuildVO;
	
	/**
	 * 战场建筑修建倒计时
	 * @author Administrator
	 * 
	 */	
	public class BattleBuildTimeBarComponent extends Component
	{
		public var timeLabel:Label;
		public var bar:ProgressBar;

		private var _timer:Timer;
		
		private var _buildVO:BattleBuildVO;

		private var _tweenLite:TweenLite;
		
		public function BattleBuildTimeBarComponent()
		{
			super(ClassUtil.getObject("battle.BattleBuildTimeBarSkin"));
			timeLabel=createUI(Label,"timeLabel");
			bar=createUI(ProgressBar,"bar");
			bar.percent=0;
			
			sortChildIndex();
			
			_timer=new Timer(1000);
			_timer.addEventListener(TimerEvent.TIMER,timerHandler);
			
			x=-width*0.5;
		}
		
		
		public override function dispose():void
		{
			super.dispose();
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER,timerHandler);
			//TODO LW :恢复
//			_timer=null;
			_tweenLite.kill();
//			_tweenLite=null;
			//TODO LW :恢复
//			_tweenLite=null;
		}
		
		protected function timerHandler(event:TimerEvent):void
		{
			if(buildVO.remainTime<=0)
			{
				buildVO.state=BattleBuildStateEnum.normal;
				dispose();
				
				return ;
			}
			timeLabel.text=DateFormatter.formatterTime(buildVO.remainTime/1000);
		}

		public function get buildVO():BattleBuildVO
		{
			return _buildVO;
		}

		public function set buildVO(value:BattleBuildVO):void
		{
			_buildVO = value;
			
			_timer.start();
			_tweenLite=TweenLite.to(bar,buildVO.remainTime/1000,{percent:1,ease:Linear.easeNone});
			timerHandler(null);
		}

	}
}