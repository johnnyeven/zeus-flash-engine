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
		
		public static const TYPE_ZHUXING:int=0;
		public static const TYPE_SHUIJING:int=1;
		public static const TYPE_CHUANQI:int=3;
		public static const TYPE_ANWUZHI:int=2;
		
		public static const RESOURCE_TYPE_SHUIJING:int=1;
		public static const RESOURCE_TYPE_ANWUZHI:int=2;
		public static const RESOURCE_TYPE_CHUANQI:int=3;
		public static const RESOURCE_TYPE_ANNENG:int=4;
		
		public var guiSuoLable:Label;
		public var shuaXinLable:Label;
		/**
		 *军团获得：
		 */		
		public var junTuanLable:Label;
		
		/**
		 *军团获得多少暗物质
		 */		
		public var junTuanNumLable:Label;
		
		/**
		 *成员获得：
		 */		
		public var chengYuanLable:Label;
		
		/**
		 *成员获得多少资源
		 */		
		public var chengYuanNumLable:Label;
		
		/**
		 *产出还是占领收益
		 */		
		public var chanChuLable:Label;
		
		/**
		 *产出多少 或者BUFF多少
		 */		
		public var numLable:Label;
		
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
		
		public var mc5:Sprite;//显示军团获得暗物质
		
		public var mc6:Sprite;//显示成员获得水晶
		public var mc7:Sprite;//显示成员获得氚气
		public var mc8:Sprite;//显示成员获得暗物质
		private var _timer:Timer;
		private var timeNum:int;
        public function GroupFightdetailsComponent()
        {
            super(ClassUtil.getObject("view.GroupFightdetailsSkin"));
			guiSuoLable=createUI(Label,"guiSuoLable");
			shuaXinLable=createUI(Label,"shuaXinLable");
			
			nameLable=createUI(Label,"nameLable");
			timeLable=createUI(Label,"timeLable");
			numLable=createUI(Label,"numLable");
			
			chanChuLable=createUI(Label,"chanChuLable");
			chengYuanNumLable=createUI(Label,"chengYuanNumLable");
			chengYuanLable=createUI(Label,"chengYuanLable");
			junTuanNumLable=createUI(Label,"junTuanNumLable");
			junTuanLable=createUI(Label,"junTuanLable");
			
			mc1=getSkin("mc1");
			mc2=getSkin("mc2");
			mc3=getSkin("mc3");
			mc4=getSkin("mc4");
			mc5=getSkin("mc5");
			mc6=getSkin("mc6");
			mc7=getSkin("mc7");
			mc8=getSkin("mc8");
			
			sortChildIndex();
			
			mc1.visible=false;
			mc2.visible=false;
			mc3.visible=false;
			mc4.visible=false;
			mc5.visible=false;
			mc6.visible=false;
			mc7.visible=false;
			mc8.visible=false;
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
			
			switch(rewardVo.type)
			{
				case TYPE_ZHUXING:
				{
					isMc1();
					numLable.text="X"+String(rewardVo.dark_crystal);			
					break;
				}
				case TYPE_SHUIJING:
				{
					isMc2();
					chengYuanNumLable.text="X"+String(rewardVo.count);
					numLable.text="12小时内水晶产量增加"+String(rewardVo.value*100)+"%";			
					junTuanNumLable.text="X"+String(rewardVo.broken_crystal);
					break;
				}
				case TYPE_CHUANQI:
				{
					isMc3();
					chengYuanNumLable.text="X"+String(rewardVo.count);
					numLable.text="12小时内氚气产量增加"+String(rewardVo.value*100)+"%";			
					junTuanNumLable.text="X"+String(rewardVo.broken_crystal);
					break;
				}
				case TYPE_ANWUZHI:
				{
					isMc4();
					chengYuanNumLable.text="X"+String(rewardVo.count);
					numLable.text="12小时内暗物质产量增加"+String(rewardVo.value*100)+"%";			
					junTuanNumLable.text="X"+String(rewardVo.broken_crystal);
					break;
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
			chanChuLable.text="占领收益：";
			chengYuanNumLable.visible=false;
			chengYuanLable.visible=false;
			junTuanNumLable.visible=false;
			junTuanLable.visible=false;
		}
		
		public function isMc2():void
		{
			mc2.visible=true;
			mc5.visible=true;
			mc6.visible=true;
			chanChuLable.text="所有成员获得：";			
		}
		
		public function isMc3():void
		{
			mc3.visible=true;
			mc5.visible=true;
			mc7.visible=true;
			chanChuLable.text="所有成员获得：";
		}
		
		public function isMc4():void
		{
			mc4.visible=true;
			mc5.visible=true;
			mc8.visible=true;
			chanChuLable.text="所有成员获得：";
		}
    }
}