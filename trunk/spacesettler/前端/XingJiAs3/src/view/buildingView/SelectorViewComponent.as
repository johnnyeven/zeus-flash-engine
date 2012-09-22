package view.buildingView
{
    import com.greensock.TimelineLite;
    import com.greensock.TweenLite;
    import com.zn.multilanguage.MultilanguageManager;
    import com.zn.utils.ClassUtil;
    import com.zn.utils.StringUtil;
    
    import events.buildingView.AddSelectorViewEvent;
    import events.buildingView.AddViewEvent;
    import events.buildingView.UpLevelEvent;
    
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.sensors.Accelerometer;
    import flash.text.TextField;
    
    import ui.components.Button;
    import ui.core.Component;

    public class SelectorViewComponent extends Component
    {
        public var upButton:SelectorButtonComponent;

        public var downButton:SelectorButtonComponent;

        public var leftButton:SelectorButtonComponent;

        public var rightButton:SelectorButtonComponent;

        private var sp:Sprite;

        private var oldPoint:Point = new Point(-80, -30);
		public var buildType:int;

		private var timeLine:TimelineLite;

        public function SelectorViewComponent(event:AddSelectorViewEvent)
        {
            super(null);

            sp = new Sprite();
            addChild(sp);
            sp.addChild(ClassUtil.getObject("Build_ClickEffect"));
			
			var line:Sprite=ClassUtil.getObject("Build_ClickEffect_Line");
			sp.addChild(line);
			
			line.getChildByName("top").visible=line.getChildByName("right").visible=line.getChildByName("left").visible=line.getChildByName("down").visible=false;
			
			
            switch (event.count)
            {
                case 4:
                {
                    leftButton = new SelectorButtonComponent();
                    leftButton.text = event.leftLabel;
                    leftButton.x = oldPoint.x;
                    leftButton.y = oldPoint.y;
                    leftButton.addEventListener(MouseEvent.CLICK, leftButton_clickHandler);
					addChild(leftButton);
					line.getChildByName("left").visible=true;
                }
                case 3:
                {
                    rightButton = new SelectorButtonComponent();
                    rightButton.text = event.rightLabel;
                    rightButton.x = oldPoint.x;
                    rightButton.y = oldPoint.y;
                    rightButton.addEventListener(MouseEvent.CLICK, rightButton_clickHandler);
					addChild(rightButton);
					line.getChildByName("right").visible=true;
                }
                case 2:
                {
                    upButton = new SelectorButtonComponent();
                    upButton.text = event.upLabel;
                    upButton.x = oldPoint.x;
                    upButton.y = oldPoint.y;
                    upButton.addEventListener(MouseEvent.CLICK, upButton_clickHandler);
					addChild(upButton);
					line.getChildByName("top").visible=true;

                    downButton = new SelectorButtonComponent();
                    downButton.infoSp.visible = true;
                    downButton.x = oldPoint.x;
                    downButton.y = oldPoint.y;
                    downButton.addEventListener(MouseEvent.CLICK, downButton_clickHandler);
					addChild(downButton);
					line.getChildByName("down").visible=true;
					
                    break;
                }
            }

            mouseChildren = mouseEnabled = false;
        }

		public override function dispose():void
		{
			super.dispose();
			
			if(timeLine)
				timeLine.kill();
		}
		
        public function start():void
        {
			if(timeLine)
				timeLine.kill();
			
            timeLine = new TimelineLite({ onComplete: function():void
            {
                mouseChildren = mouseEnabled = true;
            }});

            if (upButton)
                timeLine.insert(TweenLite.to(upButton, 0.5, { y: -111 }));
            if (downButton)
                timeLine.insert(TweenLite.to(downButton, 0.5, { y: 41 }));
            if (rightButton)
                timeLine.insert(TweenLite.to(rightButton, 0.5, { x: 62 }));
            if (leftButton)
                timeLine.insert(TweenLite.to(leftButton, 0.5, { x: -224 }));
        }
		
		public function endClose():void
		{
			if(timeLine)
				timeLine.kill();
			
			timeLine = new TimelineLite({ onComplete: function():void
			{
				mouseChildren = mouseEnabled = false;
			}});
			
			if (upButton)
				timeLine.insert(TweenLite.to(upButton, 0.5, { y: 0 }));
			if (downButton)
				timeLine.insert(TweenLite.to(downButton, 0.5, { y: 0 }));
			if (rightButton)
				timeLine.insert(TweenLite.to(rightButton, 0.5, { x: 0 }));
			if (leftButton)
				timeLine.insert(TweenLite.to(leftButton, 0.5, { x: 0 }));
		}

        protected function upButton_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new AddViewEvent(AddViewEvent.ADDUPVIEW_EVENT,buildType));
        }

        protected function downButton_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new AddViewEvent(AddViewEvent.ADDINFOVIEW_EVENT,buildType));
        }

        protected function leftButton_clickHandler(event:MouseEvent):void
        {
            // TODO Auto-generated method stub

        }

        protected function rightButton_clickHandler(event:MouseEvent):void
        {
            // TODO Auto-generated method stub

        }
    }
}
