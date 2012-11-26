package mediator.task
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import controller.task.TaskCommand;
	import controller.task.TaskCompleteCommand;
	import controller.task.TaskGideCommand;
	
	import enum.BuildTypeEnum;
	import enum.TaskEnum;
	import enum.science.ScienceEnum;
	
	import events.task.TaskEvent;
	
	import flash.events.Event;
	import flash.net.getClassByAlias;
	
	import mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.observer.Notification;
	
	import proxy.BuildProxy;
	import proxy.battle.BattleProxy;
	import proxy.scienceResearch.ScienceResearchProxy;
	import proxy.task.TaskProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.managers.PopUpManager;
	import ui.managers.SystemManager;
	
	import view.task.TaskViewComponent;
	
	import vo.BuildInfoVo;
	import vo.scienceResearch.ScienceResearchVO;
	import vo.task.TaskInfoVO;

	/**
	 *模板 
	 * @author zn
	 * 
	 */
	public class TaskViewComponentMediator extends BaseMediator implements IMediator
	{
		public static const NAME:String="TaskViewComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		private var taskVo:TaskInfoVO;
		private var taskProxy:TaskProxy;
		private var _buildProxy:BuildProxy;
		private var _scienceProxy:ScienceResearchProxy;
		private var bool1:Boolean=false;
		private var bool2:Boolean=false;
		private var bool3:Boolean=false;
		public function TaskViewComponentMediator()
		{
			super(NAME, new TaskViewComponent());
			level=1;
			_popUp=false;
			taskProxy=getProxy(TaskProxy);
			_buildProxy=getProxy(BuildProxy);
			_scienceProxy=getProxy(ScienceResearchProxy);
			
			comp.addEventListener(TaskEvent.CLOSE_EVENT,closeHandler);
		}
		
		protected override function addUIComp():void
		{
			super.addUIComp();
			PopUpManager.closeAll(level);
			PopUpManager.addPopUp(comp, mode);
			comp.x=SystemManager.rootStage.stageWidth;;
			comp.y=(SystemManager.rootStage.stageHeight-comp.height)*0.5;
			comp.lightSp.alpha=0;
			comp.lightSp.x=comp.lightSp.x-comp.width;
			
			TweenLite.to(comp.lightSp, 0.8, {alpha:1, onComplete: addPerson });
		}
		
		private function addPerson():void
		{
			TweenLite.to(comp.backSp, 0.4, { x:comp.backSp.x -comp.backSp.width, onComplete: showComplete });
		}
		
		/*private function removePerson():void
		{
			TweenLite.to(comp.backSp, 0.2, { x:comp.backSp.x+comp.backSp.width, ease: Linear.easeNone, onComplete: removeTweenLiteComplete });
			removeCWList();	
			facade.removeMediator(getMediatorName());
		}*/
		
		public override function destroy():void
		{
			comp.removeEventListener(TaskEvent.CLOSE_EVENT,closeHandler);
			super.destroy();
//			if(comp)
//				TweenLite.to(comp.lightSp, 0.2, {alpha:0, onComplete: removePerson });
		}
		
		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [ DESTROY_NOTE];
		}

		/**
		 *消息处理
		 * @param note
		 *
		 */
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				
				case DESTROY_NOTE:
				{
					//销毁对象
					destroy();
					break;
				}
			}
		}

		/**
		 *获取界面
		 * @return
		 *
		 */
		protected function get comp():TaskViewComponent
		{
			return viewComponent as TaskViewComponent;
		}
		
		public function upData(taskObj:TaskInfoVO):void
		{
			if(taskObj.is_finished==false)
			{
				comp.updataContent(taskObj);				
			}
			else
			{
				comp.complete(taskObj);				
			}
		}
		
		protected function closeHandler(event:TaskEvent):void
		{
			taskVo=event.taskVo;			
			if(comp.isOver==false)
			{
				if(taskVo.idArr.length>0)
				{
					isComplete(taskVo.index);
					sendNotification(DESTROY_NOTE);				
				}else if(taskVo.idArr.length==0)
				{
					sendNotification(TaskCompleteCommand.TASKCOMPLETE_COMMAND);
					comp.complete(taskVo);
				}
			}else
			{	
				var userProxy:UserInfoProxy=getProxy(UserInfoProxy)
				if(userProxy.userInfoVO.index<=TaskEnum.index25)
				{
					var obj:Object={index:userProxy.userInfoVO.index, isFinished:userProxy.userInfoVO.is_finished ,
					isRewarded:userProxy.userInfoVO.is_rewarded};
					sendNotification(TaskCommand.ADDTASKINFO_COMMAND,obj);
				}else
				{
					sendNotification(DESTROY_NOTE);
				}
				
			}
		}
		
		public function isComplete(index:int):void
		{
			switch(index)
			{
				case TaskEnum.index2:
				{
					if(_buildProxy.hasBuild(BuildTypeEnum.CHUANQIN))
					{
						completeTask();
						return;
					}					
					break;
				}				
				case TaskEnum.index3:
				{
					if(_buildProxy.hasBuild(BuildTypeEnum.DIANCHANG))
					{
						completeTask();
						return;
					}					
					break;
				}				
				case TaskEnum.index4:
				{
					if(_buildProxy.hasBuild(BuildTypeEnum.KUANGCHANG))
					{
						completeTask();
						return;
					}					
					break;
				}				
				case TaskEnum.index6:
				{
					if(_buildProxy.hasBuild(BuildTypeEnum.CANGKU))
					{
						completeTask();
						return;
					}					
					break;
				}				
				case TaskEnum.index7:
				{
					if(_buildProxy.getBuild(BuildTypeEnum.CHUANQIN).level>=2)
					{
						completeTask();
						return;
					}					
					break;
				}				
				case TaskEnum.index8:
				{
					if(_buildProxy.getBuild(BuildTypeEnum.DIANCHANG).level>=2)
					{
						completeTask();
						return;
					}					
					break;
				}				
				case TaskEnum.index9:
				{
					if(_buildProxy.getBuild(BuildTypeEnum.KUANGCHANG).level>=2)
					{
						completeTask();
						return;
					}					
					break;
				}	
				case TaskEnum.index10:
				{
					if(_buildProxy.hasBuild(BuildTypeEnum.KEJI))
					{
						completeTask();
						return;
					}					
					break;
				}		
				case TaskEnum.index11:
				{
					if(_buildProxy.hasBuild(BuildTypeEnum.JUNGONGCHANG))
					{
						completeTask();
						return;
					}					
					break;
				}		
				case TaskEnum.index12:
				{
					if(_buildProxy.hasBuild(BuildTypeEnum.SHIJINMAC))
					{
						completeTask();
						return;
					}					
					break;
				}	
				case TaskEnum.index13:
				{
					if(_buildProxy.hasBuild(BuildTypeEnum.JUNGONGCHANG)&&_buildProxy.getBuild(BuildTypeEnum.JUNGONGCHANG).eventID=="")
					{
						completeTask();
						return;
					}					
					break;
				}
				case TaskEnum.index15:
				{
					hasScienceComplete(TaskEnum.index15)
									
					break;
				}
				case TaskEnum.index16:
				{
					hasScienceComplete(TaskEnum.index16);
							
					break;
				}
				case TaskEnum.index17:
				{
					hasScienceComplete(TaskEnum.index17);
								
					break;
				}
				case TaskEnum.index22:
				{
					if(_buildProxy.getBuild(BuildTypeEnum.DIANCHANG).level>=3)
					{
						completeTask();
						return;
					}					
					break;
				}
				case TaskEnum.index24:
				{
					var battleProxy:BattleProxy=getProxy(BattleProxy);
					if(battleProxy.isCompleteRenWu==true)
					{
						completeTask();
						return;
					}					
					break;
				}
				case TaskEnum.index25:
				{
					var userProxy:UserInfoProxy=getProxy(UserInfoProxy);
					if(userProxy.userInfoVO.legion_id!=""&&userProxy.userInfoVO.legion_id!=null)
					{
						completeTask();
						return;
					}					
					break;
				}
			}
			
			sendNotification(TaskGideCommand.TASKGIDE_COMMAND);
		}
		
		private function hasScienceComplete(index:int):void
		{
			_scienceProxy.getScienceResearchInfor(function():void
			{
				var arr:Array=_scienceProxy.reaearchList;
				for(var i:int=0;i<arr.length;i++)
				{
					var scienceVo:ScienceResearchVO=arr[i] as ScienceResearchVO;
					if(scienceVo.science_type==ScienceEnum.NENG_YUAN_KE_JI&&scienceVo.level>=1)
						bool1=true;
					if(scienceVo.science_type==ScienceEnum.JI_XIE_KE_JI&&scienceVo.level>=1)
						bool2=true;
					if(scienceVo.science_type==ScienceEnum.CAI_JI_KE_JI&&scienceVo.level>=1)
						bool3=true;
				}
				if(bool1==true&&index==TaskEnum.index15)
					qiangZhiComplete();
				if(bool2==true&&index==TaskEnum.index16)
					qiangZhiComplete();
				if(bool3==true&&index==TaskEnum.index17)
					qiangZhiComplete();
					
			});
		}
		
		
		private function completeTask():void
		{
			sendNotification(TaskCompleteCommand.TASKCOMPLETE_COMMAND);
		}
		
		private function qiangZhiComplete():void
		{
			taskProxy.getFreshmanTask(function():void
			{
				
				TaskEnum.CURRTENT_TASKVO.is_finished=true;
				var obj:Object={index:TaskEnum.CURRTENT_TASKVO.index, isFinished:TaskEnum.CURRTENT_TASKVO.is_finished ,
					isRewarded:TaskEnum.CURRTENT_TASKVO.is_rewarded};
				sendNotification(TaskCommand.ADDTASKINFO_COMMAND,obj);					
				
			},1);
		}



	}
}