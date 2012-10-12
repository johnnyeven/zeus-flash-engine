package proxy.timeMachine
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.net.Protocol;
	import com.zn.utils.DateFormatter;
	
	import enum.BuildTypeEnum;
	import enum.EventTypeEnum;
	import enum.command.CommandEnum;
	
	import flash.net.URLRequestMethod;
	
	import mediator.prompt.PromptMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import other.ConnDebug;
	
	import proxy.userInfo.UserInfoProxy;
	
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
		
		private var _timeMachineCallBackFunction:Function;
		private var userInforProxy:UserInfoProxy;
		
		public function TimeMachineProxy(data:Object=null)
		{
			super(NAME, data);
			userInforProxy = getProxy(UserInfoProxy);
			Protocol.registerProtocol(CommandEnum.allSpeed, allSpeedResult);
		}
		
		public function timeMachine(callBack:Function = null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.allView, timeMachineResult))
			      Protocol.registerProtocol(CommandEnum.allView, timeMachineResult);
			_timeMachineCallBackFunction = callBack;
			var id:String = userInforProxy.userInfoVO.id;
			var obj:Object = {id:id};
			ConnDebug.send(CommandEnum.allView,obj,ConnDebug.HTTP,URLRequestMethod.GET);
		}
		
		private function timeMachineResult(data:Object):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.allView, timeMachineResult);
			if(data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE,MultilanguageManager.getString(data.errors));
				_timeMachineCallBackFunction = null;
				return ;
			}
			timeMachineInfor(data);
		}
		
		public function allSpeed(id:String):void
		{
			var obj:Object = {base_id:id};
			ConnDebug.send(CommandEnum.allSpeed,obj);
		}
		
		private function allSpeedResult(data:Object):void
		{
			if(data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE,MultilanguageManager.getString(data.errors));
				return ;
			}
			timeMachineInfor(data);
			userInforProxy.updateServerData(data);
		}
		
		public function timeMachineInfor(data:Object):void
		{
			//建筑事件
			var buildingsEventsArr:Array = data.base.building_events;
			//科技事件
			var researchEventsArr:Array =  data.base.research_events;
			//制造事件
			//			var produceEventsArr:Array = data.base.produce_events;
			
			var totalEventsArr:Array = buildingsEventsArr.concat(researchEventsArr);
			var arr:Array = [];
			var timeMachine:TimeMachineVO
			for(var i:int = 0;i<totalEventsArr.length;i++)
			{
				timeMachine = new TimeMachineVO();
				timeMachine.eventID = totalEventsArr[i].id;
				timeMachine.type = totalEventsArr[i].type;
				if(timeMachine.type == EventTypeEnum.BUILDINGEVENTSTYPE)
				{
					timeMachine.building_type = totalEventsArr[i].building_type;
				}
				else if(timeMachine.type == EventTypeEnum.RESEARCHEVENTSTYPE)
				{
					timeMachine.building_type = totalEventsArr[i].science_type;
				}
				timeMachine.level = totalEventsArr[i].level;
				timeMachine.current_time = totalEventsArr[i].current_time;
				timeMachine.finish_time = totalEventsArr[i].finish_time;
				timeMachine.start_time = totalEventsArr[i].start_time;
				timeMachine.finishTime = (timeMachine.finish_time - timeMachine.current_time)*1000 + DateFormatter.currentTime;
				timeMachine.upTotalTome = timeMachine.finish_time - timeMachine.start_time;
				timeMachine.remainingTime = timeMachine.upTotalTome - (timeMachine.current_time - timeMachine.start_time);
				timeMachine.crystalCount = BuildTypeEnum.getCrystalCountByBuildLevel(totalEventsArr[i].level);
				timeMachine.totalCrystal += BuildTypeEnum.getCrystalCountByBuildLevel(totalEventsArr[i].level);
				arr.push(timeMachine);
			}
			timeMachineList = arr;
			
			if(_timeMachineCallBackFunction != null)
				_timeMachineCallBackFunction();
			_timeMachineCallBackFunction = null;
		}
	}
}