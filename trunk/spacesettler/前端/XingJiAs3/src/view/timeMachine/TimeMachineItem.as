package view.timeMachine
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.DateFormatter;
	import com.zn.utils.StringUtil;
	
	import enum.BuildTypeEnum;
	import enum.EventTypeEnum;
	
	import events.timeMachine.TimeMachineEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import org.osmf.events.TimeEvent;
	
	import ui.components.Button;
	import ui.components.Image;
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.components.ProgressBar;
	import ui.core.Component;
	
	import vo.timeMachine.TimeMachineVO;
	
	/**
	 * 时间机器加速条目
	 * @author lw
	 * 
	 */	
	public class TimeMachineItem extends Component
	{
		public var buildIconImage:LoaderImage;
		
		public var buildNameTxt:Label;
		
		public var buildLevelTxt:Label;
		
		public var remainTimeTxt:Label;
		
		public var progressBar:ProgressBar;
		
		public var speedBtn:Button;
		
		private var _data:TimeMachineVO;
		
		private var _timer:Timer;
		
		public function TimeMachineItem()
		{
			super(ClassUtil.getObject("view.timeMachine.TimeMachineItemSkin"));
			
			buildIconImage = createUI(LoaderImage,"buildIconImage");
			
			buildNameTxt = createUI(Label,"buildNameTxt");
			buildLevelTxt = createUI(Label,"buildLevelTxt");
			remainTimeTxt = createUI(Label,"remainTimeTxt");
			
			progressBar = createUI(ProgressBar,"progressBar");
			progressBar.percent = 0;
			speedBtn = createUI(Button,"speedBtn");
			
			sortChildIndex();
			_timer = new Timer(1000);
			_timer.addEventListener(TimerEvent.TIMER,timerHandler);
			speedBtn.addEventListener(MouseEvent.CLICK,speedBtn_clickHAndler);
		}
		
		
		public function get data():TimeMachineVO
		{
			return _data;
		}

		public function set data(value:TimeMachineVO):void
		{
			if(value)
			{
				_data = value;
			}
			if(_data.type == EventTypeEnum.BUILDINGEVENTSTYPE)
			{
				buildIconImage.source = BuildTypeEnum.getBuildIconURLByBuildType(_data.building_type);
				buildNameTxt.text = BuildTypeEnum.getBuildNameByBuildType(_data.building_type);
			}
			else if(_data.type == EventTypeEnum.RESEARCHEVENTSTYPE)
			{
				buildIconImage.source = BuildTypeEnum.getResearchIconURLByResearchType(_data.building_type);
				buildNameTxt.text = BuildTypeEnum.getResearchNameByResearchType(_data.building_type);
			}
			
			var str:String = "<p><s>{0}级</s><s>-</s><s>{1}级</s></p>";
			str = StringUtil.formatString(str,_data.level,_data.level+1);
			buildLevelTxt.text = str;
			
			_timer.start();
		}

		private function speedBtn_clickHAndler(event:MouseEvent):void
		{
			var count:int = data.crystalCount;
			dispatchEvent(new TimeMachineEvent(TimeMachineEvent.SPEED_EVENT,data.building_type,count,true,true));
		}
		
		private function timerHandler(event:TimerEvent):void
		{
			if(_data.remainTime <10)
			{
				this.visible = false;
			}
			remainTimeTxt.text = DateFormatter.formatterTimeSFM(_data.remainTime/1000);
			progressBar.percent = (_data.upTotalTome - _data.remainTime)/_data.upTotalTome;
		}
		
		public override function dispose():void
		{
			super.dispose();
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, timerHandler);
			
			_timer = null;
		}
	}
}