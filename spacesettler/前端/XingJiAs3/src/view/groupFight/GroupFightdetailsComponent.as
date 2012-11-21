package view.groupFight
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.ClassUtil;
	import com.zn.utils.DateFormatter;
	
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import ui.components.Label;
	import ui.core.Component;
	
	import vo.groupFight.GroupFightVo;
	import vo.groupFight.RewardsStarVo;
	
	/**
	 *星球详细信息显示 只有主星和资源星才会有此项显示 
	 * @author Administrator
	 * 
	 */	
    public class GroupFightdetailsComponent extends Component
    {
		
		public static const TYPE_SHUIJING:int=1;
		public static const TYPE_CHUANQI:int=2;
		public static const TYPE_ANWUZHI:int=3;
		
		/**
		 *产量多少 或者产量增加多少 
		 */		
		public var numLable:Label;
		
		/**
		 *是产量还是产量增加 
		 */		
		public var lable:Label;
		
		/**
		 *刷新时间 
		 */		
		public var timeLable:Label;
		
		/**
		 *归属权所有人 
		 */		
		public var nameLable:Label;
		
		public var mc4:Sprite;//显示暗物质
		public var mc3:Sprite;//显示氚气
		public var mc2:Sprite;//显示水晶
		public var mc1:Sprite;//显示暗能水晶
		
		private var _timer:Timer;
		private var timeNum:int;
        public function GroupFightdetailsComponent()
        {
            super(ClassUtil.getObject("view.GroupFightdetailsSkin"));
			
			nameLable=createUI(Label,"nameLable");
			timeLable=createUI(Label,"timeLable");
			lable=createUI(Label,"lable");
			numLable=createUI(Label,"numLable");
			
			mc1=getSkin("mc1");
			mc2=getSkin("mc2");
			mc3=getSkin("mc3");
			mc4=getSkin("mc4");
			
			sortChildIndex();
			
			mc1.visible=false;
			mc2.visible=false;
			mc3.visible=false;
			mc4.visible=false;
			_timer=new Timer(1000);
			
        }
		
		public function updata(rewardVo:RewardsStarVo,starVo:GroupFightVo):void
		{
			
			timeNum=starVo.remainTime/1000;
			timeLable.text=DateFormatter.formatterTime(timeNum);
			_timer.start();
			_timer.addEventListener(TimerEvent.TIMER,timerHandler);
			
			
			if(starVo.legion_name!="")
			{
				nameLable.text=starVo.legion_name;				
			}else
			{
				nameLable.text=MultilanguageManager.getString("wurenzhanling");;
			}
			if(rewardVo.dark_crystal!=0)
			{
				isMc1();
				numLable.text=String(rewardVo.dark_crystal);
			}else if(rewardVo.dark_crystal==0)
			{
				switch(rewardVo.type)
				{
					case TYPE_SHUIJING:
					{
						isMc2();
						numLable.text=String(rewardVo.value*100)+"%";
						break;
					}
					case TYPE_CHUANQI:
					{
						isMc3();
						numLable.text=String(rewardVo.value*100)+"%";
						break;
					}
					case TYPE_ANWUZHI:
					{
						isMc4();
						numLable.text=String(rewardVo.value*100)+"%";
						break;
					}
					
				}
			}
			
		}
		public override function dispose():void
		{
			super.dispose();
			timerStop();
		}
		
		private function timerStop():void
		{
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER,timerHandler);
			_timer=null;
		}
		
		protected function timerHandler(event:TimerEvent):void
		{
			timeNum--
			if(timeNum>0)
			{
				timeLable.text=DateFormatter.formatterTime(timeNum);
			}else
			{
				timerStop()
			}
		}
		
		/**
		 *显示暗能水晶的情况  
		 * numLable为数字  另外三情况numLable则为100/h的格式
		 */		
		public function isMc1():void
		{
			mc1.visible=true;
			lable.text="产量";
		}
		
		public function isMc2():void
		{
			mc2.visible=true;
			lable.text="产量提高";
		}
		
		public function isMc3():void
		{
			mc3.visible=true;
			lable.text="产量提高";
		}
		
		public function isMc4():void
		{
			mc4.visible=true;
			lable.text="产量提高";
		}
    }
}