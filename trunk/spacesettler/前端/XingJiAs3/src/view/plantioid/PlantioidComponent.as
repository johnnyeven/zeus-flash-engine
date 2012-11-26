package view.plantioid
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.BitmapUtil;
	import com.zn.utils.ClassUtil;
	import com.zn.utils.SoundUtil;
	import com.zn.utils.UIDUtil;
	
	import enum.FontEnum;
	import enum.SoundEnum;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.errors.InvalidSWFError;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.plantioid.PlantioidProxy;
	
	import ui.components.Label;
	import ui.core.Component;
	import ui.managers.SystemManager;
	import ui.utils.DisposeUtil;
	import ui.utils.UIUtil;
	
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
		public static var MOUSE_ENABLED:Boolean=true;

		public var topInfoComp:TopInfoComponent;

		public var xingQiuSp:Sprite;

		public var bgSp:Sprite;

		public var infoComp:InfoComponent;

		private var _selectedPlantioidComp:PlantioidXingQiuComponent;

		private var _currentPlantSenceComp:PlantSenceComponent;

		private var _plantProxy:PlantioidProxy;

		private var _newPlantComp:PlantSenceComponent;

		private var dragInfoLabel:Label;

		private var comp:PlantSenceComponent;

		public function PlantioidComponent()
		{
			super(ClassUtil.getObject("plantioid.PlantioidSkin"));

			MOUSE_ENABLED=true;
			topInfoComp=createUI(TopInfoComponent, "topInfoComp");

			infoComp=createUI(InfoComponent, "infoComp");
			infoComp.visible=false;

			bgSp=getSkin("bgSp");
			bgSp.mouseEnabled=true;
			bgSp.addEventListener(MouseEvent.CLICK, bgSp_clickHandler);

			xingQiuSp=getSkin("xingQiuSp");

			sortChildIndex();

			scrollRect=new Rectangle(0, 0, SystemManager.rootStage.stageWidth, SystemManager.rootStage.stageHeight);

			_plantProxy=ApplicationFacade.getProxy(PlantioidProxy);
			switchPlantSence();

			showDragInfoTips();

			SystemManager.rootStage.addEventListener(MouseEvent.MOUSE_MOVE, stageMouseMoveHandler);
		}
		
		public override function dispose():void
		{
			bgSp.removeEventListener(MouseEvent.CLICK, bgSp_clickHandler);
			comp.removeEventListener(PlantSenceComponent.SELECTED_XING_QIU_CHANGE_EVENT, selectedPlantXingQiuChangeHandler);
			comp.removeEventListener(PlantSenceComponent.UPDATE_SELECTED_XING_QIU_POINT_EVENT, updateSelectedXingQiuPointHandler);
			comp.bgEffectComp.removeEventListener(MouseEvent.CLICK, bgSp_clickHandler);
			SystemManager.rootStage.removeEventListener(MouseEvent.MOUSE_MOVE, stageMouseMoveHandler);
			super.dispose();
		}

		public function switchPlantSence():void
		{
			selectedPlantioidComp=null;
			var list:Array=_plantProxy.plantioidList;

			if (!_currentPlantSenceComp)
			{
				_currentPlantSenceComp=createNewPlantSenceComp();
				_currentPlantSenceComp.setPlantList(list);
			}
			else
			{
				_newPlantComp=createNewPlantSenceComp();
				_newPlantComp.setPlantList(list);

				_newPlantComp.removeScrollRect();
				_currentPlantSenceComp.removeScrollRect();

				var newPlantBitmap:Bitmap=BitmapUtil.getBitmap(_newPlantComp.xingQiuEffect,true);
				var currentPlantBitmap:Bitmap=BitmapUtil.getBitmap(_currentPlantSenceComp.xingQiuEffect,true);

				var rect:Rectangle=_currentPlantSenceComp.xingQiuEffect.getRect(_currentPlantSenceComp.xingQiuEffect);
				currentPlantBitmap.x=rect.x;
				currentPlantBitmap.y=rect.y;

				rect=_newPlantComp.xingQiuEffect.getRect(_newPlantComp.xingQiuEffect);
				newPlantBitmap.x=rect.x;
				newPlantBitmap.y=rect.y;

				xingQiuSp.addChild(currentPlantBitmap);
				xingQiuSp.addChild(newPlantBitmap);

				_currentPlantSenceComp.visible=false;
				_newPlantComp.visible=false;

				var switchPlantSenceTweentime:TimelineLite=new TimelineLite({onComplete: switchComplete, onCompleteParams: [currentPlantBitmap, newPlantBitmap]});

				var rang:Number=PlantSenceComponent.OUT_RANG_SIZE * 2;
				var time:Number=2;
				if (_currentPlantSenceComp.plantY < _newPlantComp.plantY)
				{
					newPlantBitmap.y=_currentPlantSenceComp.height + rang;
					switchPlantSenceTweentime.insert(TweenLite.to(currentPlantBitmap, time, {y: -newPlantBitmap.y}));
					switchPlantSenceTweentime.insert(TweenLite.to(newPlantBitmap, time, {y: rect.y}));
				}
				else if (_currentPlantSenceComp.plantY > _newPlantComp.plantY)
				{
					newPlantBitmap.y=-rang - _newPlantComp.height;
					switchPlantSenceTweentime.insert(TweenLite.to(currentPlantBitmap, time, {y: -newPlantBitmap.y}));
					switchPlantSenceTweentime.insert(TweenLite.to(newPlantBitmap, time, {y: rect.y}));
				}
				else if (_currentPlantSenceComp.plantX < _newPlantComp.plantX)
				{
					newPlantBitmap.x=_currentPlantSenceComp.width + rang;
					switchPlantSenceTweentime.insert(TweenLite.to(currentPlantBitmap, time, {x: -newPlantBitmap.x}));
					switchPlantSenceTweentime.insert(TweenLite.to(newPlantBitmap, time, {x: rect.x}));
				}
				else if (_currentPlantSenceComp.plantX > _newPlantComp.plantX)
				{
					newPlantBitmap.x=-rang - _newPlantComp.width;
					switchPlantSenceTweentime.insert(TweenLite.to(currentPlantBitmap, time, {x: -newPlantBitmap.x}));
					switchPlantSenceTweentime.insert(TweenLite.to(newPlantBitmap, time, {x: rect.x}));
				}
			}
		}

		private function switchComplete(currentPlantBitmap:Bitmap, newPlantBitmap:Bitmap):void
		{
			_newPlantComp.visible=true;
			_newPlantComp.addScrollRect();
			_currentPlantSenceComp.dispose();
			_currentPlantSenceComp=_newPlantComp;
			_newPlantComp=null;

			DisposeUtil.dispose(currentPlantBitmap);
			DisposeUtil.dispose(newPlantBitmap);

			MOUSE_ENABLED=true;
		}

		/**
		 *显示拖拽提示
		 *
		 */
		private function showDragInfoTips():void
		{
			dragInfoLabel=new Label();
			dragInfoLabel.size=24;
			dragInfoLabel.fontName=FontEnum.WEI_RUAN_YA_HEI;
			dragInfoLabel.color=0xFFFFFF;
			dragInfoLabel.text=MultilanguageManager.getString("plantDragInfoTips");
			dragInfoLabel.alpha=0.7;
			dragInfoLabel.autoSize=true;
			UIUtil.centerUI(dragInfoLabel);
			
			addChild(dragInfoLabel);
		}

		protected function stageMouseMoveHandler(event:MouseEvent):void
		{
			if (event.buttonDown)
			{
				SystemManager.rootStage.removeEventListener(MouseEvent.MOUSE_MOVE, stageMouseMoveHandler);
				DisposeUtil.dispose(dragInfoLabel);
			}
		}

		private function createNewPlantSenceComp():PlantSenceComponent
		{
			comp=new PlantSenceComponent();
			comp.addEventListener(PlantSenceComponent.SELECTED_XING_QIU_CHANGE_EVENT, selectedPlantXingQiuChangeHandler);
			comp.addEventListener(PlantSenceComponent.UPDATE_SELECTED_XING_QIU_POINT_EVENT, updateSelectedXingQiuPointHandler);
			comp.bgEffectComp.addEventListener(MouseEvent.CLICK, bgSp_clickHandler);
			xingQiuSp.addChild(comp);
			comp.plantX=_plantProxy.currentX;
			comp.plantY=_plantProxy.currentY;


			return comp;
		}

		protected function selectedPlantXingQiuChangeHandler(event:Event):void
		{
			selectedPlantioidComp=_currentPlantSenceComp.selectedPlantXingQiuComp;
		}

		public function set selectedPlantioidComp(value:PlantioidXingQiuComponent):void
		{
			_selectedPlantioidComp=value;
			if (value)
			{
				SoundUtil.play(SoundEnum.scan_star,true,true);

				infoComp.plantVO=_selectedPlantioidComp.platioidVO;
				infoComp.selectedEffectMC.gotoAndPlay(1);
				_selectedPlantioidComp.setSize(infoComp.selectedEffectMC, 30);

				updateSelectedXingQiuPointHandler(null);
				infoComp.visible=true;
			}
			else
			{
				SoundUtil.stop(SoundEnum.scan_star);
				
				infoComp.plantVO=null;
				infoComp.visible=false;
			}
		}

		protected function updateSelectedXingQiuPointHandler(event:Event):void
		{
			if (_selectedPlantioidComp)
			{
				var p:Point=_selectedPlantioidComp.localToGlobal(new Point());
				infoComp.x=p.x;
				infoComp.y=p.y;
			}
		}

		protected function bgSp_clickHandler(event:MouseEvent):void
		{
			selectedPlantioidComp=null;
		}
	}
}
