package view.groupFight
{
	import com.zn.utils.ClassUtil;
	
	import events.groupFight.GroupFightEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	
	import proxy.groupFight.GroupFightProxy;
	
	import ui.components.Button;
	import ui.components.Container;
	import ui.core.Component;
	import ui.managers.SystemManager;
	import ui.utils.DisposeUtil;
	
	import vo.groupFight.GroupFightVo;
	
	public class GroupFightMapComponent extends Component
	{
		public var rightBtn:Button;
		public var mapShowComp:Component;
		public var leftBtn:Button;
		
		public var container:Sprite;
		
		private var _comp:GroupFightComponent;
		private var _senceComp:GroupFightSenceComponent;
		
		private var _starVo:GroupFightVo;
		
		private var _rect:Sprite;
		
		private var _point:Point;
		private var _point2:Point;
		private var _pointList:Array=[];
		
		private var _proxy:GroupFightProxy;
		public function GroupFightMapComponent()
		{
			super(ClassUtil.getObject("view.GroupFightMapSkin"));
			_rect=new Sprite();
			_proxy=ApplicationFacade.getProxy(GroupFightProxy);
			
			rightBtn=createUI(Button,"rightBtn");
			rightBtn.visible=false;
			mapShowComp=createUI(Component,"mapShowMC");
			sortChildIndex();
			
			leftBtn=mapShowComp.createUI(Button,"leftBtn");
			container=mapShowComp.getSkin("container");
			mapShowComp.sortChildIndex();
			
			setMap();
			
//			setRectPosition(new Point(_proxy.myStarVo.x,_proxy.myStarVo.y));
			
			rightBtn.addEventListener(MouseEvent.CLICK,rightBtn_clickHandler);
			leftBtn.addEventListener(MouseEvent.CLICK,leftBtn_clickHandler);
			
		}
		
//		private function removeAllItem():void
//		{
//			while (container.num > 0)
//				DisposeUtil.dispose(container.removeAt(0));
//		}
		
		public function updataMap():void
		{
			var starArr:Array=_proxy.starArr;//
			for(var i:int=0;i<starArr.length;i++)
			{
				_starVo=starArr[i];
				_starVo=_proxy.creadLinesVo(_starVo);
				for(var j:int=0;j<_pointList.length;j++)
				{
					var star:GroupFightMapPointComponent=_pointList[j] as GroupFightMapPointComponent;
					if(star.key.name==_starVo.name)
					{
						star.key=_starVo;
					}
					
					star.setPointColor(star.key);
				}
				
			}
		}
		
		private function setMap():void
		{
//			removeAllItem();
			_pointList=[];
			
			var starArr:Array=GroupFightProxy(ApplicationFacade.getProxy(GroupFightProxy)).starArr;//
			for(var i:int=0;i<starArr.length;i++)
			{
				_starVo=starArr[i];
				var point:GroupFightMapPointComponent=new GroupFightMapPointComponent();
				point.key=_starVo;
				point.x=_starVo.x/rateW();
				point.y=_starVo.y/rateH();
				
				point.setPointColor(_starVo);
				
				container.addChild(point);
				
				point.addEventListener(MouseEvent.CLICK,pointClickHandler);
				_pointList.push(point);
			}
			
			container.addChild(drawRect());
		}
		
		private function drawRect():Sprite
		{
			_rect.graphics.lineStyle(2,0xff0000,1);
			_rect.graphics.drawRect(0,0,rectW(this.width+50),rectH(this.height+50));
			_rect.graphics.endFill();
			
			return _rect;
		}
		
		private function setRectPosition(p:Point):void
		{
			_rect.x=p.x/(rateW()*1.5);
			_rect.y=p.y/(rateH()*1.5);
		}
		
		public function updateRectXY(point:Point):void
		{
			_rect.x=-point.x/(rateW()*6);
			_rect.y=-point.y/(rateH()*6);
		}
		
		private function rateW():Number
		{
			var rateOfWidth:Number=0;
			rateOfWidth=SystemManager.rootStage.width/(this.width+50);
			
			return rateOfWidth;
		}
		private function rateH():Number
		{
			var rateOfHeight:Number=0;
			rateOfHeight=SystemManager.rootStage.height/(this.height+50);
			
			return rateOfHeight;
		}
		
		private function rectW(x:Number):Number
		{
			var widthOfRect:Number;
			var rateOfRectW:Number=0;
			rateOfRectW=SystemManager.rootStage.width/(SystemManager.rootStage.stageWidth+50);
			widthOfRect=x/rateOfRectW;
			
			return widthOfRect;
		}
		private function rectH(y:Number):Number
		{
			var heightOfRect:Number;
			var rateOfRectH:Number=0;
			rateOfRectH=SystemManager.rootStage.height/(SystemManager.rootStage.stageHeight+50);
			heightOfRect=y/rateOfRectH;
			
			return heightOfRect;
		}
		
		public function rectMoveHandler(event:GroupFightEvent):void
		{
			_point=event.point;
			_point2=event.point2;
			updateRectXY(event.point);
		}
		
		protected function pointClickHandler(event:MouseEvent):void
		{
			_rect.x=(event.currentTarget as GroupFightMapPointComponent).x-_rect.width/2;
			_rect.y=(event.currentTarget as GroupFightMapPointComponent).y-_rect.height/2;
			
			dispatchEvent(new GroupFightEvent(GroupFightEvent.SENCECHANGE_EVENT,0,_point,_point2,(event.currentTarget as GroupFightMapPointComponent).key));
		}
		
		protected function leftBtn_clickHandler(event:MouseEvent):void
		{
			rightBtn.visible=true;
			mapShowComp.visible=false;
		}
		
		protected function rightBtn_clickHandler(event:MouseEvent):void
		{
			mapShowComp.visible=true;
			rightBtn.visible=false;
		}
	}
}