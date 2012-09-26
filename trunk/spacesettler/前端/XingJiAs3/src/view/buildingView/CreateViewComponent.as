package view.buildingView
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Linear;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.DateFormatter;
    import com.zn.utils.StringUtil;
    
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
     * 建造界面
     *
     */
    public class CreateViewComponent extends Component
    {
        public var anWuZhiXHLabel:Label; //暗物质消耗

        public var shuiJingKuangXHLabel:Label; //水晶矿消耗

        public var chuanQingXHLabel:Label; //氚氢消耗

        public var timeLabel:Label; //建造所需时间

        public var progressMC:ProgressBar; //进度条

        public var createButton:Button; //创建按钮

        public var speedButton:Button; //加速按钮

        public var closeButton:Button; //关闭按钮

        public var infoButton:Button; //信息按钮

        private var _buildVO:BuildInfoVo;
		
		private var _tweenLite:TweenLite;

        public function CreateViewComponent(skin:DisplayObjectContainer)
        {
            super(skin);
            anWuZhiXHLabel = createUI(Label, "anWuZhiXH_textField");
            shuiJingKuangXHLabel = createUI(Label, "shuiJingKuangXH_textField");
            chuanQingXHLabel = createUI(Label, "chuanQingXH_textField");
            timeLabel = createUI(Label, "time_textField");

            progressMC = createUI(ProgressBar, "progress_MC");
            progressMC.percent = 0;

            createButton = createUI(Button, "create_button");
            closeButton = createUI(Button, "close_button");
            infoButton = createUI(Button, "info_button");
            speedButton = createUI(Button, "speed_button");
            speedButton.visible = false;

            sortChildIndex();

            createButton.addEventListener(MouseEvent.CLICK, createButton_clickHandler);
            closeButton.addEventListener(MouseEvent.CLICK, closeButton_clickHandler);
            infoButton.addEventListener(MouseEvent.CLICK, infoButton_clickHandler);
            speedButton.addEventListener(MouseEvent.CLICK, speedButton_clickHandler);
        }
		
		public override function dispose():void
		{
			super.dispose();
			stopTweenLite();
		}

        protected function createButton_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new Event(BuildEvent.BUILD_EVENT));
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
            var viewInfoVO:ViewInfoVO = ContentProxy(ApplicationFacade.getProxy(ContentProxy)).getCreateBuildInfo(value);

            anWuZhiXHLabel.text = viewInfoVO.anWuZhiXH + "";
            shuiJingKuangXHLabel.text = viewInfoVO.shuiJinXH + "";
            chuanQingXHLabel.text = viewInfoVO.chuanQinXH + "";

            var buildProxy:BuildProxy = ApplicationFacade.getProxy(BuildProxy);
            _buildVO = buildProxy.getBuild(value);

            removeCWList();

            createButton.visible = speedButton.visible = false;

            if (_buildVO == null || _buildVO.isNormal) //未建造
            {
                timeLabel.text = viewInfoVO.time + MultilanguageManager.getString("timeMiao");
                createButton.visible = true;
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
		
		private function stopTweenLite():void
		{
			if (_tweenLite)
				_tweenLite.kill();
			_tweenLite = null;
		}

        private function buildComplete(value:*):void
        {
            if (StringUtil.isEmpty(value))
			{
                closeButton_clickHandler(null);
			}
        }

        public function remainTimeChange(value:int):void
        {
            if (_buildVO.remainTime > 10)
                speedButton.visible = true;
            else
                speedButton.visible = false;

            timeLabel.text = DateFormatter.formatterTime(_buildVO.remainTime) + MultilanguageManager.getString("timeMiao");
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
