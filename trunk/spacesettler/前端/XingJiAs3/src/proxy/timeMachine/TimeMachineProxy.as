package proxy.timeMachine
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.net.Protocol;
	
	import enum.BuildTypeEnum;
	import enum.command.CommandEnum;
	
	import flash.net.URLRequestMethod;
	
	import mediator.prompt.PromptMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import other.ConnDebug;
	
	import vo.timeMachine.TimeMachineVO;
	
	/**
	 *时间机器 
	 * @author lw
	 * 
	 */	
	public class TimeMachineProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "TimeMachineProxy";
		
		[Bindable]
		public var timeMachineList:Array = [];
		
		public function TimeMachineProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		public function timeMachine(id:String):void
		{
			if (!Protocol.hasProtocolFunction(CommandEnum.allView, timeMachineResult))
				Protocol.registerProtocol(CommandEnum.allView, timeMachineResult);
			var obj:Object = {id:id};
			ConnDebug.send(CommandEnum.allView,obj,ConnDebug.HTTP,URLRequestMethod.GET);
		}
		
		private function timeMachineResult(data:Object):void
		{
			if(data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE,MultilanguageManager.getString(data.errors));
				return ;
			}
			
			var buildingsArr:Array = data.base.buildings;
			var arr:Array = [];
			var timeMachine:TimeMachineVO
			for(var i:int = 0;i<buildingsArr.length;i++)
			{
				timeMachine = new TimeMachineVO();
				timeMachine.building_type = buildingsArr[i].type;
				timeMachine.level = buildingsArr[i].level;
				timeMachine.current_time = buildingsArr[i].event.current_time;
				timeMachine.finish_time = buildingsArr[i].event.finish_time;
				timeMachine.start_time = buildingsArr[i].event.start_time;
				timeMachine.totalCrystal += BuildTypeEnum.getCrystalCountByBuildLevel(buildingsArr[i].level);
				arr.push(timeMachine);
			}
			timeMachineList = arr;
		}
		
		public function allSpeed(id:String):void
		{
			if (!Protocol.hasProtocolFunction(CommandEnum.allSpeed, allSpeedResult))
				Protocol.registerProtocol(CommandEnum.allSpeed, allSpeedResult);
			var obj:Object = {id:id};
			ConnDebug.send(CommandEnum.allSpeed,obj);
		}
		
		private function allSpeedResult(data:Object):void
		{
			if(data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE,MultilanguageManager.getString(data.errors));
				return ;
			}
			
		}
	}
}