package view.buildingView
{
	import events.buildingView.AddViewEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.net.sendToURL;
	
	import proxy.BuildProxy;
	import proxy.content.ContentProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	
	import vo.viewInfo.ViewInfoVO;
	
	/**
	 * 科技中心升级界面
	 * 
	 */
	public class KeJiUpComponent extends Component
	{
		public var levelLabel:Label;//等级
		public var anWuZhiXHLabel:Label;//暗物质消耗
		public var shuiJingKuangXHLabel:Label;//水晶矿消耗
		public var chuanQingXHLabel:Label;//氚氢消耗
		public var xiaoGuo1Label:Label;//效果1
		public var xiaoGuo2Label:Label;//效果2
		public var timeLabel:Label;//升级所需时间
		
		public var progressMC:MovieClip;//进度条
		
		public var keYanButton:Button;//研究科技按钮
		public var upLevelButton:Button;//升级按钮
		public var closeButton:Button;//关闭按钮
		public var infoButton:Button;//信息按钮
		
		public function KeJiUpComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			levelLabel=createUI(Label,"level_textField");
			anWuZhiXHLabel=createUI(Label,"anWuZhiXH_textField");
			shuiJingKuangXHLabel=createUI(Label,"shuiJingKuangXH_textField");
			chuanQingXHLabel=createUI(Label,"chuanQingXH_textField");
			xiaoGuo1Label=createUI(Label,"xiaoGuo1_textField");
			xiaoGuo2Label=createUI(Label,"xiaoGuo2_textField");
			timeLabel=createUI(Label,"time_textField");
			
			progressMC=getSkin("progress_MC");
			
			keYanButton=createUI(Button,"keYan_button");
			upLevelButton=createUI(Button,"upLevel_button");
			closeButton=createUI(Button,"close_button");
			infoButton=createUI(Button,"info_button");
			
			sortChildIndex();
			
			keYanButton.addEventListener(MouseEvent.CLICK,keYanButton_clickHandler);
			upLevelButton.addEventListener(MouseEvent.CLICK,upLevelButton_clickHandler);
			closeButton.addEventListener(MouseEvent.CLICK,closeButton_clickHandler);
			infoButton.addEventListener(MouseEvent.CLICK,infoButton_clickHandler);
		}
		
		protected function keYanButton_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function upLevelButton_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function closeButton_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new AddViewEvent(AddViewEvent.CLOSE_EVENT));
		}
		
		protected function infoButton_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		public function set upType(value:int):void
		{
			//var userInfoVO:UserInfoVO=UserInfoProxy(ApplicationFacade.getProxy(UserInfoProxy)).userInfoVO;
			var level:int;
			var buildArr:Array=BuildProxy(ApplicationFacade.getProxy(BuildProxy)).buildArr;
			var len:int=buildArr.length;
			for(var i:int=0;i<len;i++)
			{
				if(buildArr[i].type==value)
				{
					level=buildArr[i].level;
				}
			}
			var curViewInfoVO:ViewInfoVO=ContentProxy(ApplicationFacade.getProxy(ContentProxy)).getUpBuildInfo(value,level);
			var nextViewInfoVO:ViewInfoVO=ContentProxy(ApplicationFacade.getProxy(ContentProxy)).getUpBuildInfo(value,level+1);
			
			levelLabel.text="等级"+level+"";
			anWuZhiXHLabel.text=curViewInfoVO.anWuZhiXH+"";
			shuiJingKuangXHLabel.text=curViewInfoVO.shuiJinXH+"";
			chuanQingXHLabel.text=curViewInfoVO.chuanQinXH+"";
			xiaoGuo1Label.text="电能消耗："+curViewInfoVO.DianNengXH+"/h --> "+nextViewInfoVO.DianNengXH+"/h";
			xiaoGuo2Label.text="提升部分科技等级上限";
			timeLabel.text=curViewInfoVO.time+"秒";
		}
	}
}