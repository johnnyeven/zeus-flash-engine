package view.mainView
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.components.ProgressBar;
	import ui.core.Component;
	
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
		
		/**
		 *buff 
		 */				
		public var buff_1:Sprite;
		public var buff_2:Sprite;
		public var buff_3:Sprite;		

		private var _userInfoProxy:UserInfoProxy;
		
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
			
			militaryRankText.text="新兵";//*****************************************
			electricBar=createUI(ProgressBar,"dianliang_loader_bar");
			enemy=createUI(Button,"diren_btn");//*******************敌人按钮暂时未加功能  以示！！！！
			
			buff_1=getSkin("buff_1");
			buff_2=getSkin("buff_2");
			buff_3=getSkin("buff_3");					
			
			_userInfoProxy=ApplicationFacade.getProxy(UserInfoProxy);
			
			cwList.push(BindingUtils.bindProperty(userNameText,"text",_userInfoProxy,["userInfoVO","nickname"]));
//			cwList.push(BindingUtils.bindProperty(pebbleText,"text",userInfoProxy,["userInfoVO","crystal"]));
//			cwList.push(BindingUtils.bindProperty(tritiumGasText,"text",_userInfoProxy,["userInfoVO","tritium"]));
//			cwList.push(BindingUtils.bindProperty(darkText,"text",_userInfoProxy,["userInfoVO","broken_crysta"]));
			cwList.push(BindingUtils.bindProperty(moneyText,"text",_userInfoProxy,["userInfoVO","dark_crystal"]));
			cwList.push(BindingUtils.bindProperty(militaryExploitText,"text",_userInfoProxy,["userInfoVO","prestige"]));
			//cwList.push(BindingUtils.bindProperty(militaryRankText,"text",userInfoProxy,["userInfoVO","militaryRrank"]));
			cwList.push(BindingUtils.bindProperty(electricBar,"percent",_userInfoProxy,["userInfoVO","power"]));
			
			cwList.push(BindingUtils.bindSetter(crystalChange,_userInfoProxy,["userInfoVO","crystal"]));
			cwList.push(BindingUtils.bindSetter(tritiumChange,_userInfoProxy,["userInfoVO","tritium"]));
			cwList.push(BindingUtils.bindSetter(darkChange,_userInfoProxy,["userInfoVO","broken_crysta"]));
		}
		
		private function darkChange(value:*):void
		{
			darkText.text=value;
		}
		
		private function crystalChange(value:*):void
		{
			pebbleText.text=value;
			if(_userInfoProxy.userInfoVO.crystal>=_userInfoProxy.userInfoVO.crystal_volume)
				pebbleText.color=0xFF0000;
			else
				pebbleText.color=0xFFFFFF;
		}
		
		private function tritiumChange(value:*):void
		{
			tritiumGasText.text=value;
			if(_userInfoProxy.userInfoVO.tritium>=_userInfoProxy.userInfoVO.tritium_volume)
				tritiumGasText.color=0xFF0000;
			else
				tritiumGasText.color=0xFFFFFF;
		}
	}
}