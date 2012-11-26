package view.groupFight
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.zn.utils.ClassUtil;
	import com.zn.utils.ColorUtil;
	import com.zn.utils.OddsUtil;
	import com.zn.utils.StringUtil;
	
	import enum.groupFightEnum.GroupFightEnum;
	import enum.plantioid.PlantioidTypeEnum;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import proxy.group.GroupProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	import ui.utils.DisposeUtil;
	
	import vo.groupFight.GroupFightVo;
	import vo.groupFight.RewardsStarVo;
	
    public class GroupFightStarComponent extends Component
    {
		/**
		 *标题背景 
		 */		
		public var titleBg:Sprite;
		
		/**
		 *背景旋转 
		 */		
		public var bgMc:Sprite;
		
		/**
		 *装查看按钮的SP 
		 */		
		public var anNiuSp:Sprite;
		
		/**
		 *装查看详细信息的SP 只有资源星会用到 
		 */		
		public var chaKanSp:Sprite;
		
		/**
		 *装中间行星的Sp 
		 */		
		public var sprite:Sprite;
		
		/**
		 *装箭头移动的 
		 */		
		public var moveMc:Sprite;
		
		/**
		 *点击后出现的选取框 
		 */		
		public var clickMc:MovieClip;
		
		public var lable1:Label;//行星名
		public var lable2:Label;//占领军团名
		
		/**
		 * 攻击按钮
		 */		
		public var button1:Button;
		
		/**
		 * 派遣按钮
		 */		
		public var button2:Button;
		
		public var showMc:Sprite;
		
		public var qiuMianMc:GroupFightNumShowComponent;
		
		private var _isMine:Boolean=false;

		private var _platioidVO:GroupFightVo;
		public var rewardsStarVo:RewardsStarVo;
		
		private var _rotationTimeLine:TimelineLite;
		private var groupProxy:GroupProxy;
		private var _isPaiQian:Boolean=false;
        public function GroupFightStarComponent(type:int=0)
        {
			var skin:DisplayObjectContainer;
			if(type==GroupFightEnum.MAINSTAR_TYPE)
			{
				skin=ClassUtil.getObject("view.GroupFightMainStarSkin");
			}else
			{
				skin=(ClassUtil.getObject("view.GroupFightStarSkin"));				
			}
			super(skin);	
			
			groupProxy=ApplicationFacade.getProxy(GroupProxy);
			
			qiuMianMc=createUI(GroupFightNumShowComponent,"qiuMianMc");
			
			lable1=createUI(Label,"lable1");
			lable2=createUI(Label,"lable2");
			button1=createUI(Button,"button1");
			button2=createUI(Button,"button2");
			
			anNiuSp=getSkin("anNiuSp");
			showMc=getSkin("showMc");
			chaKanSp=getSkin("chaKanSp");
			sprite=getSkin("sprite");
			clickMc=getSkin("clickMc");
			titleBg=getSkin("titleBg");
			moveMc=getSkin("moveMc");
			bgMc=getSkin("bgMc");
			
			sortChildIndex();
			clickMc.visible=false;
			qiuMianMc.visible=false;
			button1.visible=false;
			button2.visible=false;
			showMc.visible=false;
			button2.addEventListener(MouseEvent.CLICK,paiQianHandler);
        }
		
		protected function paiQianHandler(event:MouseEvent):void
		{
			isPaiQian=true;
		}
		
		public override function dispose():void
		{
			_rotationTimeLine.kill();
			_rotationTimeLine = null;
			super.dispose();
		}
		
		public function clearSp():void
		{
			while(chaKanSp.numChildren>0)
			{
				DisposeUtil.dispose(chaKanSp.removeChildAt(0));
			}
			
			while(anNiuSp.numChildren>0)
			{
				DisposeUtil.dispose(anNiuSp.removeChildAt(0));
			}
			
			while(moveMc.numChildren>0)
			{
				DisposeUtil.dispose(moveMc.removeChildAt(0));
			}
		}
		
		public function get platioidVO():GroupFightVo
		{
			return _platioidVO;
		}
		
		public function set platioidVO(value:GroupFightVo):void
		{
			_platioidVO = value;
			
			sprite.addChild(ClassUtil.getObject("plantioid.xinQiu_" + value.img_name));			
			rotationXingQiu();
			
			lable1.text=platioidVO.name;			
			lable2.text=platioidVO.legion_name;
			
			if(platioidVO.legion_name=="")
			{
				ColorUtil.restore(bgMc);
				ColorUtil.restore(titleBg);
				
				ColorUtil.tint(bgMc, 0xFFFFFF, 1);
				ColorUtil.tint(titleBg, 0xFFFFFF, 1);
				ColorUtil.tint(qiuMianMc.mc1, 0xFFFFFF, 0.2);
				
			}else if(platioidVO.legion_name==groupProxy.groupInfoVo.groupname)
			{
				isMine=true;
				qiuMianMc.visible=true;
				ColorUtil.tint(bgMc, 0x33FF00, 1);
				ColorUtil.tint(titleBg, 0x33FF00, 1);
				ColorUtil.tint(qiuMianMc.mc1, 0x33FF00, 0.2);
				if(platioidVO.total_warships>0)
					showMc.visible=true;
				else
					showMc.visible=false;
			}else if(platioidVO.legion_name!=groupProxy.groupInfoVo.groupname&&platioidVO.legion_name!="")
			{
				if(platioidVO.total_warships>100000)
				{
					ColorUtil.tint(bgMc, 0xFF0000, 1);
					ColorUtil.tint(titleBg, 0xFF0000, 1);
					ColorUtil.tint(qiuMianMc.mc1, 0xFF0000, 0.2);					
				}else if(platioidVO.total_warships>10000&&platioidVO.total_warships<=100000)
				{
					ColorUtil.tint(bgMc, 0xFF6600, 1);
					ColorUtil.tint(titleBg, 0xFF6600, 1);
					ColorUtil.tint(qiuMianMc.mc1, 0xFF6600, 0.2);
					
				}else if(platioidVO.total_warships>=0&&platioidVO.total_warships<=10000)
				{					
					ColorUtil.tint(bgMc, 0xFF9933, 1);
					ColorUtil.tint(titleBg, 0xFF9933, 1);
					ColorUtil.tint(qiuMianMc.mc1, 0xFF9933, 0.2);
				}
			}
			qiuMianMc.lable1.text=platioidVO.total_warships.toString();
			qiuMianMc.lable2.text=platioidVO.warship.toString();			
		}
		
		private function rotationXingQiu():void
		{
			var rotation:int = 360;
			if (OddsUtil.getDrop(0.5))
				rotation = -rotation;
			if(_rotationTimeLine)
				_rotationTimeLine.kill();
			_rotationTimeLine = new TimelineLite({ onComplete: rotationXingQiu });
			_rotationTimeLine.insert(TweenLite.to(sprite, 60, { rotation: rotation, ease: Linear.easeNone }));
			_rotationTimeLine.insert(TweenLite.to(bgMc, 60, { rotation: -rotation, ease: Linear.easeNone }));
		}
		
		public function isClick():void
		{
			clickMc.visible=true;
		}
		
		public function isNotClick():void
		{
			clickMc.visible=false;
		}

		public function get isMine():Boolean
		{
			return _isMine;
		}

		public function set isMine(value:Boolean):void
		{
			_isMine = value;
		}

		public function get isPaiQian():Boolean
		{
			return _isPaiQian;
		}

		public function set isPaiQian(value:Boolean):void
		{
			_isPaiQian = value;
		}


    }
}