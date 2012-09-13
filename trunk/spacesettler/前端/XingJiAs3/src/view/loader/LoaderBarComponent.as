package view.loader
{
    import com.zn.utils.ClassUtil;
    
    import flash.display.MovieClip;
    import flash.display.Shape;
    
    import ui.components.Label;
    import ui.core.Component;

    /**
     *加载界面
     * @author zn
     *
     */
    public class LoaderBarComponent extends Component
    {
        public var titleInfoLabel:Label;

        public var percentLabel:Label;

        public var barMC:MovieClip;

        public var trackMC:MovieClip;

        protected var _barMask:Shape;

        private var _percent:Number;

        public var autoSetPercentLabel:Boolean = true;

        public function LoaderBarComponent()
        {
            super(ClassUtil.getObject("view.loader.IndexLoaderBarSkin"));

            titleInfoLabel = createUI(Label, "titleInfoTF");
            percentLabel = createUI(Label, "labelTF");
            barMC = getSkin("barMC");
            trackMC = getSkin("trackMC");

            sortChildIndex();

            _barMask = new Shape();
            _barMask.graphics.beginFill(0, 1);
            _barMask.graphics.drawRect(0, 0, 1, 1);
            _barMask.graphics.endFill();
            addChild(_barMask);

            _barMask.x = barMC.x;
            _barMask.y = barMC.y;

            _barMask.height = barMC.height;

            barMC.mask = _barMask;
        }

        public function set titleInfo(title:String):void
        {
            titleInfoLabel.text = title;
        }

        public function set percentInfo(str:String):void
        {
            percentLabel.text = str;
        }

        public function get percent():Number
        {
            return _percent;
        }

        public function set percent(value:Number):void
        {
            _percent = value;

            if (_percent > 1)
                _percent = 1;
            else if (_percent < 0 || isNaN(_percent))
                _percent = 0;

            _barMask.width = percent * barMC.width;

            if (autoSetPercentLabel)
                percentLabel.text = int(percent * 100) + " %";
        }
    }
}
