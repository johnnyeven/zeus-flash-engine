package view.mainView
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.DateFormatter;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.ProgressBar;
	import ui.core.Component;
	
	import view.mainSence.BuildComponent;
	
	import vo.BuildInfoVo;
	import vo.userInfo.UserInfoVO;
	
	public class BuildUpLoaderViewComponent extends Component
	{
		public var timeText:TextField;
		
		public var loader:ProgressBar;	
		
		private var _timer:Timer;
		private var _buildInfoVo:BuildInfoVo;
		
		/**
		 *建筑升级需要总时间 (S)
		 */		
		private var numSum:int;
		
		/**
		 *建筑升级从开始事件到当前已经开始了多少时间 (S)
		 */		
		private var starNum:int;
		
		/** 
		 * 建筑升级从开始事件到当前还剩多少时间 (S)
		 */
		private var endNum:int;
		
		public function BuildUpLoaderViewComponent()
		{
			super(ClassUtil.getObject("view.mainView.BuildUpLoaderViewComponentSkin"));
			timeText=getSkin("time_tf");
			loader=createUI(ProgressBar,"loader_mc");	
			
			sortChildIndex();
		}
				
		public function set buildInfoVo(value:BuildInfoVo):void
		{
			_buildInfoVo=value
			
			numSum=_buildInfoVo.finish_time-_buildInfoVo.start_time;
			starNum=_buildInfoVo.current_time-_buildInfoVo.start_time;
			
			_timer=new Timer(1000);
			_timer.addEventListener(TimerEvent.TIMER,timerStart);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE,timerComplete);
			_timer.start();
		}
		
		protected function timerComplete(event:TimerEvent):void
		{
			_timer.stop()
			_timer.reset();
			timeText.text="";
			(this.parent as BuildComponent).buildInfoVo.eventID=0;
			_timer.removeEventListener(TimerEvent.TIMER,timerStart);
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE,timerComplete);
			
			dispose();//父类方法，销毁

			
		}		
		
		protected function timerStart(event:TimerEvent):void
		{
			endNum=numSum-starNum;
			loader.percent=starNum/numSum;
			timeText.text=DateFormatter.formatterTimeAll(endNum);
			starNum++;
			/*	min=int(endNum/60%60);
			hour=int(endNum/60/60);
			sec=int(endNum%60);
			
			if(hour<=0)
			{
				str1="00";
			}else if(hour>0&&hour<10)
			{
				str1="0"+hour.toString();
			}else
			{
				str1=hour.toString();
			}
			
			if(min<=0)
			{
				str2="00";
			}else if(min>0&&min<10)
			{
				str2="0"+min.toString();
			}else if(min>=10&&min<60)
			{
				str2=min.toString();
			}
			str3=sec.toString();
			
			var str:String*/
			
		}
	}
}