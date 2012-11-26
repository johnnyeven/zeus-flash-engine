package view.groupFight
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.zn.utils.ClassUtil;
	import com.zn.utils.ColorUtil;
	import com.zn.utils.PointUtil;
	import com.zn.utils.RotationUtil;
	import com.zn.utils.ScreenUtils;
	import com.zn.utils.SoundUtil;
	
	import enum.SoundEnum;
	import enum.groupFightEnum.GroupFightEnum;
	
	import events.groupFight.GroupFightEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import proxy.groupFight.GroupFightProxy;
	
	import ui.components.Button;
	import ui.core.Component;
	import ui.managers.SystemManager;
	
	import vo.groupFight.GroupFightVo;
	import vo.groupFight.LossReportVo;
	
    public class GroupFightComponent extends Component
    {
		public static var MOUSE_ENABLED:Boolean=true;
		
		public static const R:int=69;
		
		public static const LENGTH:int=881;
		
		/**
		 *背景 
		 */		
		public var bgSp:Sprite;//背景
		
		/**
		 *装星球的SP 
		 */		
		public var xingQiuSp:Sprite;
		
		/**
		 *装动画的Sp
		 */		
		public var playSp:Sprite;
		
		public var mcSp:Component;
		public var tiShiMc:Sprite;		
		public var fanHangBtn:Button;
		
		private var _selectedPlantioidComp:GroupFightStarComponent;		
		private var PlantSenceComp:GroupFightSenceComponent;
		private var groupFightProxy:GroupFightProxy;
		private var xuanQuArr:Array=[];
		private var mc:MovieClip;
		private var _timer:Timer;
        public function GroupFightComponent()
        {
            super(ClassUtil.getObject("view.GroupFightSkin"));
			
			groupFightProxy=ApplicationFacade.getProxy(GroupFightProxy);
			
			bgSp = getSkin("bgSp");
			xingQiuSp = getSkin("xingQiuSp");
			
			mcSp = createUI(Component,"mcSp");
			fanHangBtn=mcSp.createUI(Button,"fanHangBtn");
			playSp=mcSp.getSkin("playSp");
			tiShiMc=mcSp.getSkin("tiShiMc");
			
			bgSp.mouseEnabled = true;
			bgSp.addEventListener(MouseEvent.CLICK, bgSp_clickHandler);
			createNewPlantSenceComp();
			fanHangBtn.addEventListener(MouseEvent.CLICK,fanHangHandler);	
			fanHangBtn.visible=tiShiMc.visible=false;
        }		
		
		public function set selectedPlantioidComp(value:GroupFightStarComponent):void
		{			
			_selectedPlantioidComp = value;
			if (value)
			{	
				clear();
				
				SoundUtil.play(SoundEnum.scan_star,true,true);
				
				var star1:GroupFightVo=_selectedPlantioidComp.platioidVO;
				var point1:Point=new Point(star1.x,star1.y);						
				if(star1.isMine&&!value.isPaiQian)
				{
					GroupFightEnum.CURRTENT_STARVO=star1;
					for(var i:int=0;i<star1.lines.length;i++)
					{
						var star2:GroupFightVo=star1.lines[i] as GroupFightVo;
						if(star2.type!=1||star2.isMine)
						{
							var point:Point=new Point(star2.x-star1.x,star2.y-star1.y);						
							var point2:Point=new Point(star2.x,star2.y);						
							var jianTou:Sprite=ClassUtil.getObject("view.GroupFightArrowSkin") as Sprite;
													
							jianTou.rotation=-PointUtil.getRotaion(point1,point2);
							_selectedPlantioidComp.moveMc.addChild(jianTou);
							setTweenLite(jianTou,point);
							var star:GroupFightStarComponent=PlantSenceComp.plantCompList[star2.index] as GroupFightStarComponent;
							if(star2.isMine)
							{
								ColorUtil.tint(jianTou, 0x33FF00, 1);
								star.button2.visible=true;
								star.button2.addEventListener(MouseEvent.CLICK,paiQianHandler);
							}else
							{
								ColorUtil.tint(jianTou, 0xFF0000, 1);
								star.button1.visible=true;
								star.button1.addEventListener(MouseEvent.CLICK,paiQianHandler);
								
							}
							xuanQuArr.push(star);
						}
						
						
					}
				}else
				{
					clear();
					value.isPaiQian=false;
				}
				
				if(value.rewardsStarVo!=null)
				{
					var chaKanComp:GroupFightdetailsComponent=new GroupFightdetailsComponent();
					chaKanComp.updata(selectedPlantioidComp.rewardsStarVo,selectedPlantioidComp.platioidVO);
					value.chaKanSp.addChild(chaKanComp);
				}
				if(star1.type!=1)
				{
					var anNiuComp:GroupFightBtnComponent=new GroupFightBtnComponent();
					anNiuComp.x=anNiuComp.y=0;
					value.anNiuSp.addChild(anNiuComp);
					anNiuComp.chaKanBtn.addEventListener(MouseEvent.CLICK,chaKanHandler);
				}
			}
			else
				SoundUtil.stop(SoundEnum.scan_star);
		}
				
		public function setTweenLite(mc:Sprite,point:Point):void
		{
			mc.alpha=1;
			mc.x=0;
			mc.y=0;
			TweenLite.killTweensOf(mc);
			TweenLite.to(mc, 2, { x:point.x,y:point.y,alpha:0.1, ease: Linear.easeNone,onComplete: setTweenLite,onCompleteParams:[mc,point]});
		}
		
		public function changeHander():void
		{
			groupFightProxy=ApplicationFacade.getProxy(GroupFightProxy);
			PlantSenceComp.changeStar(groupFightProxy.starArr);
		}
		
		protected function paiQianHandler(event:MouseEvent):void
		{
			var star:GroupFightStarComponent=event.currentTarget.parent as GroupFightStarComponent;
			GroupFightEnum.CURRTENT_TO_STARVO=star.platioidVO;
			MOUSE_ENABLED=false;
			dispatchEvent(new GroupFightEvent(GroupFightEvent.PAIQIAN_EVENT));
		}
		
		private function createNewPlantSenceComp():void
		{
			if(!PlantSenceComp)
				PlantSenceComp= new GroupFightSenceComponent();
			PlantSenceComp.setPlantList(groupFightProxy.starArr);
//			PlantSenceComp.setSenceCenter(groupFightProxy.myStarVo);
			xingQiuSp.addChild(PlantSenceComp);
			PlantSenceComp.xingQiu1.graphics.lineStyle(0,0xffffff,1,true);
			PlantSenceComp.addEventListener(GroupFightSenceComponent.SELECTED_XING_QIU_CHANGE_EVENT, selectedPlantXingQiuChangeHandler);
			PlantSenceComp.bgEffectComp.addEventListener(MouseEvent.CLICK,bgSp_clickHandler);
			
		}
		
		public function senceChange(vo:GroupFightVo):void
		{
			PlantSenceComp.setSenceCenter(vo);
		}
		
		protected function selectedPlantXingQiuChangeHandler(event:Event):void
		{
			SoundUtil.play(SoundEnum.scan_star,true,false);
			selectedPlantioidComp = PlantSenceComp.selectedPlantXingQiuComp;//	取到当前行星			
		}
		
		protected function chaKanHandler(event:MouseEvent):void
		{
			GroupFightEnum.CURRTENT_STARVO=selectedPlantioidComp.platioidVO;
			dispatchEvent(new GroupFightEvent(GroupFightEvent.CHAKAN_EVENT));
		}
		private function clear():void
		{
			for(var i:int=0;i<xuanQuArr.length;i++)
			{
				var star:GroupFightStarComponent=xuanQuArr[i] as GroupFightStarComponent;
				star.button1.visible=false;
				star.button2.visible=false;
			}
			xuanQuArr.length=0;
		}
		
		protected function bgSp_clickHandler(event:MouseEvent):void
		{
			if(selectedPlantioidComp)
			{
				selectedPlantioidComp.isNotClick();
				selectedPlantioidComp.clearSp();
			}
			selectedPlantioidComp = null;
			clear();
			MOUSE_ENABLED=true;
		}
		
		public function attack(lossReportVo:LossReportVo):void
		{ 
			_timer=new Timer(1000,5);
			fanHangBtn.visible=tiShiMc.visible=fanHangBtn.mouseEnabled=true;
			var type1:String;
			var type2:String;
			if(lossReportVo.send_warships<33333)
			{
				type1="3";
			}else if(lossReportVo.send_warships>33333&&lossReportVo.send_warships<66666)
			{
				type1="2";
			}else
			{
				type1="1";
			}
			
			if(lossReportVo.send_warships_1<33333&&lossReportVo.send_warships_1>0)
			{
				type2="3";
			}else if(lossReportVo.send_warships_1>33333&&lossReportVo.send_warships_1<66666)
			{
				type2="2";
			}else if(lossReportVo.send_warships_1==0)
			{
				type2="0";
			}else 
			{
				type2="1";
			}
				
			mc=ClassUtil.getObject("view.GroupFightMC_"+type1+"_"+type2) as MovieClip;
			playSp.addChild(mc);
			this.addEventListener("PLAY_SHOUTSOUND",playShoutSoundHandler);
			this.addEventListener("PLAY_EXPLODSOUND",playExploSoundHandler);
			this.addEventListener(Event.COMPLETE,mcCompleteHandler);
			_timer.start();
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE,timerComplete);
		}
		
		protected function playShoutSoundHandler(event:Event):void
		{
			SoundUtil.play(SoundEnum.laser_fire2,false);
		}
		
		protected function playExploSoundHandler(event:Event):void
		{
			SoundUtil.play(SoundEnum.explode,false);
		}
		
		protected function timerComplete(event:TimerEvent):void
		{
			fanHangBtn.visible=tiShiMc.visible=fanHangBtn.mouseEnabled=false;	
			dispatchEvent(new GroupFightEvent(GroupFightEvent.GONGJI_EVENT));
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE,timerComplete);
			_timer=null
		}
		
		public override function dispose():void
		{
			xuanQuArr=null;
			PlantSenceComp.removeEventListener(GroupFightSenceComponent.SELECTED_XING_QIU_CHANGE_EVENT, selectedPlantXingQiuChangeHandler);
			PlantSenceComp.bgEffectComp.removeEventListener(MouseEvent.CLICK,bgSp_clickHandler);
			bgSp.removeEventListener(MouseEvent.CLICK, bgSp_clickHandler);
			if(_timer)
			{
				_timer.removeEventListener(TimerEvent.TIMER_COMPLETE,timerComplete);
				_timer=null
			}
			super.dispose();
		}
		
		protected function mcCompleteHandler(event:Event):void
		{
			playSp.removeChild(mc);	
			dispatchEvent(new GroupFightEvent(GroupFightEvent.PLAY_COMPLETE_EVENT));
			mc=null;
		}
		
		
		protected function fanHangHandler(event:MouseEvent):void
		{
			mc.gotoAndStop(1);
			playSp.removeChild(mc);
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE,timerComplete);
			_timer=null
			dispatchEvent(new GroupFightEvent(GroupFightEvent.BACK_EVENT));
		}		
		
		public function get selectedPlantioidComp():GroupFightStarComponent
		{
			return _selectedPlantioidComp;
		}
    }
}