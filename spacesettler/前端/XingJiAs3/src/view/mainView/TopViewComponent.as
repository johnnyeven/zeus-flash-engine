package view.mainView
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.ProgressBar;
	import ui.core.Component;
	
	public class TopViewComponent extends Component
	{
		/**
		 * 水晶数量显示
		 */		
		public var pebbleText:TextField;
		/**
		 * 氚气显示
		 */		
		public var tritiumGasText:TextField;
		/**
		 * 暗能物质显示
		 */		
		public var darkText:TextField;
		/**
		 * 金钱显示
		 */		
		public var moneyText:TextField;
		/**
		 * 军衔显示
		 */		
		public var militaryRankText:TextField;
		/**
		 * 军功声望显示
		 */		
		public var militaryExploitText:TextField;
		/**
		 * 用户名显示
		 */		
		public var userNameText:TextField;
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
		
		public function TopViewComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			
			pebbleText=getSkin("shuijing_tf");
			tritiumGasText=getSkin("chuanqi_tf");
			darkText=getSkin("anneng_tf");
			moneyText=getSkin("jinqian_tf");
			militaryRankText=getSkin("junxian_tf");
			militaryExploitText=getSkin("shengwang_tf");
			userNameText=getSkin("uesrname_tf");
			
			electricBar=createUI(ProgressBar,"dianliang_loader_bar");
			enemy=createUI(Button,"diren_btn");//*******************敌人按钮暂时未加功能  以示！！！！
			
			buff_1=getSkin("buff_1");
			buff_2=getSkin("buff_2");
			buff_3=getSkin("buff_3");					
			
			var userInfoProxy:UserInfoProxy=ApplicationFacade.getProxy(UserInfoProxy);
			cwList.push(BindingUtils.bindProperty(userNameText,"text",userInfoProxy,["userInfoVO","userName"]));
			cwList.push(BindingUtils.bindProperty(pebbleText,"text",userInfoProxy,["userInfoVO","crystal"]));
			cwList.push(BindingUtils.bindProperty(tritiumGasText,"text",userInfoProxy,["userInfoVO","tritium"]));
			cwList.push(BindingUtils.bindProperty(darkText,"text",userInfoProxy,["userInfoVO","broken_crysta"]));
			cwList.push(BindingUtils.bindProperty(moneyText,"text",userInfoProxy,["userInfoVO","dark_crystal"]));
			cwList.push(BindingUtils.bindProperty(militaryExploitText,"text",userInfoProxy,["userInfoVO","prestige"]));
			cwList.push(BindingUtils.bindProperty(militaryRankText,"text",userInfoProxy,["userInfoVO","militaryRrank"]));
			cwList.push(BindingUtils.bindProperty(electricBar,"percent",userInfoProxy,["userInfoVO","power"]));
			
		}
	}
}