package controller.task
{
	import enum.BuildTypeEnum;
	import enum.TaskEnum;
	import enum.science.ScienceEnum;
	
	import mediator.task.TaskViewComponentMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import proxy.BuildProxy;
	import proxy.scienceResearch.ScienceResearchProxy;
	import proxy.task.TaskProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import vo.scienceResearch.ScienceResearchVO;
	import vo.task.TaskInfoVO;

	public class TaskCommand extends SimpleCommand
	{
		public static const ADDTASKINFO_COMMAND:String="ADDTASKINFO_COMMAND";
		
		private var taskViewMed:TaskViewComponentMediator;
		
		private var _taskObj:Object;
		
		private var _taskProxy:TaskProxy;
		private var _taskInfoVO:TaskInfoVO;
		
		private var _buildProxy:BuildProxy;
		private var _scienceProxy:ScienceResearchProxy;
		private var bool1:Boolean;
		private var bool2:Boolean;
		private var bool3:Boolean;
		public function TaskCommand()
		{
			super();
			_taskProxy=getProxy(TaskProxy);
			_buildProxy=getProxy(BuildProxy);
			_scienceProxy=getProxy(ScienceResearchProxy);
		}
		
		
		
		
		/**
		 *执行
		 * @param notification
		 *
		 */
		public override function execute(notification:INotification):void
		{
			sendNotification(TaskViewComponentMediator.DESTROY_NOTE);
			taskViewMed=getMediator(TaskViewComponentMediator);
			_taskObj=notification.getBody() as Object;
			_taskInfoVO=_taskProxy.getTaskItemInfo(_taskObj);
			TaskEnum.CURRTENT_TASKVO=_taskInfoVO;		
			
			sendNotification(TaskViewComponentMediator.SHOW_NOTE,_taskInfoVO);			
		}
		
		
	}
}