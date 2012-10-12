package view.buildingView
{	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.DateFormatter;
	import com.zn.utils.StringUtil;
	
	import enum.BuildTypeEnum;
	
	import events.buildingView.AddViewEvent;
	import events.buildingView.BuildEvent;
	import events.buildingView.UpLevelEvent;
	
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
	 * 晶体冶炼厂升级界面
	 * 
	 */
	public class YeLianChangUpComponent extends Component
	{
		public var levelLabel:Label;//等级
		public var shuiJingKuangCLLabel:Label;//水晶矿产量
		public var anWuZhiXHLabel:Label;//暗物质消耗
		public var shuiJingKuangXHLabel:Label;//水晶矿消耗
		public var chuanQingXHLabel:Label;//氚氢消耗
		public var xiaoGuo1Label:Label;//效果1
		public var xiaoGuo2Label:Label;//效果2
		public var timeLabel:Label;//升级所需时间
		
		public var upLevelButton:Button;//升级按钮
		public var closeButton:Button;//关闭按钮
		public var infoButton:Button;//信息按钮
		public var speedButton:Button; //加速按钮
		public var progressMC:ProgressBar;//进度条
		
		public var manJiTf:Label;
		
		public var spComp:Component;
		
		private var _buildVO:BuildInfoVo;
		private var _tweenLite:Object;
		
		public function YeLianChangUpComponent(skin:DisplayObjectContainer)
		{
			super(skin);			
			
			levelLabel=createUI(Label,"level_textField");
			shuiJingKuangCLLabel=createUI(Label,"shuiJingKuangCL_textField");
			manJiTf =createUI(Label, "manji_tf");
			manJiTf.visible=false;	
			
			spComp=createUI(Component,"sprite");
			
			anWuZhiXHLabel=spComp.createUI(Label,"anWuZhiXH_textField");
			shuiJingKuangXHLabel=spComp.createUI(Label,"shuiJingKuangXH_textField");
			chuanQingXHLabel=spComp.createUI(Label,"chuanQingXH_textField");
			xiaoGuo1Label=spComp.createUI(Label,"xiaoGuo1_textField");
			xiaoGuo2Label=spComp.createUI(Label,"xiaoGuo2_textField");
			timeLabel=spComp.createUI(Label,"time_textField");
			
			upLevelButton=spComp.createUI(Button,"upLevel_button");
			speedButton = spComp.createUI(Button, "speed_button");
			speedButton.visible = false;
			progressMC = spComp.createUI(ProgressBar, "progress_MC");
			progressMC.percent = 0;
			
			spComp.sortChildIndex();
			
			closeButton=createUI(Button,"close_button");
			infoButton=createUI(Button,"info_button");
			sortChildIndex();
			
			upLevelButton.addEventListener(MouseEvent.CLICK,upLevelButton_clickHandler);
			closeButton.addEventListener(MouseEvent.CLICK,closeButton_clickHandler);
			infoButton.addEventListener(MouseEvent.CLICK,infoButton_clickHandler);
			speedButton.addEventListener(MouseEvent.CLICK, speedButton_clickHandler);
		}
		
		protected function upLevelButton_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event(BuildEvent.UP_EVENT));
		}
		
		protected function closeButton_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new AddViewEvent(AddViewEvent.CLOSE_EVENT));
		}
		
		protected function infoButton_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event(BuildEvent.INFO_EVENT));			
		}
		
		public function set buildType(value:int):void
		{
			var buildProxy:BuildProxy=ApplicationFacade.getProxy(BuildProxy);
			_buildVO=buildProxy.getBuild(value);
			
			if(_buildVO.level>=40)
			{
				fullView();
			}

			var curViewInfoVO:ViewInfoVO=ContentProxy(ApplicationFacade.getProxy(ContentProxy)).getUpBuildInfo(value,_buildVO.level);
			var nextViewInfoVO:ViewInfoVO=ContentProxy(ApplicationFacade.getProxy(ContentProxy)).getUpBuildInfo(value,_buildVO.level+1);
			
			levelLabel.text=_buildVO.level+"";
			shuiJingKuangCLLabel.text=curViewInfoVO.shuiJinCL+"";
			anWuZhiXHLabel.text=nextViewInfoVO.anWuZhiXH+"";
			shuiJingKuangXHLabel.text=nextViewInfoVO.shuiJinXH+"";
			chuanQingXHLabel.text=nextViewInfoVO.chuanQinXH+"";
			xiaoGuo1Label.text=curViewInfoVO.DianNengXH+"/h --> "+nextViewInfoVO.DianNengXH+"/h";
			xiaoGuo2Label.text=curViewInfoVO.shuiJinCL+"/h --> "+nextViewInfoVO.shuiJinCL+"/h";
			
			removeCWList();
			upLevelButton.visible = speedButton.visible = false;
			
			stopTweenLite();
			progressMC.percent=0;
			
			if (_buildVO == null || _buildVO.isNormal) //未建造
			{
				timeLabel.text = DateFormatter.formatterTimeSFM(nextViewInfoVO.time);
				upLevelButton.visible = true;
			}
			else if (_buildVO.isBuild || _buildVO.isUp) //建造中
			{
				cwList.push(BindingUtils.bindSetter(remainTimeChange, _buildVO, "current_time"));
				cwList.push(BindingUtils.bindSetter(buildComplete, _buildVO, "eventID"));
		
				var totalTime:int = _buildVO.finish_time - _buildVO.start_time;
				progressMC.percent = (_buildVO.current_time - _buildVO.start_time) / totalTime;
				var time:int = _buildVO.remainTime;
				
				stopTweenLite();
				_tweenLite = TweenLite.to(progressMC, time, { percent: 1, ease: Linear.easeNone });
			}
		}
		
		private function buildComplete(value:*):void
		{
			if (StringUtil.isEmpty(value))
				buildType=BuildTypeEnum.KUANGCHANG;
		}
		
		private function stopTweenLite():void
		{
			if (_tweenLite)
				_tweenLite.kill();
			_tweenLite = null;
		}
		
		public override function dispose():void
		{
			super.dispose();
			stopTweenLite();
		}
		
		public function remainTimeChange(value:int):void
		{
			if (_buildVO.remainTime > 10)
				speedButton.visible = true;
			else
				speedButton.visible = false;
			
			timeLabel.text = DateFormatter.formatterTimeSFM(_buildVO.remainTime);
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
		
		public function fullView():void
		{
			spComp.visible=false;
			manJiTf.visible=true;
		}
	}
}