package view.mainView
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Linear;
    import com.zn.utils.ClassUtil;
    import com.zn.utils.DateFormatter;
    import com.zn.utils.StringUtil;
    
    import flash.text.TextFormat;
    
    import mx.binding.utils.BindingUtils;
    
    import ui.components.Label;
    import ui.components.ProgressBar;
    import ui.core.Component;
    
    import view.mainSence.BuildComponent;
    
    import vo.BuildInfoVo;

    public class BuildUpLoaderViewComponent extends Component
    {
        public var timeText:Label;

        public var loader:ProgressBar;

        private var _buildInfoVo:BuildInfoVo;

        private var _textFormat:TextFormat;

        private var _tweenLite:TweenLite;

        public function BuildUpLoaderViewComponent(obj:BuildComponent = null)
        {
            super(ClassUtil.getObject("view.mainView.BuildUpLoaderViewComponentSkin"));

            timeText = createUI(Label, "time_tf");
            loader = createUI(ProgressBar, "loader_mc");
            sortChildIndex();
        }

        public override function dispose():void
        {
            super.dispose();
            stopTweenLite();
        }

        public function set buildInfoVo(value:BuildInfoVo):void
        {
            _buildInfoVo = value;

            removeCWList();
            cwList.push(BindingUtils.bindSetter(eventIDChange, _buildInfoVo, "eventID"));
            cwList.push(BindingUtils.bindSetter(remainTimeChange, _buildInfoVo, "current_time"));

            var totalTime:int = _buildInfoVo.finish_time - _buildInfoVo.start_time;
            loader.percent = (_buildInfoVo.current_time - _buildInfoVo.start_time) / totalTime;
            var time:int = _buildInfoVo.remainTime;

            stopTweenLite();
            _tweenLite = TweenLite.to(loader, time, { percent: 1, ease: Linear.easeNone });
        }

        private function stopTweenLite():void
        {
            if (_tweenLite)
                _tweenLite.kill();
            _tweenLite = null;
        }

        private function eventIDChange(value:*):void
        {
            if (StringUtil.isEmpty(value))
            {
                dispose();
            }
        }

        public function remainTimeChange(value:int):void
        {
            timeText.text = DateFormatter.formatterTime(_buildInfoVo.remainTime);
        }
    }
}
