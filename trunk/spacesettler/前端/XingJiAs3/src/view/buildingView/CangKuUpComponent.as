package view.buildingView
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.DateFormatter;
	
	import events.buildingView.AddViewEvent;
	import events.buildingView.BuildEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.BuildProxy;
	import proxy.content.ContentProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.components.ProgressBar;
	import ui.core.Component;
	
	import vo.BuildInfoVo;
	import vo.viewInfo.ViewInfoVO;
	
	/**
	 * 物资仓库升级界面
	 * 
	 */
	public class CangKuUpComponent extends Component
	{
		public var levelLabel:Label;//等级
		public var anWuZhiRLLabel:Label;//水晶容量
		public var chuanQingRLLabel:Label;//氚气容量
		public var anWuZhiXHLabel:Label;//暗物质消耗
		public var shuiJingKuangXHLabel:Label;//水晶矿消耗
		public var chuanQingXHLabel:Label;//氚氢消耗
		public var xiaoGuo1Label:Label;//效果1
		public var xiaoGuo2Label:Label;//效果2
		public var xiaoGuo3Label:Label;//效果3
		public var timeLabel:Label;//升级所需时间
		
		public var progressMC:ProgressBar//进度条
		
		public var upLevelButton:Button;//升级按钮
		public var closeButton:Button;//关闭按钮
		public var infoButton:Button;//信息按钮
		public var speedButton:Button; //加速按钮
		
		private var _buildVO:BuildInfoVo;
		
		public function CangKuUpComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			levelLabel=createUI(Label,"level_textField");
			anWuZhiRLLabel=createUI(Label,"anWuZhiRL_textField");
			chuanQingRLLabel=createUI(Label,"chuanQingRL_textField");
			anWuZhiXHLabel=createUI(Label,"anWuZhiXH_textField");
			shuiJingKuangXHLabel=createUI(Label,"shuiJingKuangXH_textField");
			chuanQingXHLabel=createUI(Label,"chuanQingXH_textField");
			xiaoGuo1Label=createUI(Label,"xiaoGuo1_textField");
			xiaoGuo2Label=createUI(Label,"xiaoGuo2_textField");
			xiaoGuo3Label=createUI(Label,"xiaoGuo3_textField");
			timeLabel=createUI(Label,"time_textField");
			
			progressMC = createUI(ProgressBar, "progress_MC");
			progressMC.percent = 0;
			
			upLevelButton=createUI(Button,"upLevel_button");
			closeButton=createUI(Button,"close_button");
			infoButton=createUI(Button,"info_button");
			speedButton = createUI(Button, "speed_button");
			speedButton.visible = false;
			
			sortChildIndex();
			
			upLevelButton.addEventListener(MouseEvent.CLICK,upLevelButton_clickHandler);
			closeButton.addEventListener(MouseEvent.CLICK,closeButton_clickHandler);
			infoButton.addEventListener(MouseEvent.CLICK,infoButton_clickHandler);
			speedButton.addEventListener(MouseEvent.CLICK, speedButton_clickHandler);
		}
		
		protected function upLevelButton_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function closeButton_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new AddViewEvent(AddViewEvent.CLOSE_EVENT));
		}
		
		protected function infoButton_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		public function set upType(value:int):void
		{
			var buildProxy:BuildProxy=ApplicationFacade.getProxy(BuildProxy);
			_buildVO=buildProxy.getBuild(value);

			var curViewInfoVO:ViewInfoVO=ContentProxy(ApplicationFacade.getProxy(ContentProxy)).getUpBuildInfo(value,_buildVO.level);
			var nextViewInfoVO:ViewInfoVO=ContentProxy(ApplicationFacade.getProxy(ContentProxy)).getUpBuildInfo(value,_buildVO.level+1);
			
			levelLabel.text=_buildVO.level+"";
			anWuZhiRLLabel.text=curViewInfoVO.shuiJinRL+"";
			chuanQingRLLabel.text=curViewInfoVO.chuanQinRL+"";
			anWuZhiXHLabel.text=curViewInfoVO.anWuZhiXH+"";
			shuiJingKuangXHLabel.text=curViewInfoVO.shuiJinXH+"";
			chuanQingXHLabel.text=curViewInfoVO.chuanQinXH+"";
			xiaoGuo1Label.text=curViewInfoVO.DianNengXH+"/h --> "+nextViewInfoVO.DianNengXH+"/h";
			xiaoGuo2Label.text=curViewInfoVO.shuiJinRL+"/h --> "+nextViewInfoVO.shuiJinRL+"/h";
			xiaoGuo3Label.text=curViewInfoVO.chuanQinRL+"/h --> "+nextViewInfoVO.chuanQinRL+"/h";
			
			removeCWList();
			cwList.push(BindingUtils.bindSetter(startTimeCompleteChange, _buildVO, "startTimeComplete"));
			
			upLevelButton.visible = speedButton.visible = false;
			
			if (_buildVO == null || _buildVO.isNormal) //未建造
			{
				timeLabel.text = nextViewInfoVO.time + MultilanguageManager.getString("timeMiao");
				upLevelButton.visible = true;
			}
			else if (_buildVO.isBuild || _buildVO.isUp) //建造中
			{
				cwList.push(BindingUtils.bindSetter(remainTimeChange, _buildVO, "current_time"));
			}
		}
		
		private function startTimeCompleteChange(value:*):void
		{
			if (value)
				closeButton_clickHandler(null);
		}
		
		public function remainTimeChange(value:int):void
		{
			if (_buildVO.remainTime > 10)
				speedButton.visible = true;
			else
				speedButton.visible = false;
			
			timeLabel.text = DateFormatter.formatterTime(_buildVO.remainTime) + MultilanguageManager.getString("timeMiao");
			var totalTime:int = _buildVO.finish_time - _buildVO.start_time;
			progressMC.percent = (_buildVO.current_time - _buildVO.start_time) / totalTime;
		}
		
		/**
		 *加速
		 * @param event
		 *
		 */
		protected function speedButton_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event(BuildEvent.SPEED_EVENT));
		}
	}
}