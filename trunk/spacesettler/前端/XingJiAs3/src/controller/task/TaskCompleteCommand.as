package controller.task
{
	import com.zn.utils.ClassUtil;
	
	import enum.TaskEnum;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import proxy.task.TaskProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import ui.managers.PopUpManager;
	import ui.managers.SystemManager;

	public class TaskCompleteCommand extends SimpleCommand
	{
		public static const TASKCOMPLETE_COMMAND:String="TASKCOMPLETE_COMMAND";
		
		private var taskProxy:TaskProxy;
		
		private var completeMc:MovieClip;
		public function TaskCompleteCommand()
		{
			super();
			taskProxy=getProxy(TaskProxy);
			
		}

		/**
		 *执行
		 * @param notification
		 *
		 */
		public override function execute(notification:INotification):void
		{			
			taskProxy.getFreshmanTask(function():void
			{
				completeMc=ClassUtil.getObject("view.taskMcSkin") as MovieClip;
				completeMc.x=Main.WIDTH*0.5;
				completeMc.y=Main.HEIGHT*0.5;
				SystemManager.instance.addPop(completeMc);
				completeMc.gotoAndPlay(1);
				completeMc.addEventListener(Event.COMPLETE,mcCompleteHandler);
				if(TaskEnum.CURRTENT_TASKVO.index!=1)
				{
	//				var userProxy:UserInfoProxy=getProxy(UserInfoProxy)
					TaskEnum.CURRTENT_TASKVO.is_finished=true;
					var obj:Object={index:TaskEnum.CURRTENT_TASKVO.index, isFinished:TaskEnum.CURRTENT_TASKVO.is_finished ,
						isRewarded:TaskEnum.CURRTENT_TASKVO.is_rewarded};
					sendNotification(TaskCommand.ADDTASKINFO_COMMAND,obj);										
				}
			});
		}
		
		protected function mcCompleteHandler(event:Event):void
		{
			completeMc.removeEventListener(Event.COMPLETE,mcCompleteHandler);
			SystemManager.instance.removePop(completeMc);
			completeMc=null
		}

	}
}