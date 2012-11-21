package view.groupFight
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.zn.multilanguage.MultilanguageManager;
	
	import enum.groupFightEnum.GroupFightEnum;
	
	import events.groupFight.GroupFightEvent;
	import events.plantioid.PlantioidEvent;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import proxy.groupFight.GroupFightProxy;
	
	import ui.core.Component;
	import ui.managers.SystemManager;
	
	import view.groupFight.GroupFightStarComponent;
	import view.plantioid.BGEffectComponent;
	import view.plantioid.PlantioidXingQiuComponent;
	
	import vo.groupFight.GroupFightVo;
	import vo.groupFight.RewardsStarVo;
	
	public class GroupFightSenceComponent extends Component
	{
		public static const SELECTED_XING_QIU_CHANGE_EVENT:String = "SELECTED_XING_QIU_CHANGE_EVENT";
		
		public static const OUT_RANG_SIZE:Number = 300;
		
		public var xingQiuEffect:Sprite;
		
		public var bgEffectComp:Sprite;
		
		public var xingQiu1:Sprite;
		
		public var plantCompList:Array = [];
		
		public var rangeRect:Rectangle;
		
		private var _downMovePoint:Point;
		
		private var _rangePoint:Point;
		
		public var selectedPlantXingQiuComp:GroupFightStarComponent;
		
		private var _currtentStar:GroupFightStarComponent;
		private var groupFightProxy:GroupFightProxy;
		
		public function GroupFightSenceComponent()
		{
			super(null);
			
			groupFightProxy=ApplicationFacade.getProxy(GroupFightProxy);
			
			_rangePoint=new Point();
			xingQiuEffect = new Sprite();
			addChild(xingQiuEffect);
			
			bgEffectComp = new BGEffectComponent();
			xingQiuEffect.addChild(bgEffectComp);
			
			xingQiu1 = new Sprite();
			xingQiuEffect.addChild(xingQiu1);			
			
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
		
		public function clearXingQiu1():void
		{
			while(xingQiu1.numChildren>0)
			{
				xingQiu1.removeChildAt(0);
			}
		}
		
		public function changeStar(listArr:Array):void
		{
			for(var i:int=0;i<listArr.length;i++)
			{
				var starVo:GroupFightVo=listArr[i] as GroupFightVo;
				starVo=groupFightProxy.creadLinesVo(starVo);
				for(var j:int=0;j<plantCompList.length;j++)
				{
					var star:GroupFightStarComponent=plantCompList[j] as GroupFightStarComponent;
					if(star.platioidVO.name==starVo.name)
					{
						starVo.index=star.platioidVO.index;
						star.platioidVO=starVo;
					}
				}
				
			}
		}
		
		public function setPlantList(plantVOList:Array):void
		{			
//			_rangePoint.x -= bgEffectComp.x = xingQiu1.x  = -rangeRect.x;
//			_rangePoint.y -= bgEffectComp.y = xingQiu1.y  = -rangeRect.y;			
			for(var i:int=0; i<plantVOList.length; i++)
			{
				var starVo1:GroupFightVo=plantVOList[i] as GroupFightVo;
				var starVo:GroupFightVo=groupFightProxy.creadLinesVo(starVo1);
				var star:GroupFightStarComponent;
				if(starVo.name==GroupFightEnum.ZHU_STAR)
				{
					star= new GroupFightStarComponent(GroupFightEnum.MAINSTAR_TYPE);
					star.rewardsStarVo=groupFightProxy.star5000;
				}else
				{
					star= new GroupFightStarComponent();
				}
				if(starVo.name==GroupFightEnum.ZIYUAN1_STAR)
					star.rewardsStarVo=groupFightProxy.star4001;
				if(starVo.name==GroupFightEnum.ZIYUAN2_STAR)
					star.rewardsStarVo=groupFightProxy.star4002;
				if(starVo.name==GroupFightEnum.ZIYUAN3_STAR)
					star.rewardsStarVo=groupFightProxy.star4003;
				star.platioidVO = starVo;
				star.x=starVo.x;
				star.y=starVo.y;	
				plantCompList[i]=star;
				drawLine(starVo);
				
				xingQiu1.addChild(star);
				star.addEventListener(MouseEvent.CLICK, plantInfoComp_clickHandler);
			}
		}
		
		
		
		private function drawLine(starVo:GroupFightVo):void
		{
			xingQiu1.graphics.lineStyle(0,0xffffff,1);
			var point1:Point=new Point(starVo.x,starVo.y);
			for(var i:int=0;i<starVo.lines.length;i++)
			{
				var stVo1:GroupFightVo=starVo.lines[i] as GroupFightVo;	
				var point2:Point=new Point(stVo1.x,stVo1.y);
				BrokenLine.drawDashed(xingQiu1.graphics,point1,point2,5,10);
//				xingQiu1.graphics.moveTo(starVo.x,starVo.y);
//				xingQiu1.graphics.lineTo(stVo1.x,stVo1.y);							
			}
		}			
		
		
		protected function stageMouseMoveHandler(event:MouseEvent):void
		{
			if (GroupFightComponent.MOUSE_ENABLED)
			{
				if (event.buttonDown)
				{
					if (_downMovePoint == null)
						_downMovePoint = new Point(event.stageX, event.stageY);
					
					var newP:Point = new Point(event.stageX, event.stageY);
					var disP:Point = newP.subtract(_downMovePoint);
					
					_rangePoint.x -= disP.x * 0.3;
					_rangePoint.y -= disP.y * 0.3;
					
					bgEffectComp.x += disP.x * 0.1;
					bgEffectComp.y += disP.y * 0.1;
					
					xingQiu1.x += disP.x * 0.3;
					xingQiu1.y += disP.y * 0.3;
					
					_downMovePoint = newP;
					dispatchEvent(new GroupFightEvent(GroupFightEvent.SENCE_EVENT,0,new Point(xingQiu1.x,xingQiu1.y),new Point(disP.x,disP.y)));
				}
				else
				{
					_downMovePoint = null;
				}
			}
		}
		
		public function setSenceCenter(starVO:GroupFightVo):void
		{
			var distenceX:Number=0;
			var distenceY:Number=0;
			
			distenceX=starVO.x-SystemManager.rootStage.stageWidth/2;
			distenceY=starVO.y-SystemManager.rootStage.stageHeight/2;
			
			xingQiu1.x = - distenceX;
			xingQiu1.y = - distenceY;
			
//			dispatchEvent(new GroupFightEvent(GroupFightEvent.SENCE_EVENT,0,new Point(xingQiu1.x,xingQiu1.y),new Point(distenceX,distenceY)));
		}
		
		protected function plantInfoComp_clickHandler(event:MouseEvent):void
		{
			selectedPlantXingQiuComp = event.currentTarget as GroupFightStarComponent;
			currtentStar=selectedPlantXingQiuComp;			
			dispatchEvent(new Event(SELECTED_XING_QIU_CHANGE_EVENT));
		}
		
		public function addScrollRect():void
		{
			scrollRect = new Rectangle(0, 0, SystemManager.rootStage.stageWidth, SystemManager.rootStage.stageHeight);
		}
		
		public function removeScrollRect():void
		{
			scrollRect = null;
		}

		public function get currtentStar():GroupFightStarComponent
		{
			return _currtentStar;
		}

		public function set currtentStar(value:GroupFightStarComponent):void
		{
			if(_currtentStar)
			{
				_currtentStar.isNotClick();
				_currtentStar.clearSp();
			}
			if(value)
			{
				_currtentStar = value;
				_currtentStar.isClick();				
			}
		}

	}
}
