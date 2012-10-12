package view.buildingView
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Linear;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    import com.zn.utils.DateFormatter;
    import com.zn.utils.StringUtil;
    
    import enum.BuildTypeEnum;
    import enum.CenterTechTypeEnum;
    
    import events.buildingView.AddViewEvent;
    import events.buildingView.BuildEvent;
    
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    import mx.binding.utils.BindingUtils;
    
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
     *基地中心升级界面
     *
    */
    public class CenterUpComponent extends Component
    {
        public var userNameLabel:Label; //玩家ID

        public var shiDaiLabel:Label; //基地时代

        public var shuXing1Label:Label; //属性1

        public var shuXing2Label:Label; //属性2

        public var shuXing3Label:Label; //属性3

        public var shuXing4Label:Label; //属性4

        public var shuiJingKuangCLLabel:Label; //水晶矿产量

        public var chuanQingCLLabel:Label; //氚氢产量

        public var anWuZhiCLLabel:Label; //暗物质产量

        public var levelLabel:Label; //科技中心等级

        public var anWuzhiXHLabel:Label; //暗物质消耗

        public var chuanQingXHLabel:Label; //氚氢消耗

        public var shuiJingKuangXHLabel:Label; //水晶矿消耗

        public var xiaoGuo1Label:Label; //效果1

        public var xiaoGuo2Label:Label; //效果2

        public var xiaoGuo3Label:Label; //效果3

        public var timeLabel:Label; //升级所需时间

        public var shiDai1MC:MovieClip; //机械时代

        public var shiDai2MC:MovieClip; //电磁时代

        public var shiDai3MC:MovieClip; //激光时代

        public var shiDai4MC:MovieClip; //核能时代

        public var progressMC:ProgressBar; //进度条

        public var upLevelButton:Button; //升级按钮

        public var closeButton:Button; //关闭按钮

        public var infoButton:Button; //信息按钮

        public var enterButton:Button; //进入按钮

        public var speedButton:Button; //加速按钮
		
		public var manJiTf:Label;
		
		public var spComp:Component;

        private var _buildVO:BuildInfoVo;

        private var _KeJiBuild:BuildInfoVo;
        private var _tweenLite:Object;

        public function CenterUpComponent(skin:DisplayObjectContainer)
        {			
            super(skin);
            userNameLabel = createUI(Label, "userName_textField");
            shiDaiLabel = createUI(Label, "shiDai_textField");
            shuXing1Label = createUI(Label, "shuXing1_textField");
            shuXing2Label = createUI(Label, "shuXing2_textField");
            shuXing3Label = createUI(Label, "shuXing3_textField");
            shuXing4Label = createUI(Label, "shuXing4_textField");
			levelLabel = createUI(Label, "level_textField");
			chuanQingCLLabel = createUI(Label, "chuanQingCL_textField");
            anWuZhiCLLabel = createUI(Label, "anWuZhiCL_textField");
			shuiJingKuangCLLabel =createUI(Label, "shuiJingKuangCL_textField");
			manJiTf =createUI(Label, "manji_tf");
			manJiTf.visible=false;
			
			spComp=createUI(Component,"sprite");
            
			anWuzhiXHLabel = spComp.createUI(Label, "anWuZhiXH_textField");
            chuanQingXHLabel = spComp.createUI(Label, "chuanQingXH_textField");
            shuiJingKuangXHLabel = spComp.createUI(Label, "shuiJingKuangXH_textField");
            xiaoGuo1Label = spComp.createUI(Label, "xiaoGuo1_textField");
            xiaoGuo2Label =spComp. createUI(Label, "xiaoGuo2_textField");
            xiaoGuo3Label = spComp.createUI(Label, "xiaoGuo3_textField");
            timeLabel = spComp.createUI(Label, "time_textField");

            progressMC =spComp. createUI(ProgressBar, "progress_MC");
            progressMC.percent = 0;
            upLevelButton = spComp.createUI(Button, "upLevel_button");
            speedButton =spComp. createUI(Button, "speed_button");
			
			spComp.sortChildIndex();            

            shiDai1MC = getSkin("shiDai1_MC");
            shiDai2MC = getSkin("shiDai2_MC");
            shiDai3MC = getSkin("shiDai3_MC");
            shiDai4MC = getSkin("shiDai4_MC");
			
			shiDai2MC.gotoAndStop(2);
			shiDai3MC.gotoAndStop(2);
			shiDai4MC.gotoAndStop(2);
			
            enterButton = createUI(Button, "enter_button");
            infoButton = createUI(Button, "info_button");
            closeButton = createUI(Button, "close_button");

            sortChildIndex();

            enterButton.addEventListener(MouseEvent.CLICK, enterButton_clickHandler);
            upLevelButton.addEventListener(MouseEvent.CLICK, upLevelButton_clickHandler);
            closeButton.addEventListener(MouseEvent.CLICK, closeButton_clickHandler);
            infoButton.addEventListener(MouseEvent.CLICK, infoButton_clickHandler);
            speedButton.addEventListener(MouseEvent.CLICK, speedButton_clickHandler);
			
        }

        protected function enterButton_clickHandler(event:MouseEvent):void
        {
            // TODO Auto-generated method stub

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
            var buildProxy:BuildProxy = ApplicationFacade.getProxy(BuildProxy);
            _buildVO = buildProxy.getBuild(value);
            _KeJiBuild = buildProxy.getBuild(BuildTypeEnum.KEJI);

            var userInfoVO:UserInfoVO = UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			
			if(userInfoVO.level>=4)
			{
				fullView();
			}
            var curViewInfoVO:ViewInfoVO = ContentProxy(ApplicationFacade.getProxy(ContentProxy)).getUpBuildInfo(value, _buildVO.level);
            var nextViewInfoVO:ViewInfoVO
            if (_buildVO.level == 4)
			{
                nextViewInfoVO = curViewInfoVO;
			}
            else
                nextViewInfoVO = ContentProxy(ApplicationFacade.getProxy(ContentProxy)).getUpBuildInfo(value, _buildVO.level + 1);

            userNameLabel.text = userInfoVO.nickname + "";
            switch (userInfoVO.level)
            {
                case 1:
                    shiDaiLabel.text = CenterTechTypeEnum.type_1;
                    shiDai2MC.gotoAndStop(2);
                    shiDai3MC.gotoAndStop(2);
                    shiDai4MC.gotoAndStop(2);
                    xiaoGuo3Label.text = "提升到激光科技时代";
                    break;
                case 2:
                    shiDaiLabel.text = CenterTechTypeEnum.type_2;
                    shiDai2MC.gotoAndStop(1);
                    shiDai3MC.gotoAndStop(2);
                    shiDai4MC.gotoAndStop(2);
                    xiaoGuo3Label.text = "提升到电磁科技时代";
                    break;
                case 3:
                    shiDaiLabel.text = CenterTechTypeEnum.type_3;
                    shiDai2MC.gotoAndStop(1);
                    shiDai3MC.gotoAndStop(1);
                    shiDai4MC.gotoAndStop(2);
                    xiaoGuo3Label.text = "提升到核能科技时代";
                    break;
                case 4:
                    shiDaiLabel.text =CenterTechTypeEnum.type_4;
                    shiDai2MC.gotoAndStop(1);
                    shiDai3MC.gotoAndStop(1);
                    shiDai4MC.gotoAndStop(1);
                    xiaoGuo3Label.text = "----";
                    break;
            }
			
			if(_KeJiBuild)
            	levelLabel.text = _KeJiBuild.level + "";
			else
				levelLabel.text="0";
			
            shuiJingKuangCLLabel.text = curViewInfoVO.shuiJinCL + "";
            chuanQingCLLabel.text = curViewInfoVO.chuanQinCL + "";
            anWuZhiCLLabel.text = curViewInfoVO.anWuZhiCL + "";
            anWuzhiXHLabel.text = curViewInfoVO.anWuZhiXH + "";
            shuiJingKuangXHLabel.text = curViewInfoVO.shuiJinXH + "";
            chuanQingXHLabel.text = curViewInfoVO.chuanQinXH + "";
            xiaoGuo1Label.text = curViewInfoVO.DianNengXH + "/h --> " + nextViewInfoVO.DianNengXH + "/h";
            xiaoGuo2Label.text = curViewInfoVO.chuanQinCL + "/h --> " + nextViewInfoVO.chuanQinCL + "/h";

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
				buildType=BuildTypeEnum.CENTER;
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
