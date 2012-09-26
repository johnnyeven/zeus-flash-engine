package view.timeMachine
{
	import com.zn.utils.DateFormatter;
	import com.zn.utils.StringUtil;
	
	import enum.BuildTypeEnum;
	
	import events.timeMachine.TimeMachineEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import ui.components.Button;
	import ui.components.Image;
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
		
		public var buildNameTxt:TextField;
		
		public var buildLevelTxt:TextField;
		
		public var remainTimeTxt:TextField;
		
		public var progressBar:ProgressBar;
		
		public var speedBtn:Button;
		
		private var _data:TimeMachineVO;
		
		public function TimeMachineItem(skin:DisplayObjectContainer)
		{
			super(skin);
			
			buildIconImage = createUI(LoaderImage,"buildIconImage");
			
			buildNameTxt = getSkin("buildNameTxt");
			buildLevelTxt = getSkin("buildLevelTxt");
			remainTimeTxt = getSkin("remainTimeTxt");
			
			progressBar = createUI(ProgressBar,"progressBar");
			progressBar.percent = 0;
			speedBtn = createUI(Button,"speedBtn");
			
			sortChildIndex();
			
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
			
			buildIconImage.source = BuildTypeEnum.getBuildIconURLByBuildType(_data.building_type);
			buildNameTxt.text = BuildTypeEnum.getBuildNameByBuildType(_data.building_type);
			var str:String = "<p><s>{0}级</s><s>-</s><s>{1}级</s></p>";
			str = StringUtil.formatString(str,_data.level,_data.level+1);
			buildLevelTxt.text = str;
			
			remainTimeTxt.text = DateFormatter.formatterTimeSFM(_data.remainingTime);
			progressBar.percent = (_data.current_time -_data.start_time)/_data.upTotalTome;
		}

		private function speedBtn_clickHAndler(event:MouseEvent):void
		{
			dispatchEvent(new TimeMachineEvent(TimeMachineEvent.SPEED_EVENT,data.building_type,true,true));
		}
	}
}