package mediator.timeMachine
{
	import com.zn.multilanguage.MultilanguageManager;
	
	import enum.EventTypeEnum;
	
	import events.timeMachine.TimeMachineEvent;
	
	import mediator.BaseMediator;
	import mediator.WindowMediator;
	import mediator.prompt.MoneyAlertComponentMediator;
	import mediator.prompt.PromptSureMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import proxy.BuildProxy;
	import proxy.factory.FactoryProxy;
	import proxy.scienceResearch.ScienceResearchProxy;
	import proxy.timeMachine.TimeMachineProxy;
	import proxy.userInfo.UserInfoProxy;
	
	import view.timeMachine.TimeMachineComponent;

	/**
	 *时间机器
	 * @author lw
	 *
	 */
	public class TimeMachineComponentMediator extends WindowMediator implements IMediator
	{
		public static const NAME:String="TimeMachineComponentMediator";

		public static const SHOW_NOTE:String="show" + NAME + "Note";

		public static const DESTROY_NOTE:String="destroy" + NAME + "Note";

		public function TimeMachineComponentMediator()
		{
			super(NAME, new TimeMachineComponent());
			comp.med=this;
			level=1;
			
			comp.addEventListener(TimeMachineEvent.ALL_SPEED_EVENT,allSpeedHandler);
			comp.addEventListener(TimeMachineEvent.CLOSE_EVENT,closeHandler);
			comp.addEventListener(TimeMachineEvent.SHOW_INFOR_COMPONENT_EVENT,showInforComponetHandler);
			comp.addEventListener(TimeMachineEvent.SPEED_EVENT,speedHandler);
		}
		
		/**
		 *添加要监听的消息
		 * @return
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [DESTROY_NOTE];
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
		protected function get comp():TimeMachineComponent
		{
			return viewComponent as TimeMachineComponent;
		}

		private function allSpeedHandler(event:TimeMachineEvent):void
		{
			event.stopImmediatePropagation();
			var userInforProxy:UserInfoProxy = getProxy(UserInfoProxy);
			if(userInforProxy.userInfoVO.vip_speed>0&&userInforProxy.userInfoVO.vip_speed<event.idType)//此时传的idtaye为加速的条数
			{
				var obj1:Object={};
				obj1.showLable="免费加速数量不足，请单条加速！";
				sendNotification(PromptSureMediator.SHOW_NOTE,obj1);
			}else
			{
				var str:String = MultilanguageManager.getString("totalEvent");
				var obj:Object = {title:MultilanguageManager.getString("jiaSu"),info:str,count:event.count,okCallBack:function():void
				{
		        	var timeMachineProxy:TimeMachineProxy = getProxy(TimeMachineProxy);
					timeMachineProxy.allSpeed(userInforProxy.userInfoVO.id);
				}};
				
				sendNotification(MoneyAlertComponentMediator.SHOW_NOTE,obj);				
			}
			
		}
		
		private function showInforComponetHandler(event:TimeMachineEvent):void
		{
			event.stopImmediatePropagation();
			sendNotification(TimeMachineInforComponentMediator.SHOW_NOTE);
		}
		
		private function speedHandler(event:TimeMachineEvent):void
		{
			event.stopImmediatePropagation();
			var inforString:String = MultilanguageManager.getString("thisEvent");
			var obj:Object = {title:MultilanguageManager.getString("jiaSu"),info:inforString,count:event.count,okCallBack:function():void
			{
				if(event.item.data.type==EventTypeEnum.BUILDINGEVENTSTYPE)
				{
					var builderProxy:BuildProxy = getProxy(BuildProxy);
					builderProxy.speedUpBuild(event.idType,function():void
					{
						comp.clearContainer(event.item,event.item.data.crystalCount);										
					});
				}else if(event.item.data.type==EventTypeEnum.RESEARCHEVENTSTYPE)
				{
					var scienceProxy:ScienceResearchProxy=getProxy(ScienceResearchProxy);
					scienceProxy.speedResearchUp(event.item.data.eventID,function():void
					{
						comp.clearContainer(event.item,event.item.data.crystalCount);					
					});
				}else if(event.item.data.type==EventTypeEnum.PRODUCEEVENTSTYPE)
				{
					var factoryProxy:FactoryProxy=getProxy(FactoryProxy);
					factoryProxy.produce_speed_up(event.item.data.eventID,function():void
					{
						comp.clearContainer(event.item,event.item.data.crystalCount);
					});
				}
					
			}};
			
			sendNotification(MoneyAlertComponentMediator.SHOW_NOTE,obj);
		}
	}
}