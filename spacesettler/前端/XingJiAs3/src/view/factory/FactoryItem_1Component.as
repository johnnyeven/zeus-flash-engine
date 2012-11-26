package view.factory
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.zn.utils.ClassUtil;
	
	import enum.factory.FactoryEnum;
	
	import events.factory.FactoryItemEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.components.ProgressBar;
	import ui.core.Component;
	
	import vo.cangKu.GuaJianInfoVO;
	import vo.cangKu.ZhanCheInfoVO;
	import vo.factory.DrawListVo;
	
    public class FactoryItem_1Component extends Component
    {
		public var item_sp:LoaderImage;
		
		public var shuijin_mc:Sprite;
		
		public var pingfen_tf:Label;
		
		public var shuijin_tf:Label;
		
		public var anwuzhi_tf:Label;
		
		public var chuanqi_tf:Label;
		
		public var title_tf:Label;

		public var level_tf:Label;
		
		/**
		 *显示需要的时候 
		 */		
		public var time_tf1:Label;
		
		/**
		 *显示剩余时间 
		 */		
		public var time_tf2:Label;
		
		public var info_btn:Button;
		
		public var zhizao_btn:Button;
		
		public var jiasu_btn:Button;
		
		/**
		 * 制造loader条和剩余时间 
		 * 
		 */		
		public var sprite1:Component;
		
		/**
		 * 显示制造需要的物资和时间 
		 */		
		public var sprite2:Component;
		
		public var bar:ProgressBar;
		
		public var zhancheVo:ZhanCheInfoVO;
		public var guajianVo:GuaJianInfoVO;

		private var _tweenLite:TweenLite;
		private var _timer:Timer;
		private var num:int;
		private var _drawVo:DrawListVo;
        public function FactoryItem_1Component()
        {
            super(ClassUtil.getObject("view.factory.FactoryItem_1"));
			
			pingfen_tf=createUI(Label,"pingfen_tf");
			title_tf=createUI(Label,"title_tf");
			level_tf=createUI(Label,"level_tf");
			info_btn=createUI(Button,"info_btn");
			
			zhizao_btn=createUI(Button,"zhizao_btn");
			jiasu_btn=createUI(Button,"jiasu_btn");
			item_sp=createUI(LoaderImage,"item_sp");
			
			sprite1=createUI(Component,"sp_1");
			sprite2=createUI(Component,"sp_2");
			
			shuijin_tf=sprite2.createUI(Label,"shuijin_tf");
			anwuzhi_tf=sprite2.createUI(Label,"anwuzhi_tf");
			chuanqi_tf=sprite2.createUI(Label,"chuanqi_tf");
			time_tf1=sprite2.createUI(Label,"time_tf_1");
			shuijin_mc=sprite2.getSkin("shuijin_mc");
			
			time_tf2=sprite1.createUI(Label,"time_tf");
			bar=sprite1.createUI(ProgressBar,"bar");
			
			sprite1.sortChildIndex();
			sprite2.sortChildIndex();
			
			sortChildIndex();
			bar.percent=0;
        }
		
		/**
		 *正在制造的状态 
		 * 
		 */		
		public function isMake():void
		{
			sprite1.visible=true;
			sprite2.visible=false;
			zhizao_btn.visible=false;
			jiasu_btn.visible=true;
			zhizao_btn.mouseEnabled=false;
			jiasu_btn.mouseEnabled=true;
		}
		
		/**
		 *没制造的状态 
		 * 
		 */		
		public function isNotMake():void
		{
			sprite1.visible=false;
			sprite2.visible=true;
			zhizao_btn.visible=true;
			jiasu_btn.visible=false;
			zhizao_btn.mouseEnabled=true;
			jiasu_btn.mouseEnabled=false;
		}
		
		private function stopTweenLite():void
		{
			if (_tweenLite)
				_tweenLite.kill();
			_tweenLite = null;
		}
		
		private function stopTimer():void
		{
			if(_timer)
			{
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER,timerHandler);
				_timer=null;					
			}
		}
		
		public override function dispose():void
		{
			super.dispose();
			stopTweenLite();
			stopTimer();
		}
		
		public function setTweenLine(time:Number,callFun:Function=null,percent:Number=0):void
		{		
			
			if(time<=0)
			{				
				isNotMake();
				stopTimer();
				stopTweenLite();
			}else if(time>0)			
			{		
				isMake();
				stopTimer();
				num=Math.round(time/1000);
				time_tf2.text=num.toString()+"秒";			
				bar.percent=percent;
				_timer=new Timer(1000);
				_timer.addEventListener(TimerEvent.TIMER,timerHandler);
				_timer.start();
				_tweenLite = TweenLite.to(bar, num, { percent: 1, ease: Linear.easeNone , onComplete:callFun});
			}
				
		}
		
		public function timerComplete():void
		{
			dispatchEvent(new FactoryItemEvent(FactoryItemEvent.ZHIZAO_COMPLETE_EVENT,true,false,drawVo));
		}
		
		protected function timerHandler(event:TimerEvent):void
		{
			num--;
			time_tf2.text=num.toString()+"秒";
			if(num<=0)
			{
				timerComplete();
				stopTimer();
				stopTweenLite();
				isNotMake();
			}
		}

		public function get drawVo():DrawListVo
		{
			return _drawVo;
		}

		public function set drawVo(value:DrawListVo):void
		{
			_drawVo = value;
			if(drawVo.eventID!=""||drawVo.eventID!=null)
				setTweenLine(drawVo.remainTime);
		}
		
		
    }
}