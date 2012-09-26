package view.plantioid
{
    import com.zn.utils.ClassUtil;
    
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.errors.InvalidSWFError;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    import mx.binding.utils.BindingUtils;
    
    import proxy.plantioid.PlantioidProxy;
    
    import ui.core.Component;
    import ui.managers.SystemManager;
    
    import view.login.NameInforComponent;
    import view.plantioid.plantioidInfo.InfoComponent;
    import view.plantioid.topInfo.TopInfoComponent;
    
    import vo.plantioid.FortsInforVO;

    /**
     *小星星带
     * @author zn
     *
     */
    public class PlantioidComponent extends Component
    {
        public const OUT_RANG_SIZE:Number = 600;

        public var topInfoComp:TopInfoComponent;

        public var xingQiu2:Sprite;

        public var xingQiu1:Sprite;

        public var xingxingEffect:Sprite;

		public var bgSp:Sprite;
		
        public var infoComp:InfoComponent;

        private var plantCompList:Array = [];

        private var _plantioidProxy:PlantioidProxy;

        public var rangeRect:Rectangle;

        private var _downMovePoint:Point;

        private var _rangePoint:Point;

        private var _selectedPlantioidComp:PlantioidXingQiuComponent;

        public function PlantioidComponent()
        {
            super(ClassUtil.getObject("plantioid.PlantioidSkin"));

            xingxingEffect = getSkin("xingxingEffect");

            xingQiu1 = getSkin("xingQiu1");
            xingQiu2 = getSkin("xingQiu2");
            topInfoComp = createUI(TopInfoComponent, "topInfoComp");

            infoComp = createUI(InfoComponent, "infoComp");
            infoComp.visible = false;

			bgSp=getSkin("bgSp");
			bgSp.mouseEnabled=true;
			bgSp.addEventListener(MouseEvent.CLICK,bgSp_clickHandler);
            sortChildIndex();

            xingxingEffect.addChild(new BGEffectComponent());

            scrollRect = new Rectangle(0, 0, SystemManager.rootStage.stageWidth, SystemManager.rootStage.stageHeight);

            var stage:Stage = SystemManager.rootStage;
            var w:Number = stage.stageWidth * 0.75;
            var h:Number = stage.stageHeight * 0.75;
            rangeRect = new Rectangle(-stage.stageWidth * 0.25, -stage.stageHeight * 0.25, w * 2, h * 2);

            _rangePoint = new Point();
            _rangePoint.x -= xingxingEffect.x = xingQiu1.x = xingQiu2.x = rangeRect.x;
            _rangePoint.y -= xingxingEffect.y = xingQiu1.y = xingQiu2.y = rangeRect.y;

            _plantioidProxy = ApplicationFacade.getProxy(PlantioidProxy);
            cwList.push(BindingUtils.bindSetter(plantioidListChange, _plantioidProxy, "plantioidList"));

            SystemManager.rootStage.addEventListener(MouseEvent.MOUSE_MOVE, stageMouseMoveHandler);
        }
		
        public override function dispose():void
        {
            super.dispose();
            plantCompList = null;
            SystemManager.rootStage.removeEventListener(MouseEvent.MOUSE_MOVE, stageMouseMoveHandler);
        }

        private function plantioidListChange(value:*):void
        {
            var plantInfoComp:PlantioidXingQiuComponent;
            for (var i:int = 0; i < plantCompList.length; i++)
            {
                plantInfoComp = plantCompList[i];
                plantInfoComp.dispose();
            }

            plantCompList = [];

            var rangIndex:int;
            var x:Number;
            var y:Number;

            for (var j:int = 0; j < _plantioidProxy.plantioidList.length; j++)
            {
                plantInfoComp = new PlantioidXingQiuComponent();
                plantInfoComp.platioidVO = _plantioidProxy.plantioidList[j];

                do
                {
                    plantInfoComp.x = Math.random() * rangeRect.width + rangeRect.x;
                    plantInfoComp.y = Math.random() * rangeRect.height + rangeRect.y;
                } while (hasCollide(plantInfoComp));

                rangIndex = Math.random() * 2 + 1;
                if (rangIndex == 1)
                    xingQiu1.addChild(plantInfoComp);
                else
                    xingQiu2.addChild(plantInfoComp);

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
            if (event.buttonDown)
            {
                if (_downMovePoint == null)
                    _downMovePoint = new Point(event.stageX, event.stageY);

                var newP:Point = new Point(event.stageX, event.stageY);
                var disP:Point = newP.subtract(_downMovePoint);

                xingxingEffect.x += disP.x * 0.1;
                xingxingEffect.y += disP.y * 0.1;

                xingQiu1.x += disP.x * 0.3;
                xingQiu1.y += disP.y * 0.3;

                xingQiu2.x += disP.x * 0.5;
                xingQiu2.y += disP.y * 0.5;

                _rangePoint.x -= disP.x * 0.3;
                _rangePoint.y -= disP.y * 0.3;

                _downMovePoint = newP;
				updateInfoPoint();
            }
            else
            {
                _downMovePoint = null;
            }
        }

        private function get isMoveOut():Boolean
        {
            var w:Number = SystemManager.rootStage.stageWidth;
            var h:Number = SystemManager.rootStage.stageHeight;

            if (_rangePoint.x < -OUT_RANG_SIZE ||
                _rangePoint.y < -OUT_RANG_SIZE ||
                (_rangePoint.x + w) > (rangeRect.width + OUT_RANG_SIZE) ||
                (_rangePoint.y + h) > (rangeRect.height + OUT_RANG_SIZE))
                return true;
            return false;
        }

        protected function plantInfoComp_clickHandler(event:MouseEvent):void
        {
            _selectedPlantioidComp = event.currentTarget as PlantioidXingQiuComponent;
			updateInfoPoint();
            infoComp.visible = true;
        }

		private function updateInfoPoint():void
		{
			if(_selectedPlantioidComp)
			{
				var p:Point = _selectedPlantioidComp.localToGlobal(new Point());
				infoComp.x = p.x;
				infoComp.y = p.y;
			}
		}
		
		protected function bgSp_clickHandler(event:MouseEvent):void
		{
			_selectedPlantioidComp=null;
			infoComp.visible = false;
		}
    }
}
