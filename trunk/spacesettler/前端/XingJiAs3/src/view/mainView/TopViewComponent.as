package view.mainView
{
	import com.zn.multilanguage.MultilanguageManager;
	
	import enum.BuffEnum;
	
	import events.friendList.FriendListEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.components.ProgressBar;
	import ui.core.Component;
	
	import utils.GlobalUtil;
	
	import vo.userInfo.BuffVo;
	
	public class TopViewComponent extends Component
	{
		/**
		 * 水晶数量显示
		 */		
		public var pebbleText:Label;
		/**
		 * 氚气显示
		 */		
		public var tritiumGasText:Label;
		/**
		 * 暗能物质显示
		 */		
		public var darkText:Label;
		/**
		 * 金钱显示
		 */		
		public var moneyText:Label;
		/**
		 * 军衔显示
		 */		
		public var militaryRankText:Label;
		/**
		 * 军功声望显示
		 */		
		public var militaryExploitText:Label;
		/**
		 * 用户名显示
		 */		
		public var userNameText:Label;
		/**
		 * 电量loader条
		 */		
		public var electricBar:ProgressBar;
		/**
		 * 敌人按钮
		 */		
		public var enemy:Button;
		
		public var vipImg:LoaderImage;
		
		/**
		 *buff 
		 */				
		public var buff1:LoaderImage;
		public var buff2:LoaderImage;
		public var buff3:LoaderImage;		

		private var _userInfoProxy:UserInfoProxy;
		private var darkOut:Number;
		private var crystalOut:Number;
		private var tritiumOut:Number;
		private var timer:Timer;
		public function TopViewComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			
			pebbleText=createUI(Label,"shuijing_tf");
			tritiumGasText=createUI(Label,"chuanqi_tf");
			darkText=createUI(Label,"anneng_tf");
			moneyText=createUI(Label,"jinqian_tf");
			militaryRankText=createUI(Label,"junxian_tf");
			militaryExploitText=createUI(Label,"shengwang_tf");
			userNameText=createUI(Label,"uesrname_tf");
			
			buff1=createUI(LoaderImage,"buff1");
			buff2=createUI(LoaderImage,"buff2");
			buff3=createUI(LoaderImage,"buff3");
			vipImg=createUI(LoaderImage,"vipImg");
			
			electricBar=createUI(ProgressBar,"dianliang_loader_bar");
			enemy=createUI(Button,"diren_btn");//*******************敌人按钮暂时未加功能  以示！！！！
			
			vipImg.visible=false;
			buff1.source=BuffEnum.SOURCE_1;
			buff2.source=BuffEnum.SOURCE_2;
			buff3.source=BuffEnum.SOURCE_3;
			
			buff1.visible=buff2.visible=buff3.visible=false;					
			
			_userInfoProxy=ApplicationFacade.getProxy(UserInfoProxy);
			timer=new Timer(1000);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER,timerHandler);			
			
			cwList.push(BindingUtils.bindProperty(userNameText,"text",_userInfoProxy,["userInfoVO","nickname"]));
			cwList.push(BindingUtils.bindSetter(electricBarChange,_userInfoProxy,["userInfoVO","power"]));
			cwList.push(BindingUtils.bindSetter(buffChange1,_userInfoProxy,["userInfoVO","buff1"]));
			cwList.push(BindingUtils.bindSetter(buffChange2,_userInfoProxy,["userInfoVO","buff2"]));
			cwList.push(BindingUtils.bindSetter(buffChange3,_userInfoProxy,["userInfoVO","buff3"]));
			
			cwList.push(BindingUtils.bindSetter(moneyChange,_userInfoProxy,["userInfoVO","dark_crystal"]));
			cwList.push(BindingUtils.bindSetter(crystalChange,_userInfoProxy,["userInfoVO","crystal"]));
			cwList.push(BindingUtils.bindSetter(tritiumChange,_userInfoProxy,["userInfoVO","tritium"]));
			cwList.push(BindingUtils.bindSetter(darkChange,_userInfoProxy,["userInfoVO","broken_crysta"]));
			cwList.push(BindingUtils.bindSetter(militaryExploitChange,_userInfoProxy,["userInfoVO","prestige"]));
			
			cwList.push(BindingUtils.bindSetter(crystalOutChange,_userInfoProxy,["userInfoVO","crystal_output"]));
			cwList.push(BindingUtils.bindSetter(tritiumOutChange,_userInfoProxy,["userInfoVO","tritium_output"]));
			cwList.push(BindingUtils.bindSetter(darkOutChange,_userInfoProxy,["userInfoVO","broken_crystal_output"]));
			cwList.push(BindingUtils.bindSetter(vipShowChange,_userInfoProxy,["userInfoVO","vip_level"]));
			cwList.push(BindingUtils.bindSetter(junXianChange,_userInfoProxy,["userInfoVO","militaryRrank"]));
			
			enemy.addEventListener(MouseEvent.CLICK,enemy_clickHandler);
			
			userNameText.mouseChildren=userNameText.mouseEnabled=true;
			userNameText.buttonMode=true;
			userNameText.addEventListener(MouseEvent.CLICK,showCard_clickHandler);
		}
		
		private function buffChange1(value:*):void
		{
			if(value&&value.value>0)
			{
				buff1.visible=true;	
				buff1.toolTipData=MultilanguageManager.getString("buffType")+MultilanguageManager.getString("buffType1")+String(value.value*100)+"%";				
			}else
			{
				buff1.visible=false;	
			}
		}
		private function buffChange2(value:*):void
		{
			if(value&&value.value>0)
			{
				buff2.visible=true;	
				buff2.toolTipData=MultilanguageManager.getString("buffType")+MultilanguageManager.getString("buffType2")+String(value.value*100)+"%";				
			}else
				buff2.visible=false;	
		}
		private function buffChange3(value:*):void
		{
			if(value&&value.value>0)
			{
				buff3.visible=true;	
				buff3.toolTipData=MultilanguageManager.getString("buffType")+MultilanguageManager.getString("buffType3")+String(value.value*100)+"%";				
			}else
				buff3.visible=false;
		}
		private function electricBarChange(value:*):void
		{
			if(value==0)
			{
				timer.stop();
			}
			if(electricBar.percent==0&&value!=0)
			{
				timer.start();
			}
			electricBar.percent=value;
		}
		
		private function junXianChange(value:*):void
		{
			switch(value)
			{
				case 0:
				{
					militaryRankText.text="准尉";
					break;
				}
				case 1:
				{
					militaryRankText.text="少尉";
					break;
				}
				case 2:
				{
					militaryRankText.text="中尉";
					break;
				}
				case 3:
				{
					militaryRankText.text="上尉";
					break;
				}
				case 4:
				{
					militaryRankText.text="少校";
					break;
				}
				case 5:
				{
					militaryRankText.text="中校";
					break;
				}
				case 6:
				{
					militaryRankText.text="上校";
					break;
				}
				case 7:
				{
					militaryRankText.text="少将";
					break;
				}
				case 8:
				{
					militaryRankText.text="中将";
					break;
				}
				case 9:
				{
					militaryRankText.text="上将";
					break;
				}
					
			}
		}
			
		
		private function vipShowChange(value:*):void
		{
			if(value==1)
			{
				vipImg.visible=true;
				vipImg.source=BuffEnum.SOURCE_VIP_1_1;
				vipImg.toolTipData=BuffEnum.VIP_1;
				
			}
			if(value==2)
			{
				vipImg.visible=true;
				vipImg.source=BuffEnum.SOURCE_VIP_2_1;
				vipImg.toolTipData=BuffEnum.VIP_2;
			}
			if(value==3)
			{
				vipImg.visible=true;
				vipImg.source=BuffEnum.SOURCE_VIP_3_1;
				vipImg.toolTipData=BuffEnum.VIP_3;
			}
		}
		
		public override function dispose():void
		{
			super.dispose();
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER,timerHandler);
			timer=null;
		}
		
		protected function timerHandler(event:TimerEvent):void
		{
			_userInfoProxy.userInfoVO.broken_crysta+=darkOut;
			_userInfoProxy.userInfoVO.crystal+=crystalOut;
			_userInfoProxy.userInfoVO.tritium+=tritiumOut;
		}
		
		private function crystalOutChange(value:*):void
		{			
			crystalOut=value/3600;
		}
		
		private function tritiumOutChange(value:*):void
		{
			tritiumOut=value/3600;
		}
		
		private function darkOutChange(value:*):void
		{
			darkOut=value/3600;
		}
		
		private function militaryExploitChange(value:*):void
		{
			GlobalUtil.resLabelChange(militaryExploitText,int(value));
		}
		private function moneyChange(value:*):void
		{
			GlobalUtil.resLabelChange(moneyText,int(value));
		}
		private function darkChange(value:*):void
		{
			GlobalUtil.resLabelChange(darkText,int(value));
//			darkText.text=int(value).toString();
		}
		
		private function crystalChange(value:*):void
		{
			if(_userInfoProxy.userInfoVO.crystal>=_userInfoProxy.userInfoVO.crystal_volume)
			{
				pebbleText.color=0xFF0000;
				crystalOut=0;
			}			
			else
			{
				pebbleText.color=0xFFFFFF;
				crystalOutChange(_userInfoProxy.userInfoVO.crystal_output);
			}
			GlobalUtil.resLabelChange(pebbleText,int(value));
//			pebbleText.text=int(value).toString();
		}
		
		private function tritiumChange(value:*):void
		{
//			tritiumGasText.text=int(value).toString();
			if(_userInfoProxy.userInfoVO.tritium>=_userInfoProxy.userInfoVO.tritium_volume)				
			{
				tritiumGasText.color=0xFF0000;
				tritiumOut=0;
			}
			else
			{
				tritiumGasText.color=0xFFFFFF;
				tritiumOutChange(_userInfoProxy.userInfoVO.tritium_output);				
			}
			GlobalUtil.resLabelChange(tritiumGasText,int(value));
		}
		
		private function enemy_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new FriendListEvent(FriendListEvent.ENEMY_LIST_EVENT,true,true));
		}
		
		private function showCard_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new FriendListEvent(FriendListEvent.CHECK_PLAYER_ID_CARD_EVENT,true,true));
		}
	}
}