package view.task
{
	import com.zn.utils.ClassUtil;
	import com.zn.utils.StringUtil;
	
	import enum.TaskEnum;
	
	import events.task.TaskEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import proxy.task.TaskProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.components.Button;
	import ui.components.Label;
	import ui.core.Component;
	
	import vo.task.TaskInfoVO;
	import vo.userInfo.UserInfoVO;
	
	/**
	 *任务面板 
	 * @author Administrator
	 * 
	 */	
	public class TaskViewComponent extends Component
	{
		public var taskNumLabel:Label;
		public var taskNameLabel:Label;
		public var prevBtn:Button;
		public var nextBtn:Button;
		public var okBtn:Button;
		public var completeBtn:Button;
		public var shiJianBtn:Button;
		public var boxSp:Sprite;
		public var lightSp:Sprite;
		public var npcMC:MovieClip;
		
		private var _desComp:TaskDescripComponent;
		private var _goalComp:TaskGoalAndRewardComponent;
		
		private var _isNext:Boolean=false;
		private var _index:int;
		private var lenght:int=1;
		private var _desXML:XML;
		private var taskVo:TaskInfoVO;
		
		public var isOver:Boolean=false;
		private var userProxy:UserInfoProxy;
		public function TaskViewComponent()
		{
			super(ClassUtil.getObject("view.taskViewSkin"));
			

//			_desXML=new XML(_taskProxy.taskInfoVO.des);

			taskNumLabel=createUI(Label,"taskNum");
			taskNameLabel=createUI(Label,"taskName");
			prevBtn=createUI(Button,"prevBtn");
			nextBtn=createUI(Button,"nextBtn");
			okBtn=createUI(Button,"okBtn");
			completeBtn=createUI(Button,"completeBtn");
			shiJianBtn=createUI(Button,"shiJianBtn");
			boxSp=getSkin("boxSp");
			lightSp=getSkin("lightSp");
			npcMC=getSkin("npcSp");
			sortChildIndex();
			
			npcMC.gotoAndStop(1);		
			

			completeBtn.visible=false;
			shiJianBtn.visible=false;

//			updataContent();

			
			userProxy=ApplicationFacade.getProxy(UserInfoProxy);
			
			okBtn.addEventListener(MouseEvent.CLICK,okBtn_clickHandler);
			completeBtn.addEventListener(MouseEvent.CLICK,okBtn_clickHandler);
			shiJianBtn.addEventListener(MouseEvent.CLICK,okBtn_clickHandler);
			nextBtn.addEventListener(MouseEvent.CLICK,nextBtn_clickHandler);
			prevBtn.addEventListener(MouseEvent.CLICK,prevBtn_clickHandler);
		}
		
		public function updataContent(taskVo:TaskInfoVO):void
		{
			this.taskVo=taskVo;
			_desXML=new XML(taskVo.des);
			lenght=_desXML.p.length();		
			
			prevBtn.visible=false;
			okBtn.visible=false;
			taskNumLabel.text=taskVo.title;
			taskNameLabel.text=taskVo.name;
			
			_desComp=new TaskDescripComponent();
			_desComp.content=StringUtil.formatString(_desXML.p[0],userProxy.userInfoVO.nickname);
			
			boxSp.addChild(_desComp);
			
		}		
		
		public function changeContent():void
		{
			if(index<lenght)
			{				
				_desComp.content=StringUtil.formatString(_desXML.p[index],userProxy.userInfoVO.nickname);
			}else if(index==lenght)
			{
				boxSp.removeChild(_desComp);
				_goalComp=new TaskGoalAndRewardComponent();
				_goalComp.isNotComplete();
				_goalComp.goalText=taskVo.goalDes;
				_goalComp.brokenCrystaText=taskVo.broken_crystal+"";
				_goalComp.crystalText=taskVo.crystal+"";
				_goalComp.tritiumText=taskVo.tritium+"";
				if(taskVo.dark_crystal<=0)
				{
					_goalComp.isShow=false;
					_goalComp.darkCrystalText="";
				}
				else
					_goalComp.darkCrystalText=taskVo.dark_crystal+"";
				
				boxSp.addChild(_goalComp);
			}
			taskNumLabel.text=taskVo.title;
			taskNameLabel.text=taskVo.name;
			
		}
		
		public function complete(taskVo:TaskInfoVO):void
		{
			taskNumLabel.text=taskVo.title;
			taskNameLabel.text=taskVo.name;
			completeBtn.visible=true;
			okBtn.visible=false;
			nextBtn.visible=false;
			prevBtn.visible=false;
			isOver=true;
			npcMC.gotoAndStop(2);
			if(!_goalComp)
			{
				_goalComp=new TaskGoalAndRewardComponent();
				boxSp.addChild(_goalComp);
			}
			_goalComp.isComplete();
			_goalComp.goalText=taskVo.goalDes;
			_goalComp.brokenCrystaText=taskVo.broken_crystal+"";
			_goalComp.crystalText=taskVo.crystal+"";
			_goalComp.tritiumText=taskVo.tritium+"";
			if(taskVo.dark_crystal<=0)
			{
				_goalComp.isShow=false;
				_goalComp.darkCrystalText="";
			}
			else
				_goalComp.darkCrystalText=taskVo.dark_crystal+"";
		}
		
		private function nextBtn_clickHandler(event:MouseEvent):void
		{
			index+=1;
			changeContent();
			
		}
		
		private function prevBtn_clickHandler(event:MouseEvent):void
		{
			index-=1;
			changeContent();
		}
		
		protected function okBtn_clickHandler(event:MouseEvent):void
		{
			dispatchEvent(new TaskEvent(TaskEvent.CLOSE_EVENT,taskVo));
		}

		public function get index():int
		{
			return _index;
		}

		public function set index(value:int):void
		{
			_index = value;
			if(_index<=0)
			{
				_index=0;
				okBtn.visible=false;
				prevBtn.visible=false;
				nextBtn.visible=true;
			}else if(_index>0&&_index<lenght)
			{
				okBtn.visible=false;
				nextBtn.visible=true;
				prevBtn.visible=true;
			}else if(_index>=lenght)
			{
				_index=lenght;
				if(taskVo.index!=TaskEnum.index12)
				{
					okBtn.visible=true;
					nextBtn.visible=false;
					prevBtn.visible=false;
				}else if(taskVo.index==TaskEnum.index12)
				{
					shiJianBtn.visible=true;
					okBtn.visible=false;
					nextBtn.visible=false;
					prevBtn.visible=false;
				}
				
			}
		}

	}
}