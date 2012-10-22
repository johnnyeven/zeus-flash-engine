package view.group
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.ClassUtil;
	
	import events.group.GroupManageEvent;
	import events.group.GroupShowAndCloseEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import ui.components.Button;
	import ui.components.CheckBox;
	import ui.components.HSlider;
	import ui.components.Label;
	import ui.components.ProgressBar;
	import ui.core.Component;
	
	import vo.group.GroupListVo;
	
	/**
	 *军团管理 
	 * @author Administrator
	 * 
	 */	
    public class GroupManageComponent extends Component
    {
		public static const MAX_NUM:int=100000;
		
		public static const MAX_BYTE:int=60;
		
		public var hs_der:HSlider;//拖动条
		
		
		public var sp_1:Component;//装制造和拖动条的
		
		public var sp_2:Component;//装loader条的
		
		public var gonggao_tf:TextField;//公告栏
		public var shuliang_tf:Label;//制造数量
		public var xiaohao_tf:Label;//所需暗物质
		public var tishi_tf:Label;//提示还能输入多少字符
		public var zhanjian_tf:Label;//拥有的战舰数
		public var anwuzhi_tf:Label;//拥有的暗物质数
		public var max_make_num:Label;//最大能制造数
		
		public var loader_bar:ProgressBar;
		public var time_tf:Label;
		public var zhizao_num:Label;
		
		public var zhizao_btn:Button;//制造按钮
		public var genggai_btn:Button;//更改按钮
		public var shenhe_btn:Button;//审核按钮
		public var fanhui_btn:Button;//返回按钮
		
		public var checkbox_2:CheckBox;//加入军团需要审核
		public var checkbox_1:CheckBox;//禁止所有人领取战舰
		
		private var maxNum:int;
		private var _num1:int;
		private var _num2:int;
		private var _desc:String;
		private var _makeNum:int;
		private var str:String;
		private var _surplusByte:int;
		private var _tweenLite:TweenLite;
		private var _timer:Timer;
		private var num:int;
        public function GroupManageComponent()
        {
            super(ClassUtil.getObject("view.group.GroupManageSkin"));			
			
			gonggao_tf=getSkin("gonggao_tf")
			sp_1=createUI(Component,"sp_1");
			sp_2=createUI(Component,"sp_2");
			hs_der=sp_1.createUI(HSlider,"hs_der");
			
			shuliang_tf=sp_1.createUI(Label,"shuliang_tf");
			xiaohao_tf=sp_1.createUI(Label,"xiaohao_tf");
			max_make_num=sp_1.createUI(Label,"max_make_num");
			zhizao_btn=sp_1.createUI(Button,"zhizao_btn");
			
			time_tf=sp_2.createUI(Label,"time_tf");
			zhizao_num=sp_2.createUI(Label,"zhizao_num");
			loader_bar=sp_2.createUI(ProgressBar,"loader_bar");
			
			tishi_tf=createUI(Label,"tishi_tf");
			zhanjian_tf=createUI(Label,"zhanjian_tf");
			anwuzhi_tf=createUI(Label,"anwuzhi_tf");
			
			genggai_btn=createUI(Button,"genggai_btn");
			shenhe_btn=createUI(Button,"shenhe_btn");
			fanhui_btn=createUI(Button,"fanhui_btn");
			
			checkbox_1=createUI(CheckBox,"checkbox_1");
			checkbox_2=createUI(CheckBox,"checkbox_2");
			
			gonggao_tf.mouseEnabled=true;
			checkbox_1.selected=true;
			checkbox_2.selected=true;
			
			sortChildIndex();
			isNomal();
			
			gonggao_tf.maxChars=MAX_BYTE*2;
			
			fanhui_btn.addEventListener(MouseEvent.CLICK,closeHandler);
			genggai_btn.addEventListener(MouseEvent.CLICK,genGaiHandler);
			shenhe_btn.addEventListener(MouseEvent.CLICK,shenHeHandler);
			zhizao_btn.addEventListener(MouseEvent.CLICK,zhiZaoHandler);
			gonggao_tf.addEventListener(Event.CHANGE,textChangeHandler);
        }
		
		protected function textChangeHandler(event:Event):void
		{
			str=gonggao_tf.text;
			tishi_tf.text="你还可以输入"+surplusByte.toString()+"个字";
			if(surplusByte==0)				
				gonggao_tf.maxChars=gonggao_tf.length;
		}		
		
		public function upData(groupInfoVo:GroupListVo):void
		{
			if(groupInfoVo.eventId!=null)
			{
				isZhiZao();
				var number:Number;
				number=1-(groupInfoVo.remainTime/((groupInfoVo.finish_time-groupInfoVo.start_time)*1000));
				setTweenLine(groupInfoVo.remainTime,number);
				zhizao_num.text=groupInfoVo.count.toString();
			}else
			{
				isNomal();
			}
			
			if(groupInfoVo.desc!=null&&groupInfoVo.desc!="")
			{
				
				gonggao_tf.text=groupInfoVo.desc;
			}else
			{
				gonggao_tf.text=MultilanguageManager.getString("desc");
			}
			zhanjian_tf.text=groupInfoVo.warship.toString();
			anwuzhi_tf.text=groupInfoVo.broken_crystal.toString();
			anwuzhi_tf.text=groupInfoVo.broken_crystal.toString();
			checkbox_1.selected=groupInfoVo.forbid_getting_warship;
			checkbox_2.selected=groupInfoVo.verification;
			maxNum=Math.min(groupInfoVo.broken_crystal,MAX_NUM);
			max_make_num.text=maxNum.toString();
			hs_der.maxValue=maxNum;
			str=gonggao_tf.text;
			tishi_tf.text="你还可以输入"+surplusByte.toString()+"个字";
			hs_der.addEventListener(Event.CHANGE,changeHandler);
		}
		
		protected function changeHandler(event:Event):void
		{
			shuliang_tf.text="×"+hs_der.value.toString();
			xiaohao_tf.text="×"+hs_der.value.toString();
			_makeNum=hs_der.value;
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
			stopTweenLite();
			stopTimer();
		}
		
		public function setTweenLine(time:Number,percent:Number=0,callFun:Function=null):void
		{		
			
			if(time<=0)
			{		
				isNomal();
				stopTimer();
				stopTweenLite();
			}else if(time>0)			
			{		
				stopTimer();
				num=time/1000;
				loader_bar.percent=percent;
				_timer=new Timer(1000);
				_timer.addEventListener(TimerEvent.TIMER,timerHandler);
				_timer.start();
				_tweenLite = TweenLite.to(loader_bar, num, { percent: 1, ease: Linear.easeNone , onComplete:callFun});
			}
			
			time_tf.text=num.toString()+"秒";			
		}
		
		public function timerComplete():void
		{			
			dispatchEvent(new GroupManageEvent(GroupManageEvent.ZHIZAO_COMPLETE_EVENT,0,0));
		}
		
		protected function timerHandler(event:TimerEvent):void
		{
			num--;
			time_tf.text=num.toString()+"秒";
			if(num<=0)
			{
				isNomal();
				timerComplete();
				stopTimer();
				stopTweenLite();
			}
		}
		
		protected function closeHandler(event:MouseEvent):void
		{
			dispatchEvent(new GroupShowAndCloseEvent(GroupShowAndCloseEvent.CLOSE));
		}
		
		protected function zhiZaoHandler(event:MouseEvent):void
		{
			dispatchEvent(new GroupManageEvent(GroupManageEvent.ZHIZAO_EVENT,verification,forbid_getting_warship,null,makeNum));
		}
		
		protected function shenHeHandler(event:MouseEvent):void
		{
			dispatchEvent(new GroupShowAndCloseEvent(GroupShowAndCloseEvent.SHOW_SHENHE_EVENT));
		}
		
		protected function genGaiHandler(event:MouseEvent):void
		{
			dispatchEvent(new GroupManageEvent(GroupManageEvent.GENGAI_EVENT,verification,forbid_getting_warship,desc));
		}
		
		/**
		 *是否加入军团需要验证 0否 1 是 
		 * 
		 */		
		public function get verification():int
		{
			if(checkbox_2.selected==true)
			{
				_num2=1;
			}else
			{
				_num2=0
			}
			return _num2;
		}
		
		/**
		 *是否禁止领取舰队 0允许 1 禁止
		 * 
		 */		
		public function get forbid_getting_warship():int
		{
			if(checkbox_1.selected==true)
			{
				_num1=1;
			}else
			{
				_num1=0
			}
			return _num1;
		}
		
		public function get desc():String
		{
			if(gonggao_tf.text!=MultilanguageManager.getString("desc")&&gonggao_tf.text!="")
			{
				_desc=gonggao_tf.text;
			}else
			{
				_desc="";
			}
			
			return _desc;
		}

		public function get makeNum():int
		{
			return _makeNum;
		}

		public function get surplusByte():int
		{
			_surplusByte=MAX_BYTE-str.length;
			if(_surplusByte<=0)
				_surplusByte=0;
			return _surplusByte;
		}
		
		public function isNomal():void
		{
			sp_1.visible=true;
			sp_2.visible=false;
		}
		
		public function isZhiZao():void
		{
			sp_1.visible=false;
			sp_2.visible=true;
		}


	}
}