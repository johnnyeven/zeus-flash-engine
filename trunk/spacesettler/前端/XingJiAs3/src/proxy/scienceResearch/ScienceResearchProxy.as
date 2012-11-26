package proxy.scienceResearch
{
	import com.zn.multilanguage.MultilanguageManager;
	import com.zn.net.Protocol;
	import com.zn.utils.DateFormatter;
	import com.zn.utils.ObjectUtil;
	
	import controller.task.TaskCompleteCommand;
	
	import enum.BuildTypeEnum;
	import enum.TaskEnum;
	import enum.command.CommandEnum;
	import enum.science.ScienceEnum;
	
	import flash.net.URLRequestMethod;
	
	import mediator.prompt.PromptMediator;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import other.ConnDebug;
	
	import proxy.BuildProxy;
	import proxy.content.ContentProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import vo.BuildInfoVo;
	import vo.scienceResearch.ScienceResearchVO;
	
	/**
	 *科研 
	 * @author lw
	 * 
	 */	
	public class ScienceResearchProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "ScienceResearchProxy";
		
		[Bindable]
		public var reaearchList:Array =[];
		
		private var userInforProxy:UserInfoProxy;
		
		private var _scienceResearchCallBack:Function;
		
		public var totalLevel:int;
		
		private var _obj:Object;
		
		private var type:int;
		public function ScienceResearchProxy(data:Object=null)
		{
			super(NAME, data);
			
			userInforProxy = getProxy(UserInfoProxy);
			
			Protocol.registerProtocol(CommandEnum.researchUp, researchUpResult);
			Protocol.registerProtocol(CommandEnum.researchReturn, researchReturnResult);
			
			Protocol.registerProtocol(CommandEnum.speedResearchUp,speedResearchUpResult);
		}
		
		public function getScienceResearchInfor(callBack:Function = null):void
		{
			if(!Protocol.hasProtocolFunction(CommandEnum.scienceResearchInfor, getScienceResearchInforResult))
			       Protocol.registerProtocol(CommandEnum.scienceResearchInfor, getScienceResearchInforResult);
			_scienceResearchCallBack = callBack;
			var id:String = userInforProxy.userInfoVO.id;
			var obj:Object = {id:id};
			ConnDebug.send(CommandEnum.scienceResearchInfor,obj,ConnDebug.HTTP,URLRequestMethod.GET);
		}
		
		private function getScienceResearchInforResult(data:Object):void
		{
			Protocol.deleteProtocolFunction(CommandEnum.scienceResearchInfor, getScienceResearchInforResult);
			if(data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE,MultilanguageManager.getString(data.errors));
				_scienceResearchCallBack = null;
				return ;
			}
			_obj=data;
			changeData(data);
			
			if(_scienceResearchCallBack!= null)
				_scienceResearchCallBack();
			_scienceResearchCallBack = null;
		}
		
		public function researchUp(scienceType:int):void
		{
			var id:String = userInforProxy.userInfoVO.id;
			var obj:Object = {base_id:id,science_type:scienceType};
			ConnDebug.send(CommandEnum.researchUp,obj);
		}
		
		private function researchUpResult(data:Object):void
		{
			if(data.hasOwnProperty("error"))
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE,MultilanguageManager.getString(data.error));
				return ;
			}			
			
			changeData(data);
		}
		
		public function speedResearchUp(eventID:String,callBackFun:Function=null):void
		{
			_scienceResearchCallBack=callBackFun;
//			var id:String = userInforProxy.userInfoVO.id;
			var obj:Object = {research_event_id:eventID};
			ConnDebug.send(CommandEnum.speedResearchUp,obj);
		}
		
		private function speedResearchUpResult(data:Object):void
		{
			if(data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE,MultilanguageManager.getString(data.errors));
				return ;
			}
			
			userInforProxy.userInfoVO.dark_crystal=data.dark_crystal;
			changeData(data);
			
			if(_scienceResearchCallBack!=null)
				_scienceResearchCallBack();
			_scienceResearchCallBack=null;
		}
		
		public function researchReturn(scienceType:int):void
		{			
			type=scienceType;
			var id:String = userInforProxy.userInfoVO.id;
			var obj:Object = {base_id:id,science_type:scienceType};
			ConnDebug.send(CommandEnum.researchReturn,obj,ConnDebug.HTTP,URLRequestMethod.GET);
		}
		
		private function researchReturnResult(data:Object):void
		{
			if(data.hasOwnProperty("errors"))
			{
				sendNotification(PromptMediator.SCROLL_ALERT_NOTE,MultilanguageManager.getString(data.errors));
				return ;
			}
			
			userInforProxy.updateInfo();
			changeData(data);
			
			var userProxy:UserInfoProxy=getProxy(UserInfoProxy)
			if(type==ScienceEnum.NENG_YUAN_KE_JI&&userProxy.userInfoVO.index==TaskEnum.index15||
				type==ScienceEnum.JI_XIE_KE_JI&&userProxy.userInfoVO.index==TaskEnum.index16||
				type==ScienceEnum.CAI_JI_KE_JI&&userProxy.userInfoVO.index==TaskEnum.index17)
			{
				sendNotification(TaskCompleteCommand.TASKCOMPLETE_COMMAND);
			}
		} 
		
	/***********************************************************
	 *
	 * 功能方法
	 *
	 * ****************************************************/
		/**
		 * 通过科技中心等级获得科研的数目
		 * @param academyLevel
		 * @return 
		 * 
		 */		
		private function getResearchCountByAcademyLevel(academyLevel:int):int
		{
			var researchCount:int;
			if(academyLevel>=1 && academyLevel<10)
			{
				researchCount = 3;
			}
			else if(academyLevel>=10 &&　academyLevel<20)
			{
				researchCount = 6;
			}
			else if(academyLevel>=20 && academyLevel<30)
			{
				researchCount = 9;
			}
			else if(academyLevel>=30 && academyLevel<=40)
			{
				researchCount = 12;
			}
			return researchCount;
		}
		
		private function changeData(data:Object):void
		{
			userInforProxy.userInfoVO.broken_crysta=data.base.broken_crystal;
			userInforProxy.userInfoVO.tritium=data.base.tritium;
			userInforProxy.userInfoVO.crystal=data.base.crystal;
			userInforProxy.userInfoVO.dark_crystal=data.dark_crystal;
			
			var buildProxy:BuildProxy = getProxy(BuildProxy);
			
			//研究的数目
			var buildVO:BuildInfoVo=buildProxy.getBuild(BuildTypeEnum.KEJI);
			var researchCount:int=0;
			if(buildVO)
				researchCount = getResearchCountByAcademyLevel(buildVO.level);
			
			var contentProxy:ContentProxy = getProxy(ContentProxy);
//			var contentArr:Array = [];
//			contentArr = contentProxy.contentData.sciences;
			var scienceInforArr:Array = data.sciences;
			//组装后的新数组
//			var newScienceInforArr:Array = [];
//			newScienceInforArr = scienceInforArr.concat(contentArr.slice(scienceInforArr.length,researchCount-1));
			var arr:Array = [];
			var scienceResearchVO:ScienceResearchVO;
			
			var techDicObj:Object=ObjectUtil.CreateDic(scienceInforArr,"type");

			totalLevel=0;
			for(var i:int = 1;i<=researchCount;i++)
			{
				scienceResearchVO = new ScienceResearchVO();
				scienceResearchVO.science_type=i;				
				if(techDicObj[scienceResearchVO.science_type])
				{
					var techObj:Object=techDicObj[scienceResearchVO.science_type];
					scienceResearchVO.id = techObj.id;
					scienceResearchVO.level = techObj.level;
					scienceResearchVO.science_type = techObj.type;
					if(techObj.event)
					{
						scienceResearchVO.eventID=techObj.event.id;
						scienceResearchVO.current_time = techObj.event.current_time;
						scienceResearchVO.start_time =techObj.event.start_time;
						scienceResearchVO.finish_time = techObj.event.finish_time;
						scienceResearchVO.remainingTime = (scienceResearchVO.finish_time-scienceResearchVO.start_time) - (scienceResearchVO.current_time - scienceResearchVO.start_time);
						scienceResearchVO.finishTime = (scienceResearchVO.finish_time - scienceResearchVO.current_time)*1000 + DateFormatter.currentTime;
					}
					totalLevel+=scienceResearchVO.level;
				}
				
				var level:int = scienceResearchVO.level +1;
				scienceResearchVO.scienceName = ScienceEnum.getResearchNameByResearchType(scienceResearchVO.science_type);
				scienceResearchVO.scienceIconURL = ScienceEnum.getResearchIconURLByResearchType(scienceResearchVO.science_type);
				
				var tempTechVO:ScienceResearchVO=contentProxy.getScienceResearchInfo(scienceResearchVO.science_type,level);
				
				scienceResearchVO.academy_level = tempTechVO.academy_level;
				scienceResearchVO.command_center_level = tempTechVO.command_center_level;
				scienceResearchVO.broken_crystal = tempTechVO.broken_crystal;
				scienceResearchVO.crystal = tempTechVO.crystal;
				scienceResearchVO.time =tempTechVO.time;
				scienceResearchVO.tritium =tempTechVO.tritium;
				
				arr.push(scienceResearchVO);
			}
			reaearchList = arr;
		}
	}
}