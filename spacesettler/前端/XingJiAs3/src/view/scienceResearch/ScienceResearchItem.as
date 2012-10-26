package view.scienceResearch
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.utils.ClassUtil;
	import com.zn.utils.DateFormatter;
	import com.zn.utils.StringUtil;
	
	import enum.ResEnum;
	
	import events.buildingView.ConditionEvent;
	import events.scienceResearch.SciencePopuEvent;
	import events.scienceResearch.ScienceResearchEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.binding.utils.BindingUtils;
	
	import proxy.BuildProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.components.LoaderImage;
	import ui.components.ProgressBar;
	import ui.core.Component;
	
	import vo.scienceResearch.ScienceResearchVO;
	
	/**
	 *科研条目
	 * @author lw
	 * 
	 */	
	public class ScienceResearchItem extends Component
	{
		
		public var nameIconURL:LoaderImage;
		public var levelLabel:Label;
		public var inforBtn:Button;
		
		public var inforSprite:Component;
		public var nameLabel:Label;
		public var levelNameLabel:Label;
		public var brokenCrystalLabel:Label;
		public var tritiumLabel:Label;
		public var commandLabel:Label;
		public var timeLabel:Label;
		public var researchBtn:Button;
		
		public var researchUPSprite:Component;
		public var upNameLabel:Label;
		public var levelChangeLabel:Label;
		public var upTimeLabel:Label;
		public var progressBar:ProgressBar;
		
		public var fullLevelSprite:Component;
		public var inforNameLabel:Label;
		
		private var _data:ScienceResearchVO;
		private var userInforProxy:UserInfoProxy;
		private var buildProxy:BuildProxy;
		
		private var timer:Timer;
		
		private var _tweenLite:TweenLite;
		private var isUp:Boolean = false;
		
		public function ScienceResearchItem()
		{
			super(ClassUtil.getObject("view.scienceResearch.ScienceResearchItemSkin"));
			userInforProxy = ApplicationFacade.getProxy(UserInfoProxy);
			buildProxy = ApplicationFacade.getProxy(BuildProxy);
			
			nameIconURL = createUI(LoaderImage,"nameIconURL");
			levelLabel = createUI(Label,"levelLabel");
			inforBtn = createUI(Button,"inforBtn");
			
			inforSprite = createUI(Component,"inforSprite");
			nameLabel = inforSprite.createUI(Label,"nameLabel");
			levelNameLabel = inforSprite.createUI(Label,"levelNameLabel");
			brokenCrystalLabel = inforSprite.createUI(Label,"brokenCrystalLabel");
			tritiumLabel = inforSprite.createUI(Label,"tritiumLabel");
			commandLabel =  inforSprite.createUI(Label,"commandLabel");
			timeLabel = inforSprite.createUI(Label,"timeLabel");
			researchBtn = inforSprite.createUI(Button,"researchBtn");
			inforSprite.sortChildIndex();
			
			researchUPSprite =createUI(Component,"researchUPSprite");
			upNameLabel = researchUPSprite.createUI(Label,"upNameLabel");
			levelChangeLabel = researchUPSprite.createUI(Label,"levelChangeLabel");
			upTimeLabel = researchUPSprite.createUI(Label,"upTimeLabel");
			upTimeLabel.text = "";
			progressBar = researchUPSprite.createUI(ProgressBar,"progressBar");
			progressBar.percent = 0;
			researchUPSprite.sortChildIndex();
			
			fullLevelSprite = createUI(Component,"fullLevelSprite");
			inforNameLabel = fullLevelSprite.createUI(Label,"inforNameLabel");
			
			sortChildIndex();
			
			timer = new Timer(1000);
			inforSprite.visible = false;
			researchUPSprite.visible = false;
			fullLevelSprite.visible = false;
			inforBtn.addEventListener(MouseEvent.CLICK,inforBtn_clickHAndler);
			researchBtn.addEventListener(MouseEvent.CLICK,researchBtn_clickHAndler);
		}
		
			
		
		public function get data():ScienceResearchVO
		{
			return _data;
		}

		public function set data(value:ScienceResearchVO):void
		{
			_data = value;
			if(_data.current_time &&_data.current_time >0)
			{
				isUp = true;
				timer.addEventListener(TimerEvent.TIMER,timerHandler);
				timer.start();
			}
			else
			{
				isUp = false;
			}
			if(!isUp)
			{
				if(_data.level >= 40)
				{
					inforSprite.visible = false;
					researchUPSprite.visible = false;
					fullLevelSprite.visible = true;
				}
				else
				{
					inforSprite.visible = true;
					researchUPSprite.visible = false;
					fullLevelSprite.visible = false;
				}
			}
			else
			{
				inforSprite.visible = false;
				researchUPSprite.visible = true;
				fullLevelSprite.visible = false;
			}
		
			removeCWList();
			
			nameIconURL.source = _data.scienceIconURL;
			cwList.push(BindingUtils.bindProperty(levelLabel,"text",_data,"level"));

			cwList.push(BindingUtils.bindProperty(nameLabel,"text",_data,"scienceName"));
			cwList.push(BindingUtils.bindSetter(function():void
			{
				var strName:String = "<p><s>研究</s><s>{0}</s><s>级</s><s>{1}</s><s>需要消耗：</s></p>";
				strName = StringUtil.formatString(strName,_data.level,_data.scienceName);
				levelNameLabel.text = strName;
			},_data,"level"));
			
			cwList.push(BindingUtils.bindSetter(function():void
			{
				brokenCrystalLabel.text = "X"+_data.broken_crystal +"";
			},_data,"broken_crystal"));
			
			cwList.push(BindingUtils.bindSetter(function():void
			{
				tritiumLabel.text = "X"+_data.tritium +"";
			},_data,"tritium"));
			
			cwList.push(BindingUtils.bindSetter(levelChange,_data,"command_center_level"));
			cwList.push(BindingUtils.bindSetter(levelChange,_data,"academy_level"));
			
			cwList.push(BindingUtils.bindSetter(function():void
			{
				timeLabel.text = DateFormatter.formatterTimeSFM(_data.time);
			},_data,"time"));
			
			cwList.push(BindingUtils.bindProperty(upNameLabel,"text",_data,"scienceName"));
			cwList.push(BindingUtils.bindSetter(function():void
			{
				levelChangeLabel.text = _data.level+"级"+"-"+(_data.level+1)+"级";
			},_data,"level"));
			cwList.push(BindingUtils.bindProperty(inforNameLabel,"text",_data,"scienceName"));
	
			progressBar.percent = (_data.current_time-_data.start_time)/(_data.finish_time-_data.start_time);
			stopTweenLite();
			_tweenLite = TweenLite.to(progressBar, _data.remainTime/1000, { percent: 1, ease: Linear.easeNone });
			upTimeLabel.text = DateFormatter.formatterTimeSFM(_data.remainTime/1000);
		}
		
		private function timerHandler(event:TimerEvent):void
		{
			if(_data.remainTime/1000 <= 0)
			{
				dispatchEvent(new ScienceResearchEvent(ScienceResearchEvent.GET_DATA_RESULT,_data.science_type,true,true));
				timer.stop();
			}
			
			upTimeLabel.text = DateFormatter.formatterTimeSFM(_data.remainTime/1000);
		}

		protected function inforBtn_clickHAndler(event:MouseEvent):void
		{
			dispatchEvent(new ScienceResearchEvent(ScienceResearchEvent.INFOR_EVENT,_data.science_type,true,true));
		}
		
		private function researchBtn_clickHAndler(event:MouseEvent):void
		{
			if(data.academy_level>buildProxy.getBuild(3).level||data.command_center_level>buildProxy.getBuild(1).level)
			{
				var conditionArr:Array=[];
				if(data.academy_level>buildProxy.getBuild(3).level)
				{
					var obj1:Object=new Object();
					obj1.imgSource=ResEnum.getConditionIconURL+"6.png";
					obj1.content=MultilanguageManager.getString("science_build")+buildProxy.getBuild(3).level+"/"+data.academy_level;
					obj1.btnLabel=MultilanguageManager.getString("up_science");
					conditionArr.push(obj1);
				}
				if(data.command_center_level>buildProxy.getBuild(1).level)
				{
					var obj2:Object=new Object();
					obj2.imgSource=ResEnum.getConditionIconURL+"5.png";
					obj2.content=MultilanguageManager.getString("center_build")+buildProxy.getBuild(1).level+"/"+data.command_center_level;
					obj2.btnLabel=MultilanguageManager.getString("up_center");
					conditionArr.push(obj2);
				}
				dispatchEvent(new ConditionEvent(ConditionEvent.ADDCONDITIONVIEW_EVENT,conditionArr));
//				dispatchEvent(new SciencePopuEvent(SciencePopuEvent.POPU_DATA_EVENT,_data,true,true));
				return;
			}

			dispatchEvent(new ScienceResearchEvent(ScienceResearchEvent.RESEARCH_EVENT,_data.science_type,true,true));
		}
		
		public override function dispose():void
		{
			super.dispose();
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, timerHandler);
			
			timer = null;
		}
		
		private function levelChange(data:*):void
		{
			var str1:String ="";
			if(_data.command_center_level >0)
			{
				str1 = "基地中心"+_data.command_center_level+"级";
			}
			else
			{
				str1 = "";
			}
			
			var str2:String = "";
			if(_data.academy_level >0)
			{
				str2 = "科技中心"+_data.academy_level+"级";
			}
			else
			{
				str2 = "";
			}
			commandLabel.text = str1+","+str2;
		}
		
		private function stopTweenLite():void
		{
			if (_tweenLite)
				_tweenLite.kill();
			_tweenLite = null;
		}
	}
}