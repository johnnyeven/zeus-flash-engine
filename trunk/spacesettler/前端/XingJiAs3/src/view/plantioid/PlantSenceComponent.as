package view.plantioid
{
    import events.plantioid.PlantioidEvent;
    
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    import ui.core.Component;
    import ui.managers.SystemManager;

    public class PlantSenceComponent extends Component
    {
        public static const SELECTED_XING_QIU_CHANGE_EVENT:String = "SELECTED_XING_QIU_CHANGE_EVENT";

        public static const UPDATE_SELECTED_XING_QIU_POINT_EVENT:String = "UPDATE_SELECTED_XING_QIU_POINT_EVENT";

        public static const OUT_RANG_SIZE:Number = 300;

        public var xingQiuEffect:Sprite;

        public var bgEffectComp:Sprite;

        public var xingQiu2:Sprite;

        public var xingQiu1:Sprite;

        private var plantCompList:Array = [];

        public var rangeRect:Rectangle;

        private var _downMovePoint:Point;

        private var _rangePoint:Point;

        public var selectedPlantXingQiuComp:PlantioidXingQiuComponent;

        public var plantX:int;

        public var plantY:int;

        public function PlantSenceComponent()
        {
            super(null);

            xingQiuEffect = new Sprite();
            addChild(xingQiuEffect);

            bgEffectComp = new BGEffectComponent();
            xingQiuEffect.addChild(bgEffectComp);

            xingQiu1 = new Sprite();
            xingQiu2 = new Sprite();

            xingQiuEffect.addChild(xingQiu1);
            xingQiuEffect.addChild(xingQiu2);

            addScrollRect();

            var stage:Stage = SystemManager.rootStage;
            var w:Number = stage.stageWidth * 0.75;
            var h:Number = stage.stageHeight * 0.75;
            rangeRect = new Rectangle(100, 100, w * 2 - 100, h * 2 - 100);

            SystemManager.rootStage.addEventListener(MouseEvent.MOUSE_MOVE, stageMouseMoveHandler);
			
        }
		
        public override function dispose():void
        {
            super.dispose();
            plantCompList = null;
            SystemManager.rootStage.removeEventListener(MouseEvent.MOUSE_MOVE, stageMouseMoveHandler);
        }

        public function setPlantList(plantVOList:Array):void
        {
            var plantInfoComp:PlantioidXingQiuComponent;
            for (var i:int = 0; i < plantCompList.length; i++)
            {
                plantInfoComp = plantCompList[i];
                plantInfoComp.dispose();
            }

            plantCompList = [];

            _rangePoint = new Point();
//            _rangePoint.x -= xingxingEffect.x = xingQiu1.x = xingQiu2.x = rangeRect.x;
//            _rangePoint.y -= xingxingEffect.y = xingQiu1.y = xingQiu2.y = rangeRect.y;

            _rangePoint.x -= bgEffectComp.x = xingQiu1.x = xingQiu2.x = -rangeRect.x;
            _rangePoint.y -= bgEffectComp.y = xingQiu1.y = xingQiu2.y = -rangeRect.y;

            var rangIndex:int;
            var x:Number;
            var y:Number;

            for (var j:int = 0; j < plantVOList.length; j++)
            {
                plantInfoComp = new PlantioidXingQiuComponent();
                plantInfoComp.platioidVO = plantVOList[j];

                rangIndex = Math.random() * 2 + 1;
                if (rangIndex == 1)
                    xingQiu1.addChild(plantInfoComp);
                else
                    xingQiu2.addChild(plantInfoComp);

                do
                {
                    plantInfoComp.x = Math.random() * rangeRect.width + rangeRect.x;
                    plantInfoComp.y = Math.random() * rangeRect.height + rangeRect.y;
                } while (hasCollide(plantInfoComp));

                plantInfoComp.addEventListener(MouseEvent.CLICK, plantInfoComp_clickHandler);

                plantCompList.push(plantInfoComp);
            }
        }

        private function hasCollide(obj:DisplayObject):Boolean
        {
            var obj1:DisplayObject;
            for (var i:int = 0; i < plantCompList.length; i++)
            {
                obj1 = plantCompList[i];
                if (obj.hitTestObject(obj1))
                    return true;
            }
            return false;
        }

        protected function stageMouseMoveHandler(event:MouseEvent):void
        {
            if (PlantioidComponent.MOUSE_ENABLED)
            {
                if (event.buttonDown)
                {
                    if (_downMovePoint == null)
                        _downMovePoint = new Point(event.stageX, event.stageY);

                    var newP:Point = new Point(event.stageX, event.stageY);
                    var disP:Point = newP.subtract(_downMovePoint);

                    if (testMoveOut(_rangePoint.x - disP.x * 0.3, _rangePoint.y - disP.y * 0.3))
                        return;

                    _rangePoint.x -= disP.x * 0.3;
                    _rangePoint.y -= disP.y * 0.3;

                    bgEffectComp.x += disP.x * 0.1;
                    bgEffectComp.y += disP.y * 0.1;

                    xingQiu1.x += disP.x * 0.3;
                    xingQiu1.y += disP.y * 0.3;

                    xingQiu2.x += disP.x * 0.5;
                    xingQiu2.y += disP.y * 0.5;

                    _downMovePoint = newP;
                    updateInfoPoint();
                }
                else
                {
                    _downMovePoint = null;
                }
            }
        }

        private function testMoveOut(x:Number, y:Number):Boolean
        {
            var w:Number = SystemManager.rootStage.stageWidth;
            var h:Number = SystemManager.rootStage.stageHeight;

            var newX:int = plantX;
            var newY:int = plantY;
            var out:Boolean = false;

            if (x < -OUT_RANG_SIZE)
            {
                newX = Math.max(1, newX - 1);
                out = true;
            }
            else if (y < -OUT_RANG_SIZE)
            {
                newY = Math.max(1, newY - 1);
                out = true;
            }
            else if ((x + w) > (rangeRect.width + OUT_RANG_SIZE))
            {
                newX = newX + 1;
                out = true;
            }
            else if ((y + h) > (rangeRect.height + OUT_RANG_SIZE))
            {
                newY = newY + 1;
                out = true;
            }

            dispatchEvent(new PlantioidEvent(PlantioidEvent.JUMP_EVENT, "", new Point(newX, newY)));
            return out;
        }

        protected function plantInfoComp_clickHandler(event:MouseEvent):void
        {
            selectedPlantXingQiuComp = event.currentTarget as PlantioidXingQiuComponent;
            dispatchEvent(new Event(SELECTED_XING_QIU_CHANGE_EVENT));
        }

        private function updateInfoPoint():void
        {
            if (selectedPlantXingQiuComp)
                dispatchEvent(new Event(UPDATE_SELECTED_XING_QIU_POINT_EVENT));
        }

        public function addScrollRect():void
        {
            scrollRect = new Rectangle(0, 0, SystemManager.rootStage.stageWidth, SystemManager.rootStage.stageHeight);
        }

        public function removeScrollRect():void
        {
            scrollRect = null;
        }
    }
}
