package view.plantioid.topInfo
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.zn.multilanguage.MultilanguageManager;
	
	import events.plantioid.PlantioidEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.ui.KeyboardType;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.plantioid.PlantioidProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;

	/**
	 *顶部信息
	 * @author zn
	 *
	 */
	public class TopInfoComponent extends Component
	{
		public var pointYLabel:Label;

		public var pointXLabel:Label;

		public var jumpInputComp:JumpInputComponent;

		public var currentAreaSp:Sprite;

		public var jumpBtn:Button;

		public var MyXinXinBtn:Button;

		public var leftBnt:Button;

		public var rightBtn:Button;

		public var upBtn:Button;
		
		public var downBtn:Button;

		private var _plantioidProxy:PlantioidProxy;

		private var _hideY:Number;

		private var _showY:Number;

		private var _isShowJump:Boolean=false;

		private var _jumpTweenLite:TweenLite;

		public function TopInfoComponent(skin:DisplayObjectContainer)
		{
			super(skin);

			pointYLabel=createUI(Label, "pointYLabel");
			pointXLabel=createUI(Label, "pointXLabel");

			jumpInputComp=createUI(JumpInputComponent, "jumpInputComp");

			jumpBtn=createUI(Button, "jumpBtn");
			MyXinXinBtn=createUI(Button, "MyXinXinBtn");

			currentAreaSp=getSkin("currentAreaSp");

			upBtn=createUI(Button,"upBtn");
			downBtn=createUI(Button,"downBtn");
			leftBnt=createUI(Button,"leftBtn");
			rightBtn=createUI(Button,"rightBtn");
			
			sortChildIndex();
			
			upBtn.toolTipData=downBtn.toolTipData=leftBnt.toolTipData=rightBtn.toolTipData=MultilanguageManager.getString("plantioidSwicthPointXY");
			upBtn.visible=downBtn.visible=leftBnt.visible=rightBtn.visible=false;

			_plantioidProxy=ApplicationFacade.getProxy(PlantioidProxy);
			cwList.push(BindingUtils.bindSetter(pointLabelChange, _plantioidProxy, "currentX"));
			cwList.push(BindingUtils.bindSetter(pointLabelChange, _plantioidProxy, "currentY"));

			_hideY=jumpInputComp.y - jumpInputComp.height;
			_showY=jumpInputComp.y;

			jumpInputComp.y=_hideY;

			jumpBtn.addEventListener(MouseEvent.CLICK, jumpBtn_clickHandler);
			MyXinXinBtn.addEventListener(MouseEvent.CLICK, myPlant_clickHandler);
			
			upBtn.addEventListener(MouseEvent.CLICK,upBtn_clickHandler);
			downBtn.addEventListener(MouseEvent.CLICK,downBtn_clickHandler);
			leftBnt.addEventListener(MouseEvent.CLICK,leftBnt_clickHandler);
			rightBtn.addEventListener(MouseEvent.CLICK,rightBtn_clickHandler);
			
			addEventListener(KeyboardEvent.KEY_DOWN,key_downHandler);
		}
		
		public override function dispose():void
		{
			super.dispose();

			if (_jumpTweenLite)
				_jumpTweenLite.kill();
			_jumpTweenLite=null;
		}


		private function pointLabelChange(value:*):void
		{
			pointXLabel.text="x:" + _plantioidProxy.currentX;
			pointYLabel.text="y:" + _plantioidProxy.currentY;

			jumpInputComp.enterX=_plantioidProxy.currentX;
			jumpInputComp.enterY=_plantioidProxy.currentY;
			
			upBtn.visible=downBtn.visible=leftBnt.visible=rightBtn.visible=false;
			
			if(_plantioidProxy.currentX>1)
				leftBnt.visible=true;
			if(_plantioidProxy.currentY>1)
				upBtn.visible=true;
			if(_plantioidProxy.currentX<_plantioidProxy.maxX)
				rightBtn.visible=true;
			if(_plantioidProxy.currentY<_plantioidProxy.maxY)
				downBtn.visible=true;
		}

		protected function myPlant_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new PlantioidEvent(PlantioidEvent.MY_PLANT_EVENT));
		}

		protected function key_downHandler(event:KeyboardEvent):void
		{
			if(event.keyCode==Keyboard.ENTER)
				jumpBtn_clickHandler(null);
		}
		
		protected function jumpBtn_clickHandler(event:MouseEvent):void
		{
			if (!_isShowJump)
			{
				_isShowJump=true;
				_jumpTweenLite=TweenLite.to(jumpInputComp, 0.3, {y: _showY, ease: Linear.easeNone});
			}
			else
			{
				_isShowJump=false;
				_jumpTweenLite=TweenLite.to(jumpInputComp, 0.3, {y: _hideY, ease: Linear.easeNone});
				dispatchEvent(new PlantioidEvent(PlantioidEvent.JUMP_EVENT, "", new Point(jumpInputComp.enterX, jumpInputComp.enterY)));
			}
		}
		
		protected function rightBtn_clickHandler(event:MouseEvent):void
		{
			var x:Number=_plantioidProxy.currentX+1;
			var y:Number=_plantioidProxy.currentY;
			
			dispatchEvent(new PlantioidEvent(PlantioidEvent.JUMP_EVENT, "", new Point(x, y)));			
		}
		
		protected function leftBnt_clickHandler(event:MouseEvent):void
		{
			var x:Number=_plantioidProxy.currentX-1;
			var y:Number=_plantioidProxy.currentY;
			
			dispatchEvent(new PlantioidEvent(PlantioidEvent.JUMP_EVENT, "", new Point(x, y)));			
		}
		
		protected function downBtn_clickHandler(event:MouseEvent):void
		{
			var x:Number=_plantioidProxy.currentX;
			var y:Number=_plantioidProxy.currentY+1;
			
			dispatchEvent(new PlantioidEvent(PlantioidEvent.JUMP_EVENT, "", new Point(x, y)));		
			
		}
		
		protected function upBtn_clickHandler(event:MouseEvent):void
		{
			var x:Number=_plantioidProxy.currentX;
			var y:Number=_plantioidProxy.currentY-1;
			
			dispatchEvent(new PlantioidEvent(PlantioidEvent.JUMP_EVENT, "", new Point(x, y)));		
		}
	}
}
