package view.buildingView
{
	import events.buildingView.AddViewEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import proxy.BuildProxy;
	import proxy.content.ContentProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	
	import vo.viewInfo.ViewInfoVO;
	
	/**
	 * 暗能电厂升级界面
	 * 
	 */
	public class AnNengDianChangUpComponent extends Component
	{
		public var levelLabel:Label;//等级
		public var dianLiangLabel:Label;//电量提供
		public var anWuZhiXHLabel:Label;//暗物质消耗
		public var shuiJingKuangXHLabel:Label;//水晶矿消耗
		public var chuanQingXHLabel:Label;//氚氢消耗
		public var xiaoGuoLabel:Label;//效果
		public var timeLabel:Label;//升级所需时间
		
		public var progressMC:MovieClip;//进度条
		
		public var upLevelButton:Button;//升级按钮
		public var closeButton:Button;//关闭按钮
		public var infoButton:Button;//信息按钮
		
		public function AnNengDianChangUpComponent(skin:DisplayObjectContainer)
		{
			super(skin);
			levelLabel=createUI(Label,"level_textField");
			dianLiangLabel=createUI(Label,"dianLiang_textField");
			anWuZhiXHLabel=createUI(Label,"anWuZhiXH_textField");
			shuiJingKuangXHLabel=createUI(Label,"shuiJingKuangXH_textField");
			chuanQingXHLabel=createUI(Label,"chuanQingXH_textField");
			xiaoGuoLabel=createUI(Label,"xiaoGuo_textField");
			timeLabel=createUI(Label,"time_textField");
			
			progressMC=getSkin("progress_MC");
			
			upLevelButton=createUI(Button,"upLevel_button");
			closeButton=createUI(Button,"close_button");
			infoButton=createUI(Button,"info_button");
			
			sortChildIndex();
			
			upLevelButton.addEventListener(MouseEvent.CLICK,upLevelButton_clickHandler);
			closeButton.addEventListener(MouseEvent.CLICK,closeButton_clickHandler);
			infoButton.addEventListener(MouseEvent.CLICK,infoButton_clickHandler);
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
			dianLiangLabel.text="电能提供："+curViewInfoVO.DianNengTG;
			anWuZhiXHLabel.text=curViewInfoVO.anWuZhiXH+"";
			shuiJingKuangXHLabel.text=curViewInfoVO.shuiJinXH+"";
			chuanQingXHLabel.text=curViewInfoVO.chuanQinXH+"";
			xiaoGuoLabel.text="电能提供："+curViewInfoVO.DianNengTG+"/h --> "+nextViewInfoVO.DianNengTG+"/h";
			timeLabel.text=curViewInfoVO.time+"秒";
		}
	}
}