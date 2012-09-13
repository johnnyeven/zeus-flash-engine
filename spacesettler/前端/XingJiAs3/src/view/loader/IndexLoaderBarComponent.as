package view.loader
{
    import com.zn.utils.ClassUtil;
    
    import flash.display.MovieClip;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.utils.getDefinitionByName;

    /**
     *Index加载界面
     * @author zn
     *
     */
    public class IndexLoaderBarComponent extends Sprite
    {
        public var titleInfoTF:TextField;

        public var labelTF:TextField;

        public var barMC:MovieClip;

        public var trackMC:MovieClip;

        protected var _barMask:Shape;

        private var _percent:Number;
		
		public var autoSetPercentLabel:Boolean=true;

        public function IndexLoaderBarComponent()
        {
            super();

			var classUI:Class=Class(getDefinitionByName("view.loader.IndexLoaderBarSkin"));
			var skin:Sprite=new classUI();
			addChild(skin);
			
			trackMC=skin.getChildByName("trackMC") as MovieClip;
			barMC=skin.getChildByName("barMC") as MovieClip;
			labelTF=skin.getChildByName("labelTF") as TextField;
			titleInfoTF=skin.getChildByName("titleInfoTF") as TextField;
			
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
            titleInfoTF.text = title;
        }

		public function set percentInfo(str:String):void
		{
			labelTF.text=str;
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
			
			if(autoSetPercentLabel)
				labelTF.text=int(percent*100)+" %";
        }
    }
}
