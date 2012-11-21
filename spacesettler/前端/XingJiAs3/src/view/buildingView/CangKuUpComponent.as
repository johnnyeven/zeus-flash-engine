package view.buildingView
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.DateFormatter;
	import com.zn.utils.StringUtil;
	
	import enum.BuildTypeEnum;
	import enum.ResEnum;
	
	import events.buildingView.AddViewEvent;
	import events.buildingView.BuildEvent;
	import events.buildingView.ConditionEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.messaging.AbstractConsumer;
	
	import proxy.BuildProxy;
	import proxy.content.ContentProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.components.ProgressBar;
	import ui.core.Component;
	
	import vo.BuildInfoVo;
	import vo.userInfo.UserInfoVO;
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
		public var conditionBtn:Button;//条件不足按钮
		
		public var manJiTf:Label;
		
		public var spComp:Component;
		
		private var _buildVO:BuildInfoVo;
		
		private var _KeJiBuild:BuildInfoVo;
		
		private var _tweenLite:Object;
		
		public var conditionArr:Array;
		private var _hasPower:Boolean=true;
		public function CangKuUpComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			levelLabel=createUI(Label,"level_textField");
			anWuZhiRLLabel=createUI(Label,"anWuZhiRL_textField");
			chuanQingRLLabel=createUI(Label,"chuanQingRL_textField");
			
			manJiTf =createUI(Label, "manji_tf");
			manJiTf.visible=false;			
			spComp=createUI(Component,"sprite");
			
			anWuZhiXHLabel=spComp.createUI(Label,"anWuZhiXH_textField");
			shuiJingKuangXHLabel=spComp.createUI(Label,"shuiJingKuangXH_textField");
			chuanQingXHLabel=spComp.createUI(Label,"chuanQingXH_textField");
			xiaoGuo1Label=spComp.createUI(Label,"xiaoGuo1_textField");
			xiaoGuo2Label=spComp.createUI(Label,"xiaoGuo2_textField");
			xiaoGuo3Label=spComp.createUI(Label,"xiaoGuo3_textField");
			timeLabel=spComp.createUI(Label,"time_textField");
			
			progressMC =spComp.createUI(ProgressBar, "progress_MC");
			progressMC.percent = 0;
			
			upLevelButton=spComp.createUI(Button,"upLevel_button");
			speedButton = spComp.createUI(Button, "speed_button");
			speedButton.visible = false;
			
			spComp.sortChildIndex();
			
			closeButton=createUI(Button,"close_button");
			infoButton=createUI(Button,"info_button");
			conditionBtn=spComp.createUI(Button,"conditionBtn");
			conditionBtn.visible=false;
			sortChildIndex();
			
			upLevelButton.addEventListener(MouseEvent.CLICK,upLevelButton_clickHandler);
			closeButton.addEventListener(MouseEvent.CLICK,closeButton_clickHandler);
			infoButton.addEventListener(MouseEvent.CLICK,infoButton_clickHandler);
			speedButton.addEventListener(MouseEvent.CLICK, speedButton_clickHandler);
		}
		
		protected function upLevelButton_clickHandler(event:MouseEvent):void
		{
			if(conditionBtn.visible==true)
				dispatchEvent(new ConditionEvent(ConditionEvent.ADDCONDITIONVIEW_EVENT,conditionArr));
			else
			{
				if(_hasPower)
					dispatchEvent(new Event(BuildEvent.UP_EVENT));
				else
					dispatchEvent(new ConditionEvent(ConditionEvent.POWERPROMT_EVENT));
			}
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
			_KeJiBuild = buildProxy.getBuild(BuildTypeEnum.KEJI);
			var centerBuild:BuildInfoVo=buildProxy.getBuild(BuildTypeEnum.CENTER);
			
			var userInfoVO:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			
			if(_buildVO.level>=40)
			{
				fullView();
			}

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
			
			if(nextViewInfoVO.anWuZhiXH>userInfoVO.broken_crysta || nextViewInfoVO.shuiJinXH>userInfoVO.crystal ||
				nextViewInfoVO.chuanQinXH>userInfoVO.tritium || nextViewInfoVO.command_center_level>centerBuild.level)// ||nextViewInfoVO.DianNengXH>userInfoVO.current_power_supply
			{
				conditionBtn.visible=true;
				conditionBtn.addEventListener(MouseEvent.CLICK,conditionBtn_clickHandler);
			}
			//不足的条件
			conditionArr=[];
			if(nextViewInfoVO.anWuZhiXH>userInfoVO.broken_crysta)
			{
				var obj1:Object=new Object();
				obj1.imgSource=ResEnum.getConditionIconURL+"1.png";
				obj1.content=MultilanguageManager.getString("broken_crysta")+int(userInfoVO.broken_crysta)+"/"+nextViewInfoVO.anWuZhiXH;
				obj1.btnLabel=MultilanguageManager.getString("buy_click");
				conditionArr.push(obj1);
			}
			if(nextViewInfoVO.shuiJinXH>userInfoVO.crystal)
			{
				var obj2:Object=new Object();
				obj2.imgSource=ResEnum.getConditionIconURL+"2.png";
				obj2.content=MultilanguageManager.getString("crystal")+int(userInfoVO.crystal)+"/"+nextViewInfoVO.shuiJinXH;
				obj2.btnLabel=MultilanguageManager.getString("buy_click");
				conditionArr.push(obj2);
			}
			if(nextViewInfoVO.chuanQinXH>userInfoVO.tritium)
			{
				var obj3:Object=new Object();
				obj3.imgSource=ResEnum.getConditionIconURL+"3.png";
				obj3.content=MultilanguageManager.getString("tritium")+int(userInfoVO.tritium)+"/"+nextViewInfoVO.chuanQinXH;
				obj3.btnLabel=MultilanguageManager.getString("buy_click");
				conditionArr.push(obj3);
			}
			if((nextViewInfoVO.DianNengXH-curViewInfoVO.DianNengXH)>(userInfoVO.current_power_supply-userInfoVO.current_power_consume))
			{
				var obj4:Object=new Object();
				obj4.imgSource=ResEnum.getConditionIconURL+"4.png";
				obj4.content=MultilanguageManager.getString("power_supply")+(userInfoVO.current_power_supply-userInfoVO.current_power_consume)+"/"+nextViewInfoVO.DianNengXH;
				obj4.btnLabel=MultilanguageManager.getString("produce_click");
//				conditionArr.push(obj4);
				_hasPower=false;
			}
			if(nextViewInfoVO.command_center_level>centerBuild.level)
			{
				var obj5:Object=new Object();
				obj5.imgSource=ResEnum.getConditionIconURL+"5.png";
				obj5.content=MultilanguageManager.getString("center_build")+centerBuild.level+"/"+nextViewInfoVO.command_center_level;
				obj5.btnLabel=MultilanguageManager.getString("up_center");
				conditionArr.push(obj5);
			}
			
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
				buildType=BuildTypeEnum.CANGKU;
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
		 *条件不足
		 * @param event
		 *
		 */
		protected function conditionBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new ConditionEvent(ConditionEvent.ADDCONDITIONVIEW_EVENT,conditionArr));
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